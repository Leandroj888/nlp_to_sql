from typing import Any
from flask import json, jsonify
from opensearchpy import OpenSearch, RequestsHttpConnection, helpers
from app.application.ports.fts_port import FtsPort
from app.domain.table_fts import TableFts
from constants import Constants


class OpenSearchAdapter(FtsPort):
    client: OpenSearch

    def __init__(self):
        self.client = OpenSearch(
            hosts=[{'host': Constants.OPENSEARCH_HOST, 'port': Constants.OPENSEARCH_PORT}],
            http_auth=Constants.OPENSEARCH_AUTH,
            use_ssl=Constants.OPENSEARCH_SSL,
            verify_certs=Constants.OPENSEARCH_CERTS,
            connection_class=RequestsHttpConnection,
            timeout=300
        )

    def index_exists(self) -> bool:
        return self.client.indices.exists(index=Constants.OPENSEARCH_INDEX)
    
    def index_remove(self) -> None:
        self.client.indices.delete(index=Constants.OPENSEARCH_INDEX)
        print(f"Índice '{Constants.OPENSEARCH_INDEX}' deletado com sucesso!")  

    def index_create(self, body: Any) -> str:
        response = self.client.indices.create(index=Constants.OPENSEARCH_INDEX, body=body)
        print(response)
        return response
    
    def document_remove(self, id:str) -> None:
        self.client.delete(index=Constants.OPENSEARCH_INDEX, id=id)
    
    def document_add(self, doc):
        self.client.index(index=Constants.OPENSEARCH_INDEX, body=json.dumps(doc))
        
    def document_batch(self, batch):
        helpers.bulk(self.client, [
            {
                "_index": Constants.OPENSEARCH_INDEX,
                "_source": file
            }
            for file in batch
        ])

    def search_table(self, table: str) -> TableFts:
        body= {
            "query": {
                "match_phrase": {
                    "table": table
                }
            }
        }    

        hits = self._search(body, 1)

        if len(hits) == 0:
            return TableFts()
        
        return TableFts(hits[0]['_id'], hits[0]['_source']['md5'])

    def search_text(self, user_query: str, top_k:int = Constants.OPENSEARCH_K):
        body={
            "size": top_k,
            "query": {
                "query_string": {
                    "query": user_query
                }
            }
        }

        hits = self._search(body, top_k)
        return [hit['_source'] for hit in hits]

    def search_vector(self, query_vector: str, top_k:int = Constants.OPENSEARCH_K):
        body={
            "size": top_k,
            "query": {
                "knn": {
                    "vector_field": {
                        "vector": query_vector,
                        "k": top_k
                    }
                }
            }
        }

        hits = self._search(body, top_k)
        return [hit['_source'] for hit in hits]
    
    def _search(self, body: str, top_k:int = Constants.OPENSEARCH_K):
        response = self.client.search(
            index=Constants.OPENSEARCH_INDEX,
            body=body
        )
        return response['hits']['hits']

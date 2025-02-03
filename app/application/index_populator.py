from flask import jsonify
from app.application.index_generator import IndexGenerator
from app.application.ports.fts_port import FtsPort
from app.application.ports.llm_port import LlmPort
from app.application.keyword_generator import KeywordGenerator
from app.domain.table_info import TableInfo
from constants import Constants
import os
from tqdm import tqdm


class IndexPopulator:
    def __init__(self, fts: FtsPort, llm: LlmPort):
        self.fts = fts
        self.llm = llm
        self.batch = []
        self.keyword = KeywordGenerator(llm)

    def populator_index(self) -> str:
        if not self.fts.index_exists():
            generator = IndexGenerator(self.fts)
            generator.generate_index()

        directory_path = self._retrieved_directory_path()
        filenames = sorted(os.listdir(directory_path))

        for filename in tqdm(filenames, desc="Processando arquivos", unit="arquivo"):
            file_path = os.path.join(directory_path, filename)
            table_info = TableInfo(file_path)
            table_index = self.fts.search_table(table_info.table)

            if not table_index.md5 == "" and not table_index.md5 == table_info.md5:
                self.fts.document_remove(table_index.id) 

            if not table_index.md5 == "":
                continue

            table_info.insert_key(self.keyword.generate_key(table_info.description))   

            if(Constants.FILE_PROCESS_LOTE):
                self.batch.append(table_info.__dict__)
                if (len(self.batch) >= 100):
                    self.fts.document_batch(self.batch)
                    self.batch=[]
            else:
                self.fts.document_add(table_info.__dict__)
 
    def _retrieved_directory_path(self) -> str:
        current_dir = os.path.dirname(os.path.abspath(__file__))
        return os.path.join(current_dir, "..", "..", Constants.FILE_DIRECTORY)
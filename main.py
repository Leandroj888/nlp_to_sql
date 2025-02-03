import time
from flask import Flask, request, jsonify
from app.application.index_generator import IndexGenerator
from app.application.index_populator import IndexPopulator
from app.application.sql_generator import SqlGenerator
from app.infra.lmstudio_adapter import LmStudioAdapter
from app.infra.opensearch_adapter import OpenSearchAdapter

app = Flask(__name__)

@app.route('/create_index', methods=['POST'])
def create_and_populator_index():
    fts = OpenSearchAdapter()
    llm = LmStudioAdapter()
    generator = IndexGenerator(fts)
    generator.generate_index()
    populator = IndexPopulator(fts,llm)
    populator.populator_index()
    return jsonify({"message": "Índice criado e documentos indexados com sucesso!"})

@app.route('/update_index', methods=['POST'])
def update_index():
    fts = OpenSearchAdapter()
    llm = LmStudioAdapter()
    populator = IndexPopulator(fts,llm)
    populator.populator_index()
    return jsonify({"message": "Índice atualizado com sucesso!"})

@app.route('/generate_sql', methods=['POST'])
def generate_sql():
    fts = OpenSearchAdapter()
    generate = SqlGenerator(LmStudioAdapter())
    response = ""
    start_time = time.time()
    question = request.json.get("question")
    retrieved_docs = fts.search_text(question)
    response['message'] = generate.generate_sql(question, retrieved_docs)
    end_time = time.time()
    duration_ms = (end_time - start_time) * 1000
    print(f"Duração: {duration_ms:.2f} milissegundos")
    response['duration'] = duration_ms
    return response


'''
# Endpoint 1: Criar e alimentar o índice
@app.route('/create_index', methods=['POST'])
def create_and_feed_index():
    opensearch = OpensearchAdapter()
    files = Files()
    opensearch.create_index()
    files.process_sql_files()
    return jsonify({"message": "Índice criado e documentos indexados com sucesso!"})




@app.route('/bedrock/search_vector', methods=['POST'])
def search_vector():
    start_time = time.time()
    query = request.json.get("query")
    search = Search()
    response = search.rag_pipeline(query, True)
    end_time = time.time()
    duration_ms = (end_time - start_time) * 1000
    print(f"Duração: {duration_ms:.2f} milissegundos")
    response['duration'] = duration_ms
    return response

@app.route('/bedrock/search', methods=['POST'])
def search():
    start_time = time.time()
    query = request.json.get("query")
    search = Search()
    response = search.rag_pipeline(query, False)
    end_time = time.time()
    duration_ms = (end_time - start_time) * 1000
    print(f"Duração: {duration_ms:.2f} milissegundos")
    response['duration'] = duration_ms
    return response

@app.route('/lmstudio/search', methods=['POST'])
def search_lmstudio():
    opensearch = OpensearchAdapter()
    llm = LmStudio()
    response = ""

    start_time = time.time()
    question = request.json.get("question")
    retrieved_docs = opensearch.search_opensearch(question)
    response['message'] = llm.generate_sql(question, retrieved_docs)
    end_time = time.time()
    duration_ms = (end_time - start_time) * 1000
    print(f"Duração: {duration_ms:.2f} milissegundos")
    response['duration'] = duration_ms
    return response
'''


# Rodar o servidor Flask
if __name__ == '__main__':
    app.run(debug=False)

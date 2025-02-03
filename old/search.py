import json

class Search():
    
    embedding_model = 'amazon.titan-embed-text-v2:0'
    input_text_count = 0



    # Cliente do Bedrock
    #bedrock_client = session.client('bedrock-runtime')

    # Função para gerar embeddings com Bedrock
    # igual do opesearch_adapter
    def generate_embedding(self, text, model_id=embedding_model):
        return text
        '''
        response = self.bedrock_client.invoke_model(
            modelId=model_id,
            body=json.dumps({"inputText": text}),
            contentType='application/json',
            accept='application/json'
        )
        result = json.loads(response['body'].read().decode('utf-8'))
        self.input_text_count = int(result['inputTextTokenCount'])
        print ("inputTextTokenCount (vectorembeding): " + str(self.input_text_count))
        return result['embedding']
        '''

        


    # Função para invocar o Bedrock
    def generate_bedrock_response(self, prompt, model_id='anthropic.claude-3-5-sonnet-20240620-v1:0', max_tokens=2000):
        return prompt
        '''
        response = self.bedrock_client.invoke_model(
            modelId=model_id,
            body=json.dumps({
                "anthropic_version": "bedrock-2023-05-31",
                "max_tokens": 2000,
                "temperature": 1,
                "top_k": 250,
                "top_p": 0.999,
                "stop_sequences": [],
                "messages": [
                    {
                        "role": "user",
                        "content": [
                            {
                                "type": "text",
                                "text": prompt 
                            }
                        ]
                    }
                ]
            }),
            contentType='application/json',
            accept='application/json'
        )
        result = json.loads(response['body'].read().decode('utf-8'))
        print ("inputTextTokenCount: " + str(result["usage"]['input_tokens']))
        print ("outputTextTokenCount: " + str(result["usage"]['output_tokens']))

        result["usage"]['input_tokens'] = self.input_text_count + int(result["usage"]['input_tokens'])
        return result
        '''

    # Pipeline RAG
    def rag_pipeline(self, user_query, vector):
        if(vector):
            # Passo 1: Gerar o embedding da consulta
            query_vector = self.generate_embedding(user_query)
            # Passo 2: Realizar busca vetorial no OpenSearch
            retrieved_docs = self.opensearch.search_opensearch_vector(query_vector)
        else:
            # Passo 1/2: Realizar busca no OpenSearch
            retrieved_docs = self.opensearch.search_opensearch(user_query)

        context = "\n".join([doc['text'] for doc in retrieved_docs])  # Substitua 'content' pelo campo de texto

        # Passo 3: Construir o prompt para o Bedrock
        prompt = f"""
            Você é um assistente de perguntas e respostas especializado na criação de comandos SQL para o banco de dados PostgreSQL.

            O nome da aplicação para a qual você está gerando comandos SQL é chamada de "suite", "se suite", "se-suite", "sesuite" ou "softexpert".

            **Regras de Resposta**:
            1. Se o contexto fornecido é suficiente, gere uma query SQL válida para responder à pergunta.
            2. Encapsule a query SQL gerada dentro de uma tag `<sql>` e `<summary>`:
               - Use `<sql>` para incluir a query.
               - Use `<summary>` para descrever o que a query faz, em uma frase simples.
            3. Caso o contexto fornecido não seja suficiente, use `<error>` para encapsular a mensagem explicando o motivo.
            4. Nunca utilize nomes de campos que não foram fornecidos no contexto.
            5. A query gerada deve seguir boas práticas de performance para o PostgreSQL.
            6. Evite fazer conversões de tipos de dados a menos que seja absolutamente necessário. Se for necessário, use as funções adequadas do PostgreSQL, como `CAST` ou `CONVERT` de forma correta.
            8. Todos os campos do SELECT devem possuir alias para evitar ambiguidades e melhorar a legibilidade. Os alias devem ser curtos, em camelCase, descritivos e diretamente relacionados à operação realizada ou ao campo representado. Por exemplo, no caso de COUNT(*), o alias deve ser algo como countUsers.
            9. **Proibições:**
               - A Query não poderá conter comandos além de SELECT.
               - A Query não poderá terminar com ponto e vírgula (;).
               - A Query não poderá conter ORDER BY.
               - A query não poderá conter nenhum tipo de comentário SQL (seja -- ou /* */).
            **Exemplos de saída esperada:**
            1. Para uma query válida:
                <sql>
                SELECT column1 as col1, column2 as col2 FROM table_name WHERE condition;
                </sql>

            2. Para uma situação onde o contexto é insuficiente:
                <error>
                O contexto fornecido não é suficiente para gerar uma query válida. Por favor, forneça mais informações sobre as tabelas ou colunas necessárias.
                </error>

            Use as seguintes peças de contexto para gerar a query SQL:
            {context}
            
            Pergunta:
            {user_query}

            Resposta:
        """

        # Passo 4: Gerar resposta usando o Bedrock
        response = self.generate_bedrock_response(prompt)
        return response

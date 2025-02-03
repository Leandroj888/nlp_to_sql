from app.application.ports.llm_port import LlmPort


class SqlGenerator:
    def __init__(self, llm: LlmPort):
        self.llm = llm

    def generate_sql(self, question: str, retrieved_docs: list[dict]) -> str:
        context = "\n".join([doc['text'] for doc in retrieved_docs])

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
            {question}

            Resposta:
        """

        return self.llm.call(prompt, 0)
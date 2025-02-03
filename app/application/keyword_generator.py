from app.application.ports.llm_port import LlmPort


class KeywordGenerator:
    def __init__(self, llm: LlmPort):
        self.llm = llm

    def generate_key(self, description: str) -> str:
        prompt = f'''
            Você é um extrator de palavras. Siga as seguintes regras:

            1. Liste as palavras separadas única e exclusivamente por vírgulas, sem espaços, nunca use espaços para separar a palavra apenas vírgulas.
            2. Use apenas as palavras da frase: "{description}"
            3. Coloque as palavras em ordem de relevância, sendo a primeira mais relevante.
            4. Não forneça explicações adicionais.
            5. Não repita palavras.
            6. Ignore palavras comuns ("e", "ter", "podem") ou conectores e preposições (como "pelos", "as", etc.).
            7. As seguintes palavras devem ter uma relevância bem menor que outras: (tabela, armazena, sistema)
        '''

        text = self.llm.call(prompt, 0)
        words = text.split(", ")
       
        return words
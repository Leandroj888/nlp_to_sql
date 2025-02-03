from openai import OpenAI
from app.application.ports.llm_port import LlmPort
from constants import Constants

class LmStudioAdapter(LlmPort):
    client: OpenAI
    model = Constants.LLM_MODEL

    def __init__(self):
        url = f"http://{Constants.LLM_HOST}:{Constants.LLM_PORT}/v1"
        self.client = OpenAI(base_url=url, api_key="lm-studio")

    def call(self, prompt: str, temperature: float = 0.7, model:str = Constants.LLM_MODEL) -> str:
        response = self.client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            temperature=temperature
        )
        return response.choices[0].message.content
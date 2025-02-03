from abc import ABC, abstractmethod

class LlmPort(ABC):
    @abstractmethod
    def call(self, prompt: str, temperature: float, model:str) -> str:
        pass
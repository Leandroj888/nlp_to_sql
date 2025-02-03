from abc import ABC, abstractmethod
from typing import Any

from app.domain.table_fts import TableFts

class FtsPort(ABC):
    @abstractmethod
    def index_exists(self) -> bool:
        pass

    @abstractmethod
    def index_remove(self) -> None:
        pass

    @abstractmethod
    def index_create(self, body: Any) -> str:
        pass

    @abstractmethod
    def search_text(self, user_query: str, top_k:int):
        pass

    @abstractmethod
    def search_table(self, table: str) -> TableFts:
        pass

    @abstractmethod
    def search_vector(self, query_vector: str, top_k:int):
        pass

    @abstractmethod
    def document_add(self, doc):
        pass

    @abstractmethod
    def document_remove(self, id: str):
        pass

    @abstractmethod
    def document_batch(self, batch):
        pass
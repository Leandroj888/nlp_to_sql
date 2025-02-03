import json
import os
from flask import jsonify
from app.application.ports.fts_port import FtsPort

class IndexGenerator:
    def __init__(self, fts: FtsPort):
        self.fts = fts

    def generate_index(self) -> str:
        if self.fts.index_exists():
            try:
                self.fts.index_remove()
            except Exception as e:
                return jsonify({"error": str(e)}), 500
        
        try:
            response = self.fts.index_create(self._get_index())
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        
        print('\nCreating index:')
        print(response)

    def _get_index(self) -> str:
        current_dir = os.path.dirname(os.path.abspath(__file__))
        config_path = os.path.join(current_dir, "..", "domain", "index_config.json")
        index_config = ""

        with open(config_path, "r", encoding="utf-8") as file:
            index_config = json.load(file)

        return index_config
import hashlib
import os
import re


class TableInfo:
    table: str = ""
    description: str = ""
    fields: str = ""
    components = []
    md5: str = ""
    text: str = ""
    key = []


    def __init__(self, file_path: str):
        self._extract_table_info(file_path)

    def _extract_table_info(self, file_path):
        table_info = ""
        if os.path.isfile(file_path):   
            with open(file_path, 'r', encoding='utf-8') as file:
                content = file.read()

            table_match = re.search(r'CREATE TABLE\s+([\w\d_]+)\s*\(', content, re.IGNORECASE)
            table_name = table_match.group(1) if table_match else ""

            # Extrair a descrição da tabela
            description_match = re.search(r'--(.*?)\n', content)
            description = description_match.group(1).strip() if description_match else ""

            # Extrair os campos e suas descrições
            fields = []
            field_pattern = re.compile(r'(\w+)\s+(\w+).*?--(.*?)$', re.MULTILINE)
            for match in field_pattern.finditer(content):
                field_name = match.group(1)
                field_description = match.group(3).strip()
                fields.append({"name": field_name, "description": field_description})    

            self.table = table_name
            self.description = description
            self.fields = fields
            self.components = [{"name": "analytics"}]
            self.md5 = hashlib.md5(content.encode('utf-8')).hexdigest()
            self.text = content
        
        return table_info
    
    def insert_key(self, keys):
        self.key = ", ".join([f"{word}^{10 - i}" for i, word in enumerate(keys[:10])])
    
    def __str__(self):
        return {
            "table": self.table,
            "description": self.description,
            "fields": self.fields,
            "components": self.components,  
            "md5": self.md5,
            "text": self.text,
            "key": self.key
        }
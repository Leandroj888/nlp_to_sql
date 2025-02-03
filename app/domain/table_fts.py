class TableFts:
    def __init__(self, id: str = "", md5: str = ""):
        self.id = id
        self.md5 = md5

    def to_dict(self):
        return {'id': self.id, 'md5': self.md5}
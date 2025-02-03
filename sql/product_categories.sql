-- Armazena as categorias de produtos.
CREATE TABLE product_categories (
    id SERIAL PRIMARY KEY, -- Identificador único da categoria.
    name VARCHAR(100) UNIQUE NOT NULL, -- Nome da categoria.
    description TEXT -- Descrição da categoria.
);
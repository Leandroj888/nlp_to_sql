-- Armazena as informações dos produtos disponíveis no sistema.
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do produto.
    name VARCHAR(100) NOT NULL, -- Nome do produto.
    description TEXT, -- Descrição detalhada do produto.
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0), -- Preço do produto (não negativo).
    stock INT NOT NULL CHECK (stock >= 0), -- Quantidade disponível em estoque.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do produto.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização das informações do produto.
);
-- Armazena o estoque de produtos em diferentes locais.
CREATE TABLE inventory (
    id SERIAL PRIMARY KEY, -- Identificador único do registro de estoque.
    product_id UUID NOT NULL, -- Produto armazenado.
    location VARCHAR(100) NOT NULL, -- Localização do estoque (exemplo: Depósito Central).
    quantity INT NOT NULL CHECK (quantity >= 0), -- Quantidade disponível no local.
    last_updated TIMESTAMP DEFAULT NOW(), -- Última atualização do estoque.
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
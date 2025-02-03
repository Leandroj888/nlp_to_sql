-- Armazena os itens adquiridos em uma compra.
CREATE TABLE purchase_items (
    id SERIAL PRIMARY KEY, -- Identificador único do item na compra.
    purchase_id UUID NOT NULL, -- Compra associada ao item.
    product_id UUID NOT NULL, -- Produto adquirido.
    quantity INT NOT NULL CHECK (quantity > 0), -- Quantidade adquirida.
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0), -- Preço unitário do produto.
    CONSTRAINT fk_purchase_items_purchase FOREIGN KEY (purchase_id) REFERENCES purchases(id) ON DELETE CASCADE,
    CONSTRAINT fk_purchase_items_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

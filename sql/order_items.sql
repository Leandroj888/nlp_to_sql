-- Armazena os itens individuais dentro de cada pedido.
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY, -- Identificador único do item no pedido.
    order_id UUID NOT NULL, -- Pedido ao qual o item pertence.
    product_id UUID NOT NULL, -- Produto incluído no pedido.
    quantity INT NOT NULL CHECK (quantity > 0), -- Quantidade do produto no pedido.
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0), -- Preço unitário do produto no pedido.
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0), -- Valor total do item no pedido (quantidade * preço unitário).
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);
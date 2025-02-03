-- Armazena as avaliações feitas pelos clientes.
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY, -- Identificador único da avaliação.
    customer_id UUID NOT NULL, -- Cliente que realizou a avaliação.
    product_id UUID NOT NULL, -- Produto avaliado.
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- Nota de 1 a 5.
    comment TEXT, -- Comentário do cliente.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação da avaliação.
    CONSTRAINT fk_reviews_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_reviews_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
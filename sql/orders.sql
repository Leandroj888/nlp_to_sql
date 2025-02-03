-- Registra os pedidos feitos pelos clientes.
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do pedido.
    user_id UUID NOT NULL, -- Usuário que fez o pedido.
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0), -- Valor total do pedido.
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente', -- Status do pedido (exemplo: Pendente, Pago, Cancelado).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do pedido.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do pedido.
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
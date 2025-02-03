-- Armazena os pagamentos realizados pelos clientes.
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do pagamento.
    order_id UUID NOT NULL, -- Pedido associado ao pagamento.
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0), -- Valor pago.
    payment_method VARCHAR(50) NOT NULL, -- Método de pagamento (exemplo: Cartão, Boleto, Pix).
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente', -- Status do pagamento (exemplo: Pendente, Aprovado, Cancelado).
    paid_at TIMESTAMP, -- Data e hora do pagamento, caso aprovado.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do pagamento.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do pagamento.
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
-- Armazena as ordens de envio para os pedidos.
CREATE TABLE shipments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do envio.
    order_id UUID NOT NULL, -- Pedido associado ao envio.
    tracking_number VARCHAR(50) UNIQUE, -- Número de rastreamento.
    carrier VARCHAR(100), -- Transportadora responsável.
    status VARCHAR(20) NOT NULL DEFAULT 'Em processamento', -- Status do envio (exemplo: Em processamento, Enviado, Entregue).
    estimated_delivery DATE, -- Data estimada de entrega.
    shipped_at TIMESTAMP, -- Data de envio real.
    delivered_at TIMESTAMP, -- Data de entrega real.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do registro.
    CONSTRAINT fk_shipments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- Armazena as reclamações registradas pelos clientes.
CREATE TABLE complaints (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único da reclamação.
    customer_id UUID NOT NULL, -- Cliente que fez a reclamação.
    description TEXT NOT NULL, -- Descrição detalhada da reclamação.
    status VARCHAR(20) NOT NULL DEFAULT 'Aberto', -- Status da reclamação (exemplo: Aberto, Em análise, Resolvido).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação da reclamação.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização da reclamação.
    CONSTRAINT fk_complaints_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
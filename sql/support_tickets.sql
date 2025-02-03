-- Armazena as solicitações de suporte dos clientes.
CREATE TABLE support_tickets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do chamado.
    customer_id UUID NOT NULL, -- Cliente que abriu o chamado.
    subject VARCHAR(150) NOT NULL, -- Assunto do chamado.
    description TEXT NOT NULL, -- Descrição detalhada do problema.
    status VARCHAR(20) NOT NULL DEFAULT 'Aberto', -- Status do chamado (exemplo: Aberto, Em andamento, Resolvido).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de abertura do chamado.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do chamado.
    CONSTRAINT fk_tickets_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
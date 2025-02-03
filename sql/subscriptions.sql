-- Armazena as assinaturas ativas dos clientes.
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único da assinatura.
    customer_id UUID NOT NULL, -- Cliente que assinou o plano.
    plan_id INT NOT NULL, -- Plano de assinatura escolhido.
    start_date DATE NOT NULL, -- Data de início da assinatura.
    end_date DATE, -- Data de término da assinatura (caso cancelada).
    status VARCHAR(20) NOT NULL DEFAULT 'Ativo', -- Status da assinatura (exemplo: Ativo, Cancelado).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação da assinatura.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização da assinatura.
    CONSTRAINT fk_subscriptions_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_subscriptions_plan FOREIGN KEY (plan_id) REFERENCES subscription_plans(id) ON DELETE CASCADE
);
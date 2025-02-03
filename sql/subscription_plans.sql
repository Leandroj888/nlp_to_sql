-- Armazena os planos de assinatura disponíveis no sistema.
CREATE TABLE subscription_plans (
    id SERIAL PRIMARY KEY, -- Identificador único do plano de assinatura.
    name VARCHAR(100) NOT NULL, -- Nome do plano.
    description TEXT, -- Descrição do plano.
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0), -- Preço mensal do plano.
    billing_cycle VARCHAR(20) NOT NULL DEFAULT 'Mensal', -- Ciclo de faturamento (exemplo: Mensal, Anual).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do plano.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do plano.
);
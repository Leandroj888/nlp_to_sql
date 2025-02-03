-- Armazena os contratos firmados com clientes ou fornecedores.
CREATE TABLE contracts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do contrato.
    title VARCHAR(150) NOT NULL, -- Título ou descrição breve do contrato.
    party_1 VARCHAR(100) NOT NULL, -- Nome da primeira parte envolvida no contrato.
    party_2 VARCHAR(100) NOT NULL, -- Nome da segunda parte envolvida no contrato.
    contract_date DATE NOT NULL, -- Data de assinatura do contrato.
    expiration_date DATE, -- Data de expiração do contrato (caso aplicável).
    value DECIMAL(15,2) NOT NULL CHECK (value >= 0), -- Valor do contrato.
    status VARCHAR(20) NOT NULL DEFAULT 'Ativo', -- Status do contrato (exemplo: Ativo, Expirado).
    document TEXT, -- URL ou referência para o documento do contrato.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do contrato.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do contrato.
);
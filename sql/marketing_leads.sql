-- Armazena os leads captados pela equipe de marketing.
CREATE TABLE marketing_leads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do lead.
    name VARCHAR(100) NOT NULL, -- Nome do lead.
    email VARCHAR(150) UNIQUE NOT NULL, -- E-mail do lead.
    phone VARCHAR(20), -- Telefone de contato.
    source VARCHAR(50) NOT NULL, -- Origem do lead (exemplo: Site, Anúncio, Indicação).
    status VARCHAR(20) NOT NULL DEFAULT 'Novo', -- Status do lead (exemplo: Novo, Em negociação, Convertido).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do lead.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do lead.
);
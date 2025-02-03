-- Armazena os registros de conformidade com normas e regulamentos.
CREATE TABLE compliance_records (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do registro.
    title VARCHAR(150) NOT NULL, -- Título do registro de conformidade.
    description TEXT NOT NULL, -- Descrição detalhada do registro.
    compliance_date DATE NOT NULL, -- Data do evento de conformidade.
    status VARCHAR(20) NOT NULL DEFAULT 'Em conformidade', -- Status do registro (exemplo: Em conformidade, Pendente).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do registro.
);
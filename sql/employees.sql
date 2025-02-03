-- Armazena os funcionários da empresa.
CREATE TABLE employees (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do funcionário.
    name VARCHAR(100) NOT NULL, -- Nome completo do funcionário.
    email VARCHAR(150) UNIQUE NOT NULL, -- E-mail corporativo do funcionário.
    phone VARCHAR(20), -- Telefone de contato do funcionário.
    position VARCHAR(100) NOT NULL, -- Cargo do funcionário na empresa.
    salary DECIMAL(10,2) NOT NULL CHECK (salary >= 0), -- Salário do funcionário.
    hired_at DATE NOT NULL, -- Data de contratação.
    status VARCHAR(20) NOT NULL DEFAULT 'Ativo', -- Status do funcionário (exemplo: Ativo, Demitido).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do registro.
);
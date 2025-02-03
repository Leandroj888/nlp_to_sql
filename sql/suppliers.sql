-- Armazena os fornecedores da empresa.
CREATE TABLE suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do fornecedor.
    name VARCHAR(150) NOT NULL, -- Nome do fornecedor.
    email VARCHAR(150) UNIQUE, -- E-mail do fornecedor.
    phone VARCHAR(20), -- Telefone de contato.
    address TEXT, -- Endereço do fornecedor.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do registro.
);
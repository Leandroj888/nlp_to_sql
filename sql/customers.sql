-- Armazena as informações dos clientes da empresa.
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do cliente.
    name VARCHAR(100) NOT NULL, -- Nome completo do cliente.
    email VARCHAR(150) UNIQUE NOT NULL, -- E-mail de contato do cliente.
    phone VARCHAR(20), -- Número de telefone do cliente.
    address TEXT, -- Endereço do cliente.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do registro.
);
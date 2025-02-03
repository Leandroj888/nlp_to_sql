-- Armazena as informações dos usuários.
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do usuário.
    name VARCHAR(100) NOT NULL, -- Nome completo do usuário.
    email VARCHAR(150) UNIQUE NOT NULL, -- Endereço de e-mail único para login.
    password_hash TEXT NOT NULL, -- Senha armazenada de forma segura (hash).
    role_id INT NOT NULL, -- Referência para o papel do usuário.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do registro.
);

-- Definição de chaves estrangeiras para manter integridade referencial.
ALTER TABLE users ADD CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT;

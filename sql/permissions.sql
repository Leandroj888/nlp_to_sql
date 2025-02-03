-- Armazena as permissões dos usuários no sistema.
CREATE TABLE permissions (
    id SERIAL PRIMARY KEY, -- Identificador único da permissão.
    name VARCHAR(100) UNIQUE NOT NULL, -- Nome da permissão (exemplo: Gerenciar Usuários, Ver Relatórios).
    description TEXT -- Descrição detalhada da permissão.
);
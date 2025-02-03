-- Define os diferentes papéis que os usuários podem ter.
CREATE TABLE roles (
    id SERIAL PRIMARY KEY, -- Identificador único do papel.
    name VARCHAR(50) UNIQUE NOT NULL -- Nome do papel (exemplo: Admin, Cliente, Funcionário).
);
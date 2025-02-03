-- Armazena os registros de acessos ao sistema.
CREATE TABLE access_logs (
    id SERIAL PRIMARY KEY, -- Identificador único do log de acesso.
    user_id UUID NOT NULL, -- Usuário que acessou o sistema.
    ip_address VARCHAR(45) NOT NULL, -- Endereço IP do acesso.
    user_agent TEXT, -- Informações do dispositivo utilizado.
    login_time TIMESTAMP DEFAULT NOW(), -- Data e hora do login.
    logout_time TIMESTAMP, -- Data e hora do logout.
    CONSTRAINT fk_access_logs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);
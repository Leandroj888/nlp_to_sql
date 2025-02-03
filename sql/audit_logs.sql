-- Armazena os registros de auditoria para rastrear alterações no sistema.
CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY, -- Identificador único do log.
    user_id UUID NOT NULL, -- Usuário que realizou a ação.
    action VARCHAR(150) NOT NULL, -- Ação realizada (exemplo: Criou pedido, Atualizou estoque).
    details TEXT, -- Detalhes adicionais sobre a ação.
    created_at TIMESTAMP DEFAULT NOW(), -- Data e hora do evento.
    CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);
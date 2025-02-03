-- Relaciona usuários às permissões atribuídas.
CREATE TABLE user_permissions (
    user_id UUID NOT NULL, -- Usuário que recebeu a permissão.
    permission_id INT NOT NULL, -- Permissão concedida.
    PRIMARY KEY (user_id, permission_id),
    CONSTRAINT fk_user_permissions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_permissions_permission FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
);
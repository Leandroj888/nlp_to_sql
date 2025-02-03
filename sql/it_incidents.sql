-- Armazena os tickets de incidentes de TI.
CREATE TABLE it_incidents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do incidente.
    reported_by UUID NOT NULL, -- Usuário que reportou o incidente.
    description TEXT NOT NULL, -- Descrição detalhada do problema.
    priority VARCHAR(20) NOT NULL DEFAULT 'Média', -- Prioridade do incidente (exemplo: Baixa, Média, Alta).
    status VARCHAR(20) NOT NULL DEFAULT 'Aberto', -- Status do incidente (exemplo: Aberto, Em andamento, Resolvido).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de abertura do incidente.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do incidente.
    CONSTRAINT fk_it_incidents_user FOREIGN KEY (reported_by) REFERENCES users(id) ON DELETE SET NULL
);
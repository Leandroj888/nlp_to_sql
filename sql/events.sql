-- Armazena eventos agendados no calendário corporativo.
CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do evento.
    title VARCHAR(150) NOT NULL, -- Título do evento.
    description TEXT, -- Descrição do evento.
    start_time TIMESTAMP NOT NULL, -- Data e hora de início.
    end_time TIMESTAMP NOT NULL, -- Data e hora de término.
    location VARCHAR(100), -- Local do evento.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do evento.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do evento.
);
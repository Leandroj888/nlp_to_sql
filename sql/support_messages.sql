-- Armazena as interações dentro de um chamado de suporte.
CREATE TABLE support_messages (
    id SERIAL PRIMARY KEY, -- Identificador único da mensagem.
    ticket_id UUID NOT NULL, -- Chamado de suporte relacionado.
    sender VARCHAR(50) NOT NULL, -- Quem enviou a mensagem (exemplo: Cliente, Suporte).
    message TEXT NOT NULL, -- Conteúdo da mensagem.
    sent_at TIMESTAMP DEFAULT NOW(), -- Data e hora do envio.
    CONSTRAINT fk_messages_ticket FOREIGN KEY (ticket_id) REFERENCES support_tickets(id) ON DELETE CASCADE
);
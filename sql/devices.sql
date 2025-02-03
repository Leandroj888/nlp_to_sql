-- Armazena os dispositivos cadastrados na infraestrutura de TI.
CREATE TABLE devices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único do dispositivo.
    name VARCHAR(100) NOT NULL, -- Nome do dispositivo.
    type VARCHAR(50) NOT NULL, -- Tipo de dispositivo (exemplo: Servidor, Computador, Impressora).
    assigned_to UUID, -- Usuário ao qual o dispositivo está vinculado.
    status VARCHAR(20) NOT NULL DEFAULT 'Ativo', -- Status do dispositivo (exemplo: Ativo, Manutenção, Desativado).
    purchase_date DATE, -- Data de aquisição do dispositivo.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do registro.
    CONSTRAINT fk_devices_user FOREIGN KEY (assigned_to) REFERENCES employees(id) ON DELETE SET NULL
);
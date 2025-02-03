-- Armazena as tarefas e atividades da equipe.
CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único da tarefa.
    title VARCHAR(150) NOT NULL, -- Título da tarefa.
    description TEXT, -- Descrição detalhada da tarefa.
    assigned_to UUID NOT NULL, -- Funcionário responsável pela tarefa.
    due_date DATE, -- Data de vencimento da tarefa.
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente', -- Status da tarefa (exemplo: Pendente, Em andamento, Concluída).
    priority VARCHAR(20) NOT NULL DEFAULT 'Média', -- Prioridade da tarefa (exemplo: Baixa, Média, Alta).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação da tarefa.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização da tarefa.
    CONSTRAINT fk_tasks_employee FOREIGN KEY (assigned_to) REFERENCES employees(id) ON DELETE SET NULL
);
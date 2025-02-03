-- Armazena as transações financeiras da empresa.
CREATE TABLE financial_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único da transação.
    type VARCHAR(20) NOT NULL, -- Tipo da transação (exemplo: Receita, Despesa).
    amount DECIMAL(15,2) NOT NULL CHECK (amount > 0), -- Valor da transação.
    description TEXT, -- Descrição detalhada da transação.
    category VARCHAR(50) NOT NULL, -- Categoria financeira (exemplo: Venda, Salário, Aluguel).
    transaction_date DATE NOT NULL, -- Data da transação.
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW() -- Última atualização do registro.
);
-- Armazena as folhas de pagamento dos funcionários.
CREATE TABLE payroll (
    id SERIAL PRIMARY KEY, -- Identificador único da folha de pagamento.
    employee_id UUID NOT NULL, -- Funcionário associado ao pagamento.
    period_start DATE NOT NULL, -- Data de início do período de pagamento.
    period_end DATE NOT NULL, -- Data de término do período de pagamento.
    gross_salary DECIMAL(10,2) NOT NULL CHECK (gross_salary >= 0), -- Salário bruto antes dos descontos.
    net_salary DECIMAL(10,2) NOT NULL CHECK (net_salary >= 0), -- Salário líquido após impostos e descontos.
    payment_date DATE NOT NULL, -- Data do pagamento.
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente', -- Status do pagamento (exemplo: Pendente, Pago).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do registro.
    CONSTRAINT fk_payroll_employee FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);
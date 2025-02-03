-- Armazena as compras realizadas pela empresa junto aos fornecedores.
CREATE TABLE purchases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Identificador único da compra.
    supplier_id UUID NOT NULL, -- Fornecedor associado à compra.
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0), -- Valor total da compra.
    purchase_date TIMESTAMP DEFAULT NOW(), -- Data da compra.
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente', -- Status da compra (exemplo: Pendente, Pago, Recebido).
    created_at TIMESTAMP DEFAULT NOW(), -- Data de criação do registro.
    updated_at TIMESTAMP DEFAULT NOW(), -- Última atualização do registro.
    CONSTRAINT fk_purchases_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE
);

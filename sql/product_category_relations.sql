-- Relaciona produtos às suas categorias.
CREATE TABLE product_category_relations (
    product_id UUID NOT NULL, -- Produto associado à categoria.
    category_id INT NOT NULL, -- Categoria associada ao produto.
    PRIMARY KEY (product_id, category_id),
    CONSTRAINT fk_pcr_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_pcr_category FOREIGN KEY (category_id) REFERENCES product_categories(id) ON DELETE CASCADE
);

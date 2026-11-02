-- Opcional: permitir que customer_id_doc no sea obligatorio en la tabla orders
ALTER TABLE public.orders ALTER COLUMN customer_id_doc DROP NOT NULL;

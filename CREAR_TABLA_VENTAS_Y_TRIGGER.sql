-- =========================================================================
-- SISTEMA AUTOMÁTICO DE VENTAS E INVENTARIO PARA CREACIONES SCARLET
-- Ejecuta este script en el SQL Editor de Supabase
-- =========================================================================

-- 1. Crear tabla de ventas (sales)
CREATE TABLE IF NOT EXISTS public.sales (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_code VARCHAR(50) NOT NULL,
    product_sku VARCHAR(50) NOT NULL,
    product_name TEXT NOT NULL,
    size VARCHAR(20) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price_usd NUMERIC(10, 2) NOT NULL,
    total_sale_usd NUMERIC(10, 2) NOT NULL,
    customer_name TEXT,
    customer_phone VARCHAR(50),
    sale_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar RLS en sales
ALTER TABLE public.sales ENABLE ROW LEVEL SECURITY;

-- Políticas RLS para sales
CREATE POLICY "Public read sales" ON public.sales FOR SELECT USING (true);
CREATE POLICY "Public insert sales" ON public.sales FOR INSERT WITH CHECK (true);

-- 2. Función y Trigger: Al registrarse una fila en 'sales', descuenta automáticamente el stock en 'products'
CREATE OR REPLACE FUNCTION public.process_sale_stock_reduction()
RETURNS TRIGGER AS $$
BEGIN
    -- Descontar el stock del producto según su SKU asegurando que no baje de cero
    UPDATE public.products
    SET stock = GREATEST(0, stock - NEW.quantity)
    WHERE sku = NEW.product_sku;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Eliminar trigger si existía previamente para evitar duplicados
DROP TRIGGER IF EXISTS trg_after_sale_reduce_stock ON public.sales;

-- Crear el Trigger que se dispara automáticamente después de cada venta
CREATE TRIGGER trg_after_sale_reduce_stock
AFTER INSERT ON public.sales
FOR EACH ROW
EXECUTE FUNCTION public.process_sale_stock_reduction();

-- 3. Permitir actualización de stock en products por si el cliente o trigger lo requiere
CREATE POLICY "Allow update product stock" ON public.products FOR UPDATE USING (true) WITH CHECK (true);

-- =========================================================================
-- SCRIPT FINAL DE PERMISOS RLS (ORDERS, ORDER_ITEMS, SALES, EXCHANGE_RATES)
-- Ejecuta este script en el SQL Editor de Supabase
-- =========================================================================

-- 1. Tabla EXCHANGE_RATES (Permite guardar la tasa oficial diaria automáticamente)
DROP POLICY IF EXISTS "Public insert exchange_rates" ON public.exchange_rates;
CREATE POLICY "Public insert exchange_rates" 
ON public.exchange_rates 
FOR INSERT 
TO public, anon, authenticated 
WITH CHECK (true);

DROP POLICY IF EXISTS "Public read exchange_rates" ON public.exchange_rates;
CREATE POLICY "Public read exchange_rates" 
ON public.exchange_rates 
FOR SELECT 
TO public, anon, authenticated 
USING (true);

-- 2. Tabla ORDERS y ORDER_ITEMS (Permite guardar el pedido completo desde el checkout)
DROP POLICY IF EXISTS "Public insert orders" ON public.orders;
CREATE POLICY "Public insert orders" 
ON public.orders 
FOR INSERT 
TO public, anon, authenticated 
WITH CHECK (true);

DROP POLICY IF EXISTS "Public select orders" ON public.orders;
CREATE POLICY "Public select orders" 
ON public.orders 
FOR SELECT 
TO public, anon, authenticated 
USING (true);

DROP POLICY IF EXISTS "Public insert order_items" ON public.order_items;
CREATE POLICY "Public insert order_items" 
ON public.order_items 
FOR INSERT 
TO public, anon, authenticated 
WITH CHECK (true);

DROP POLICY IF EXISTS "Public select order_items" ON public.order_items;
CREATE POLICY "Public select order_items" 
ON public.order_items 
FOR SELECT 
TO public, anon, authenticated 
USING (true);

-- 3. Tabla APPOINTMENTS (Citas del Atelier)
DROP POLICY IF EXISTS "Public insert appointments" ON public.appointments;
CREATE POLICY "Public insert appointments" 
ON public.appointments 
FOR INSERT 
TO public, anon, authenticated 
WITH CHECK (true);

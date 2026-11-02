-- =========================================================================
-- SOLUCIÓN DE PERMISOS RLS PARA ORDERS Y ORDER_ITEMS EN SUPABASE
-- Ejecuta este script en el SQL Editor de Supabase
-- =========================================================================

-- Asegurar políticas de inserción y lectura pública para pedidos
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

-- Asegurar políticas para order_items
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

-- Asegurar políticas para citas (appointments)
DROP POLICY IF EXISTS "Public insert appointments" ON public.appointments;
CREATE POLICY "Public insert appointments" 
ON public.appointments 
FOR INSERT 
TO public, anon, authenticated 
WITH CHECK (true);

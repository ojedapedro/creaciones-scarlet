-- =========================================================================
-- PERMISOS PARA GUARDAR LA TASA DIARIA EN SUPABASE DE FORMA AUTOMÁTICA
-- Ejecuta esto en el SQL Editor de Supabase
-- =========================================================================

-- Permitir inserción de la tasa diaria desde la web
DROP POLICY IF EXISTS "Public insert exchange_rates" ON public.exchange_rates;
CREATE POLICY "Public insert exchange_rates" 
ON public.exchange_rates 
FOR INSERT 
TO public, anon, authenticated 
WITH CHECK (true);

-- Asegurar lectura pública de tasas
DROP POLICY IF EXISTS "Public read exchange_rates" ON public.exchange_rates;
CREATE POLICY "Public read exchange_rates" 
ON public.exchange_rates 
FOR SELECT 
TO public, anon, authenticated 
USING (true);

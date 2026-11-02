-- =========================================================================
-- SEMILLA DE PRODUCTOS INICIALES PARA CREACIONES SCARLET EN SUPABASE
-- Ejecuta esto en el SQL Editor de tu proyecto en Supabase
-- =========================================================================

INSERT INTO products (sku, name, category, description, price_usd, stock, available_sizes, image_url, is_active)
VALUES
(
  'sc-01',
  'Vestido Noir Couture Sirena',
  'mujer',
  'Satén pesado con drapeado artesanal y escote arquitectónico que enmarca la figura.',
  85.00,
  4,
  ARRAY['XS', 'S', 'M', 'L', 'A Medida'],
  'https://images.unsplash.com/photo-1566174053879-31528523f8ae?auto=format&fit=crop&w=800&q=80',
  true
),
(
  'sc-02',
  'Conjunto Scarlet Glam Fucsia',
  'mujer',
  'Pantalón palazzo de tiro alto y top estructurado en el icónico tono Fucsia Scarlet.',
  75.00,
  2,
  ARRAY['XS', 'S', 'M', 'A Medida'],
  'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?auto=format&fit=crop&w=800&q=80',
  true
),
(
  'sc-05',
  'Vestido Cocktail Terciopelo Escarlata',
  'mujer',
  'Terciopelo elástico con ribetes cromados y apertura lateral sutil de gran sofisticación.',
  95.00,
  1,
  ARRAY['S', 'M', 'L', 'A Medida'],
  'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?auto=format&fit=crop&w=800&q=80',
  true
),
(
  'sc-08',
  'Confección Traje de Gala a Medida',
  'amedida',
  'Servicio integral: patronaje exclusivo, selección de telas, pruebas y confección Haute Couture.',
  140.00,
  6,
  ARRAY['Toma de Medidas'],
  'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?auto=format&fit=crop&w=800&q=80',
  true
)
ON CONFLICT (sku) DO UPDATE 
SET 
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  description = EXCLUDED.description,
  price_usd = EXCLUDED.price_usd,
  stock = EXCLUDED.stock,
  available_sizes = EXCLUDED.available_sizes,
  image_url = EXCLUDED.image_url,
  is_active = EXCLUDED.is_active;

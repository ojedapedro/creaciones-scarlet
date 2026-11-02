-- =========================================================================
-- CREACIONES SCARLET - ESQUEMA SUPABASE POSTGRESQL (TODO EN UNO)
-- =========================================================================

-- 1. Tabla de Tasa de Cambio (Exchange Rates)
CREATE TABLE IF NOT EXISTS public.exchange_rates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    rate_usd_to_bs NUMERIC(10, 2) NOT NULL,
    source TEXT DEFAULT 'Manual / BCV',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertar tasa inicial
INSERT INTO public.exchange_rates (rate_usd_to_bs) VALUES (54.20);

-- 2. Tabla de Productos (Products)
CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sku VARCHAR(50) UNIQUE,
    name TEXT NOT NULL,
    category VARCHAR(50) NOT NULL, -- 'mujer', 'amedida'
    description TEXT,
    price_usd NUMERIC(10, 2) NOT NULL,
    available_sizes TEXT[] DEFAULT ARRAY['XS', 'S', 'M', 'L', 'A Medida'],
    image_url TEXT,
    stock INT DEFAULT 10,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertar productos iniciales de Creaciones Scarlet
INSERT INTO public.products (sku, name, category, description, price_usd, stock, available_sizes, image_url, is_active)
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
ON CONFLICT (sku) DO NOTHING;

-- 3. Tabla de Pedidos (Orders)
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_code VARCHAR(20) UNIQUE NOT NULL,
    customer_name TEXT NOT NULL,
    customer_id_doc VARCHAR(30) NOT NULL,
    customer_phone VARCHAR(50) NOT NULL,
    delivery_type VARCHAR(50) NOT NULL,
    delivery_address TEXT,
    total_usd NUMERIC(10, 2) NOT NULL,
    applied_exchange_rate NUMERIC(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_reference TEXT,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'Pendiente de verificación',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Ítems del Pedido (Order Items)
CREATE TABLE IF NOT EXISTS public.order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES public.products(id),
    product_name TEXT NOT NULL,
    size VARCHAR(20) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price_usd NUMERIC(10, 2) NOT NULL,
    subtotal_usd NUMERIC(10, 2) NOT NULL
);

-- 5. Tabla de Citas / Medidas (Appointments)
CREATE TABLE IF NOT EXISTS public.appointments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_name TEXT NOT NULL,
    customer_phone VARCHAR(50) NOT NULL,
    service_type TEXT NOT NULL,
    scheduled_date DATE NOT NULL,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'Pendiente por confirmar',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Medidas Anatómicas (Measurements)
CREATE TABLE IF NOT EXISTS public.customer_measurements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_phone VARCHAR(50) NOT NULL,
    customer_name TEXT,
    bust_cm NUMERIC(5, 2),
    waist_cm NUMERIC(5, 2),
    hip_cm NUMERIC(5, 2),
    shoulder_cm NUMERIC(5, 2),
    height_cm NUMERIC(5, 2),
    notes TEXT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar Row Level Security (RLS)
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exchange_rates ENABLE ROW LEVEL SECURITY;

-- Políticas de acceso público (Lectura de catálogo y tasa)
CREATE POLICY "Public read products" ON public.products FOR SELECT USING (true);
CREATE POLICY "Public read exchange_rates" ON public.exchange_rates FOR SELECT USING (true);

-- Políticas de inserción desde la web (Pedidos y Citas)
CREATE POLICY "Public insert orders" ON public.orders FOR INSERT WITH CHECK (true);
CREATE POLICY "Public insert order_items" ON public.order_items FOR INSERT WITH CHECK (true);
CREATE POLICY "Public insert appointments" ON public.appointments FOR INSERT WITH CHECK (true);

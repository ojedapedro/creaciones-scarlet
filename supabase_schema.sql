-- =========================================================================
-- CREACIONES SCARLET - ESQUEMA SUPABASE POSTGRESQL (COMERCIO ELECTRÓNICO & ATELIER)
-- =========================================================================

-- 1. Tabla de Tasa de Cambio (Exchange Rates)
CREATE TABLE IF NOT EXISTS exchange_rates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    rate_usd_to_bs NUMERIC(10, 2) NOT NULL,
    source TEXT DEFAULT 'Manual / BCV',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertar tasa inicial
INSERT INTO exchange_rates (rate_usd_to_bs) VALUES (54.20);

-- 2. Tabla de Productos (Products)
CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sku VARCHAR(50) UNIQUE,
    name TEXT NOT NULL,
    category VARCHAR(50) NOT NULL, -- 'mujer', 'ninos', 'hombre', 'amedida'
    description TEXT,
    price_usd NUMERIC(10, 2) NOT NULL,
    available_sizes TEXT[] DEFAULT ARRAY['XS', 'S', 'M', 'L', 'A Medida'],
    image_url TEXT,
    stock INT DEFAULT 10,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Tabla de Pedidos (Orders)
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_code VARCHAR(20) UNIQUE NOT NULL, -- Ej: SC-1024
    customer_name TEXT NOT NULL,
    customer_id_doc VARCHAR(30) NOT NULL, -- Cédula o RIF
    customer_phone VARCHAR(50) NOT NULL,
    delivery_type VARCHAR(50) NOT NULL, -- 'Retiro en Atelier', 'Delivery', 'Envío Nacional'
    delivery_address TEXT,
    total_usd NUMERIC(10, 2) NOT NULL,
    applied_exchange_rate NUMERIC(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL, -- 'Pago Móvil', 'Zelle', 'Transferencia', 'Efectivo'
    payment_reference TEXT,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'Pendiente de verificación', -- 'Pendiente', 'Verificado', 'En confección', 'Despachado'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Ítems del Pedido (Order Items)
CREATE TABLE IF NOT EXISTS order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    product_name TEXT NOT NULL,
    size VARCHAR(20) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price_usd NUMERIC(10, 2) NOT NULL,
    subtotal_usd NUMERIC(10, 2) NOT NULL
);

-- 5. Tabla de Citas / Medidas (Appointments)
CREATE TABLE IF NOT EXISTS appointments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_name TEXT NOT NULL,
    customer_phone VARCHAR(50) NOT NULL,
    service_type TEXT NOT NULL,
    scheduled_date DATE NOT NULL,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'Pendiente por confirmar',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Medidas Anatómicas de Clientes (Measurements)
CREATE TABLE IF NOT EXISTS customer_measurements (
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

-- POLÍTICAS RLS (Row Level Security)
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;

-- Acceso de lectura público a catálogo
CREATE POLICY "Public read products" ON products FOR SELECT USING (is_active = true);

-- Inserción pública de pedidos y citas desde el checkout
CREATE POLICY "Public insert orders" ON orders FOR INSERT WITH CHECK (true);
CREATE POLICY "Public insert appointments" ON appointments FOR INSERT WITH CHECK (true);

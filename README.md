# Creaciones Scarlet - E-commerce de Lujo & Atelier

Este proyecto implementa la solución completa solicitada en el prompt de construcción, adaptada a una estética de **Comercio Electrónico de Lujo (Haute Couture / Atelier Privé)**.

---

## 💎 Identidad Visual y Estilo de Lujo Aplicado
- **Paleta de Color:**
  - `Noir / Obsidian` (`#08080A`, `#0F1015`): Fondo oscuro elegante y de contraste editorial.
  - `Fucsia Scarlet` (`#E6007E` y brillos neón): Acento principal de marca y llamadas a la acción (CTAs).
  - `Gold / Champagne` (`#D4AF37`, `#ECE5D8`): Detalles de distinción, botones de servicio y medidores.
- **Tipografías:**
  - **Cormorant Garamond:** Titulares editoriales con gracia clásica y alta costura.
  - **Great Vibes:** Firma script icónica de "Scarlet".
  - **Montserrat:** Lectura clara, moderna y limpia para especificaciones y precios.

---

## 🚀 Archivos del Proyecto

1. **[index.html](file:///c:/Users/Agencia%20de%20viajes/OneDrive/Escritorio/Proyectos%20antigravity/landing%20creaciones%20scarlet/index.html)**:
   - **Hero editorial:** Tipografía majestuosa, badges de confianza de Venezuela y llamadas directas.
   - **Catálogo de Lujo:** Con filtros interactivos por categoría (Mujer Glam, Niños, Hombre Casual, A Medida), selector de tallas y conversión dual automática (**USD** y **Bs.** calculados en tiempo real con la tasa del día).
   - **Proceso Atelier en 4 Pasos:** Inspiración, toma de medidas, corte y acabados Haute Couture.
   - **Guía de Medidas Interactiva:** Simulador anatómico de toma de puntos clave (Busto, Cintura, Cadera) y tabla de tallas en cm.
   - **Bolsa de Compras Lateral (Drawer):** Carrito interactivo con persistencia local (`localStorage`), control de cantidades y desglose de totales.
   - **Checkout Automatizado para WhatsApp:**
     - Datos del cliente (Nombre, Cédula, Teléfono).
     - Tipos de entrega (Retiro en Taller, Delivery local o Envíos Nacionales).
     - Métodos de pago venezolanos (Pago Móvil con cálculo en Bs., Zelle en USD, Transferencias o Efectivo).
     - Generación del formato oficial con código único de pedido (`SC-XXXX`) y redirección directa al número oficial **+58 414-4415403**.
   - **Reserva de Citas para Atelier:** Formulario que prepara la cita y la notifica por WhatsApp.

2. **[supabase_schema.sql](file:///c:/Users/Agencia%20de%20viajes/OneDrive/Escritorio/Proyectos%20antigravity/landing%20creaciones%20scarlet/supabase_schema.sql)**:
   - Esquema completo de base de datos con tablas para `products`, `orders`, `order_items`, `exchange_rates`, `appointments` y `customer_measurements`, incluyendo políticas RLS listas para Supabase.

---

## 🛠️ Cómo Visualizar y Probar
Puedes abrir directamente el archivo en cualquier navegador:
1. Haz doble clic en `index.html` en la carpeta `landing creaciones scarlet`.
2. Prueba agregar prendas a la bolsa, seleccionar tallas, abrir el checkout y verificar cómo genera el mensaje prellenado hacia WhatsApp.

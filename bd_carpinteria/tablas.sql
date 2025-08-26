DROP DATABASE IF EXISTS carpinteria_connet_v2;
	CREATE DATABASE carpinteria_connet_v2;
	USE carpinteria_connet_v2;
    
   
-- =====================================================
-- 🧱 2. TABLA DE ROLES
-- =====================================================
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    fecha_creacion DATE
);

-- =====================================================
-- 🔐 3. TABLA DE PERMISOS
-- =====================================================
CREATE TABLE permisos (
    id_permiso INT AUTO_INCREMENT PRIMARY KEY,
    codigo_permiso VARCHAR(50) NOT NULL UNIQUE,
    nombre_permiso VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    modulo VARCHAR(50) NOT NULL
);

-- =====================================================
-- 🔗 4. TABLA INTERMEDIA ROLES - PERMISOS
-- =====================================================
CREATE TABLE roles_permisos (
    id_rol_permiso INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_rol INT NOT NULL,
    fk_id_permiso INT NOT NULL,
    fecha_asignacion DATE,
    FOREIGN KEY (fk_id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (fk_id_permiso) REFERENCES permisos(id_permiso),
    UNIQUE (fk_id_rol, fk_id_permiso)
);

-- =====================================================
-- 👥 5. TABLA DE USUARIOS
-- =====================================================
CREATE TABLE usuarios (
    cod_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    estado VARCHAR(10) DEFAULT 'ACTIVO',
    fk_id_rol INT NOT NULL,
    fecha_registro DATE,
    FOREIGN KEY (fk_id_rol) REFERENCES roles(id_rol),
    CHECK (estado IN ('ACTIVO', 'INACTIVO'))
);

-- =====================================================
-- 📦 6. TABLA DE CATEGORÍAS
-- =====================================================
CREATE TABLE categoria_producto (
    id_categoria_producto INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_producto VARCHAR(255)
);

-- =====================================================
-- 🛒 7. TABLA DE PRODUCTOS
-- =====================================================
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    fk_id_categoria_producto INT NOT NULL,
    valor_producto DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    fecha_creacion DATE NOT NULL,
    FOREIGN KEY (fk_id_categoria_producto) REFERENCES categoria_producto(id_categoria_producto)
);

-- =====================================================
-- 🖼️ 8. TABLA DE FOTOS DE PRODUCTOS
-- =====================================================
CREATE TABLE foto (
    id_foto INT AUTO_INCREMENT PRIMARY KEY,
    ubicacion_foto VARCHAR(255) NOT NULL,
    fk_id_producto INT NOT NULL,
    FOREIGN KEY (fk_id_producto) REFERENCES productos(id_producto)
);

-- =====================================================
-- 🛍️ 9. TABLA CARRITO
-- =====================================================
CREATE TABLE carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_usuario INT NOT NULL, 
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(15) DEFAULT 'ACTIVO', -- ACTIVO, CERRADO, ABANDONADO
    FOREIGN KEY (fk_id_usuario) REFERENCES usuarios(cod_usuario)
);

-- =====================================================
-- 🛒 10. TABLA CARRITO_ITEMS
-- =====================================================
CREATE TABLE carrito_items (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_carrito INT NOT NULL,      
    fk_id_producto INT NOT NULL,     
    cantidad INT NOT NULL,           
    precio_unitario DECIMAL(10,2) NOT NULL,  
    subtotal DECIMAL(10,2) AS (cantidad * precio_unitario) STORED,
    FOREIGN KEY (fk_id_carrito) REFERENCES carrito(id_carrito),
    FOREIGN KEY (fk_id_producto) REFERENCES productos(id_producto)
);

-- =====================================================
-- 🧾 11. TABLA DE VENTAS
-- =====================================================
CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_carrito INT NOT NULL,
    fecha_venta DATE NOT NULL,
    metod_pago VARCHAR(50) NOT NULL,
    valor_venta DECIMAL(10,2) NOT NULL,        
    descuento_venta DECIMAL(10,2) DEFAULT 0,
    total_a_pagar DECIMAL(10,2) NOT NULL,     
    estado VARCHAR(15) DEFAULT 'PENDIENTE',
    FOREIGN KEY (fk_id_carrito) REFERENCES carrito(id_carrito),
    CHECK (estado IN ('PENDIENTE','COMPLETADA','CANCELADA'))
);

-- =====================================================
-- 📋 12. TABLA DETALLE DE VENTA
-- =====================================================
CREATE TABLE detalle_venta (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_venta INT NOT NULL,
    fk_id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) AS (cantidad * precio_unitario) STORED,
    FOREIGN KEY (fk_id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (fk_id_producto) REFERENCES productos(id_producto)
);

-- =====================================================
-- 🏭 13. TABLA PROVEEDORES
-- =====================================================
CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- =====================================================
-- 📥 14. TABLA COMPRAS
-- =====================================================
CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_proveedor INT NOT NULL,
    fecha_compra DATE NOT NULL,
    total_compra DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_proveedor) REFERENCES proveedores(id_proveedor)
);

-- =====================================================
-- 📋 15. TABLA DETALLE DE COMPRA
-- =====================================================
CREATE TABLE detalle_compra (
    id_detalle_compra INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_compra INT NOT NULL,
    fk_id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) AS (cantidad * precio_unitario) STORED,
    FOREIGN KEY (fk_id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (fk_id_producto) REFERENCES productos(id_producto)
);

-- =====================================================
-- 📦 16. TABLA INVENTARIO MOVIMIENTOS
-- =====================================================
CREATE TABLE inventario_movimientos (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_producto INT NOT NULL,
    tipo_movimiento ENUM('ENTRADA','SALIDA') NOT NULL,
    cantidad INT NOT NULL,
    fecha_movimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(255),
    FOREIGN KEY (fk_id_producto) REFERENCES productos(id_producto)
);

-- =====================================================
-- ✅ INSERTAR DATOS INICIALES
-- =====================================================
INSERT INTO roles (id_rol, nombre_rol, descripcion, fecha_creacion)
VALUES
  (1, 'Proveedor', 'Usuario que vende productos', CURDATE()),
  (2, 'Cliente', 'Usuario que compra productos', CURDATE());

INSERT INTO usuarios (nombre_usuario, correo, contraseña, telefono, fk_id_rol, fecha_registro)
VALUES 
  ('Proveedor', 'admin@carpi.com', 'admin12345', '3000000001', 1, CURDATE()),
  ('Cliente', 'cliente@carpi.com', 'cliente23212', '3000000002', 2, CURDATE());

INSERT INTO categoria_producto (descripcion_producto) VALUES 
  ('Muebles'), ('Decoración'), ('Iluminación'), ('Herramientas');

INSERT INTO carrito (fk_id_usuario, estado) VALUES (1, 'ACTIVO');

UPDATE carrito SET estado = 'ACTIVO' WHERE id_carrito = 1;

-- =====================================================
-- 🔍 CONSULTAS DE PRUEBA
-- =====================================================
SELECT * FROM roles;
SELECT * FROM usuarios;
SELECT * FROM categoria_producto;
SELECT * FROM productos;
SELECT * FROM carrito;	
SELECT * FROM carrito_items;
SELECT * FROM venta;
SELECT * FROM detalle_venta;
SELECT * FROM proveedores;
SELECT * FROM compras;
SELECT * FROM detalle_compra;
SELECT * FROM inventario_movimientos;
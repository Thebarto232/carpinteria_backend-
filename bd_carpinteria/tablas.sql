DROP DATABASE IF EXISTS carpinteria_connet_v2;
CREATE DATABASE carpinteria_connet_v2;
USE carpinteria_connet_v2;

-- ==========================================
-- 1. Tabla de roles
-- ==========================================
CREATE TABLE roles (
  id_rol INT PRIMARY KEY,
  nombre_rol VARCHAR(50)
);

-- ==========================================
-- 2. Tabla de permisos
-- ==========================================
CREATE TABLE permisos (
  id_permiso INT PRIMARY KEY,
  nombre_permiso VARCHAR(50)
);

-- ==========================================
-- 3. Tabla intermedia roles_permisos
-- ==========================================
CREATE TABLE roles_permisos (
  id_rol INT,
  id_permiso INT,
  PRIMARY KEY (id_rol, id_permiso),
  FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
  FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso)
);

-- ==========================================
-- 4. Tabla de usuarios
-- ==========================================
CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY,
  nombre_usuario VARCHAR(100),
  id_rol INT,
  FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- ==========================================
-- 5. Tabla de carritos
-- ==========================================
CREATE TABLE carritos (
  id_carrito INT PRIMARY KEY,
  id_usuario INT,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- ==========================================
-- 6. Tabla de categoria_producto
-- ==========================================
CREATE TABLE categoria_producto (
  id_categoria INT PRIMARY KEY,
  nombre_categoria VARCHAR(50)
);

-- ==========================================
-- 7. Tabla de productos
-- ==========================================
CREATE TABLE productos (
  id_producto INT PRIMARY KEY,
  nombre_producto VARCHAR(100),
  id_categoria INT,
  FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id_categoria)
);

-- ==========================================
-- 8. Tabla de fotos_productos
-- ==========================================
CREATE TABLE fotos_productos (
  id_foto INT PRIMARY KEY,
  id_producto INT,
  url_foto VARCHAR(255),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ==========================================
-- 9. Tabla de inventario_movimientos
-- ==========================================
CREATE TABLE inventario_movimientos (
  id_movimiento INT PRIMARY KEY,
  id_producto INT,
  tipo_movimiento VARCHAR(20),
  cantidad INT,
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ==========================================
-- 10. Tabla de carrito_items
-- ==========================================
CREATE TABLE carrito_items (
  id_item INT PRIMARY KEY,
  id_carrito INT,
  id_producto INT,
  cantidad INT,
  FOREIGN KEY (id_carrito) REFERENCES carritos(id_carrito),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ==========================================
-- 11. Tabla de ventas
-- ==========================================
CREATE TABLE ventas (
  id_venta INT PRIMARY KEY,
  id_carrito INT,
  FOREIGN KEY (id_carrito) REFERENCES carritos(id_carrito)
);

-- ==========================================
-- 12. Tabla de detalle_venta
-- ==========================================
CREATE TABLE detalle_venta (
  id_detalle INT PRIMARY KEY,
  id_venta INT,
  id_producto INT,
  cantidad INT,
  FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ==========================================
-- 13. Tabla de proveedores
-- ==========================================
CREATE TABLE proveedores (
  id_proveedor INT PRIMARY KEY,
  nombre_proveedor VARCHAR(100)
);

-- ==========================================
-- 14. Tabla de compras
-- ==========================================
CREATE TABLE compras (
  id_compra INT PRIMARY KEY,
  id_proveedor INT,
  FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

-- ==========================================
-- 15. Tabla de detalle_compra
-- ==========================================
CREATE TABLE detalle_compra (
  id_detalle INT PRIMARY KEY,
  id_compra INT,
  id_producto INT,
  cantidad INT,
  FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

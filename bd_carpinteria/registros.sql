-- ==========================================
-- INSERTS DE ROLES
-- ==========================================
INSERT INTO roles (id_rol, nombre_rol) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Vendedor');

-- ==========================================
-- INSERTS DE PERMISOS
-- ==========================================
INSERT INTO permisos (id_permiso, nombre_permiso) VALUES
(1, 'crear_usuario'),
(2, 'editar_usuario'),
(3, 'eliminar_usuario'),
(4, 'ver_productos'),
(5, 'crear_venta');

-- ==========================================
-- INSERTS DE ROLES_PERMISOS
-- ==========================================
INSERT INTO roles_permisos (id_rol, id_permiso) VALUES
(1,1), (1,2), (1,3), (1,4), (1,5), -- Admin tiene todos
(2,4),                             -- Cliente solo ve productos
(3,4), (3,5);                      -- Vendedor ve y crea ventas

-- ==========================================
-- INSERTS DE USUARIOS
-- ==========================================
INSERT INTO usuarios (id_usuario, nombre_usuario, id_rol) VALUES
(1, 'Juan Admin', 1),
(2, 'Pedro Cliente', 2),
(3, 'Maria Vendedora', 3);

-- ==========================================
-- INSERTS DE CARRITOS
-- ==========================================
INSERT INTO carritos (id_carrito, id_usuario) VALUES
(1, 2); -- Carrito del cliente Pedro

-- ==========================================
-- INSERTS DE CATEGORIA_PRODUCTO
-- ==========================================
INSERT INTO categoria_producto (id_categoria, nombre_categoria) VALUES
(1, 'Muebles'),
(2, 'Herramientas');

-- ==========================================
-- INSERTS DE PRODUCTOS
-- ==========================================
INSERT INTO productos (id_producto, nombre_producto, id_categoria) VALUES
(1, 'Silla de Madera', 1),
(2, 'Mesa de Comedor', 1),
(3, 'Martillo', 2);

-- ==========================================
-- INSERTS DE FOTOS_PRODUCTOS
-- ==========================================
INSERT INTO fotos_productos (id_foto, id_producto, url_foto) VALUES
(1, 1, 'silla.jpg'),
(2, 2, 'mesa.jpg'),
(3, 3, 'martillo.jpg');

-- ==========================================
-- INSERTS DE INVENTARIO_MOVIMIENTOS
-- ==========================================
INSERT INTO inventario_movimientos (id_movimiento, id_producto, tipo_movimiento, cantidad) VALUES
(1, 1, 'entrada', 10),
(2, 2, 'entrada', 5),
(3, 3, 'entrada', 20);

-- ==========================================
-- INSERTS DE CARRITO_ITEMS
-- ==========================================
INSERT INTO carrito_items (id_item, id_carrito, id_producto, cantidad) VALUES
(1, 1, 1, 2), -- 2 sillas en el carrito de Pedro
(2, 1, 3, 1); -- 1 martillo

-- ==========================================
-- INSERTS DE VENTAS
-- ==========================================
INSERT INTO ventas (id_venta, id_carrito) VALUES
(1, 1);

-- ==========================================
-- INSERTS DE DETALLE_VENTA
-- ==========================================
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1);

-- ==========================================
-- INSERTS DE PROVEEDORES
-- ==========================================
INSERT INTO proveedores (id_proveedor, nombre_proveedor) VALUES
(1, 'Maderas del Norte'),
(2, 'Herramientas S.A.');

-- ==========================================
-- INSERTS DE COMPRAS
-- ==========================================
INSERT INTO compras (id_compra, id_proveedor) VALUES
(1, 1),
(2, 2);

-- ==========================================
-- INSERTS DE DETALLE_COMPRA
-- ==========================================
INSERT INTO detalle_compra (id_detalle, id_compra, id_producto, cantidad) VALUES
(1, 1, 1, 20), -- Compra de 20 sillas al proveedor 1
(2, 2, 3, 50); -- Compra de 50 martillos al proveedor 2

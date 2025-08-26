import connectionPromise from "../utils/db.js";

export const obtenerProductos = async () => {
  const connection = await connectionPromise;
  const [rows] = await connection.query(`
    SELECT p.*, c.descripcion_producto AS descripcion_categoria
    FROM productos p
    JOIN categoria_producto c ON p.fk_id_categoria_producto = c.id_categoria_producto
  `);
  return rows;

};
export const insertarProducto = async (data) => {
  const connection = await connectionPromise;
  const [result] = await connection.query(
    `INSERT INTO productos (nombre_producto, fk_id_categoria_producto, valor_producto, stock, fecha_creacion)
     VALUES (?, ?, ?, ?, ?)`,
    [
      data.nombre_producto,
      data.fk_id_categoria_producto,
      data.valor_producto,
      data.stock,
      data.fecha_creacion
    ]
  );
  return { id_producto: result.insertId, ...data };
};


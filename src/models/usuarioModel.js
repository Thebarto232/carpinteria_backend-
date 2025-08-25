/** metodos para obtener usuarios consultas  */
import connection from "../utils/db.js";

export const loginUsuario = async (correo, contraseña) => {
  const [rows] = await connection.execute(
    "SELECT cod_usuario, nombre_usuario, fk_id_rol FROM usuarios WHERE correo = ? AND contraseña = ? AND estado = 'ACTIVO'",
    [correo, contraseña]
  );
  return rows[0] || null;
};
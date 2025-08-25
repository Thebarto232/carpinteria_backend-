import { loginUsuario } from "../models/usuarioModel.js";
import jwt from "jsonwebtoken";

export const login = async (req, res) => {
  const { correo, contraseña } = req.body;

  try {
    const user = await loginUsuario(correo, contraseña);
    if (!user) return res.status(401).json({ error: "Credenciales inválidas" });

    const token = jwt.sign(
      { id: user.cod_usuario, rol: user.fk_id_rol },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    res.json({ token, rol: user.fk_id_rol });
  } catch (error) {
    res.status(500).json({ error: "Error en el servidor" });
  }
};

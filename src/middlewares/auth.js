import jwt from "jsonwebtoken";

export const verificarToken = (req, res, next) => {
  const token = req.headers["authorization"];
  if (!token) return res.status(403).json({ error: "Token requerido" });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.usuario = decoded;
    next();
  } catch (err) {
    res.status(401).json({ error: "Token inválido o expirado" });
  }
};

export const verificarRol = (rolPermitido) => {
  return (req, res, next) => {
    if (req.usuario.rol !== rolPermitido) {
      return res.status(403).json({ error: "Acceso denegado por rol" });
    }
    next();
  };
};

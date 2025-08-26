import { obtenerProductos, insertarProducto } from "../models/productos.model.js";

export const getProductos = async (req, res) => {
  try {
    const productos = await obtenerProductos();
    res.json(productos);
  } catch (error) {
    console.error("Error al obtener productos:", error);
    res.status(500).json({ error: "Error al obtener productos" });
  }
};

export const crearProducto = async (req, res) => {
  try {
    const nuevo = await insertarProducto(req.body);
    res.status(201).json(nuevo);
  } catch (error) {
    console.error("Error al crear producto:", error);
    res.status(500).json({ error: "No se pudo registrar el producto" });
  }
};

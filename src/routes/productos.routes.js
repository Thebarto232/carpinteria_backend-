import { Router } from "express";
import { crearProducto, getProductos } from "../controllers/productos.controller.js";


const router = Router();

router.get("/", getProductos);
router.post("/", crearProducto);

export default router;

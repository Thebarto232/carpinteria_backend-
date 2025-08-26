import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import bodyParser from "body-parser";
import cookieParser from "cookie-parser";
import productosRoutes from "./src/routes/productos.routes.js";


dotenv.config(); // 👈 primero se cargan las variables de entorno

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use("/api/productos", productosRoutes);
// 👇 solo una vez, con el import ya hecho arriba

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});

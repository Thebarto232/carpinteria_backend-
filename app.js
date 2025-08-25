import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import bodyParser from "body-parser";
import cookieParser from "cookie-parser";

// import productoRoutes from "./src/routes/productosRoutes.js";
// import categoriasRoutes from "./src/routes/categoriasRoutes.js";
import authRoutes from "./src/routes/authRoutes.js";
// import administradorRoutes from "./src/routes/administradorRoutes.js";

dotenv.config();

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());


app.use("/api/auth", authRoutes);
// app.use("/api/admin", administradorRoutes);

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});

const express = require("express");
const app = express();
const cors = require("cors");
const mongoose = require("mongoose");
require("dotenv").config();
const path = require("path");

const port = process.env.PORT || 8080;

app.use(express.json());
app.use(cors());

const feedbackRouter = require("./routes/feedbackRoutes");
app.use("/feedback", feedbackRouter);
const imagemRouter = require("./routes/imgUploadsRoutes");
app.use(imagemRouter);
const videoRouter = require("./routes/videoUploadsRoutes");
app.use(videoRouter);

// Configuração para servir arquivos estáticos
const frontendPath = path.join(__dirname, "../Frontend");
const cssPath = path.join(__dirname, "../Frontend/css");

app.use(express.static(frontendPath));
app.use("/css", express.static(cssPath));

app.use(express.urlencoded({ extended: true }));
mongoose
  .connect(process.env.MONGODB_URI)
  .then(() => {
    console.log("Conectado ao MongoDB");
  })
  .catch((error) => {
    console.error("Erro ao conectar ao MongoDB", error);
  });

// Inicialização do servidor
app.listen(port, () => {
  console.log(`Servidor está rodando na porta: ${port}`);
});

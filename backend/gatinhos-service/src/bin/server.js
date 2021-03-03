require("dotenv").config();

const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const morgan = require("morgan");

const router = require("../routes");

const app = express();
const server = http.createServer(app);

mongoose.connect(process.env.DB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

app.use(express.json());
app.use(morgan("dev"));

app.use(router);

server.listen(3001, () => {
  console.log("API rodando na porta 3001");
});

require("dotenv").config();

const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const morgan = require("morgan");
const jwt = require("jsonwebtoken");
const path = require("path");

const router = require("../routes");

const app = express();
const server = http.createServer(app);

mongoose.connect(process.env.DB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useFindAndModify: false,
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan("dev"));

app.use(router);
app.use(
  "/files",
  express.static(path.resolve(__dirname, "..", "..", "uploads"))
);

server.listen(3001, () => {
  console.log("API rodando na porta 3001");
});

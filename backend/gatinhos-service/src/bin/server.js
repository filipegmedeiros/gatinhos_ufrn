require("dotenv").config();

const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const morgan = require("morgan");
const jwt = require("jsonwebtoken");

const router = require("../routes");

const app = express();
const server = http.createServer(app);

mongoose.connect(process.env.DB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

app.use(express.json());
app.use(morgan("dev"));

app.use((req, res, next) => {
  if (
    req.headers &&
    req.headers.authorization &&
    req.headers.authorization.split(" ")[0] === "JWT"
  ) {
    jwt.verify(
      req.headers.authorization.split(" ")[1],
      process.env.SECRET,
      function (err, decode) {
        if (err) req.user = undefined;
        req.user = decode;
        next();
      }
    );
  } else {
    req.user = undefined;
    next();
  }
});

app.use(router);

server.listen(3001, () => {
  console.log("API rodando na porta 3001");
});

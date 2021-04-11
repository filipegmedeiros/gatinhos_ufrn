const express = require("express");
const gatinhos = require("./gatinhos");
const adocao = require("./adocao");
const auth = require("./auth");
const image = require("./image");

const routes = express.Router();

routes.use("/api/v1/gatinhos", gatinhos);
routes.use("/api/v1/adocao", adocao);
routes.use("/api/v1/image", image);

routes.use("/auth", auth);

module.exports = routes;

const express = require("express");
const gatinhos = require("./gatinhos");
const auth = require("./auth");

const routes = express.Router();

routes.use("/api/v1/gatinhos", gatinhos);

routes.use("/auth", auth);

module.exports = routes;

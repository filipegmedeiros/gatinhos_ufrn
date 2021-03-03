const express = require("express");
const gatinhos = require("./gatinhos");

const routes = express.Router();

routes.use("/api/v1/gatinhos", gatinhos);

module.exports = routes;

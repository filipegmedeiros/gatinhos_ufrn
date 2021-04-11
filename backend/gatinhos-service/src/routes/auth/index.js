const express = require("express");

const { usuarioController } = require("../../controller");

const routes = express.Router();

routes.post("/sign_in", usuarioController.sign_in);
routes.post("/create", usuarioController.create);

module.exports = routes;

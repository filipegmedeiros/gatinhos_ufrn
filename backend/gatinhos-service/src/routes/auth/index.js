const express = require("express");

const { usuarioController } = require("../../controller");
const { authNeeded } = require("../../middleware");

const routes = express.Router();

routes.post("/sign_in", usuarioController.sign_in);
routes.post("/create", authNeeded, usuarioController.create);

module.exports = routes;

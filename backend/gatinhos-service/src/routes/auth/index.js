const express = require("express");

const routes = express.Router();
const { usuarioController } = require("../../controller");

routes.post("/sign_in", usuarioController.sign_in);
routes.post("/create", usuarioController.create);
routes.post(
  "/profile",
  usuarioController.loginRequired,
  usuarioController.profile
);

module.exports = routes;

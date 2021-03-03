const express = require("express");

const routes = express.Router();
const { userController } = require("../../controller");

routes.post("/sign_in", userController.sign_in);
routes.post("/create", userController.create);
routes.post("/profile", userController.loginRequired, userController.profile);

module.exports = routes;

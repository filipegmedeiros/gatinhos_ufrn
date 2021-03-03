const express = require("express");

const routes = express.Router();
const { gatinhosController } = require("../../controller");

routes.post("/", gatinhosController.createGatinho);
routes.get("/", gatinhosController.getAllGatinhos);
routes.get("/:id", gatinhosController.getOneGatinho);
routes.delete("/:id", gatinhosController.deleteGatinho);

module.exports = routes;

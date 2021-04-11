const express = require("express");

const routes = express.Router();
const { gatinhosController } = require("../../controller");
const { authNeeded } = require("../../middleware");

routes.post("/", authNeeded, gatinhosController.createGatinho);
routes.get("/", gatinhosController.getAllGatinhos);
routes.get("/:id", gatinhosController.getOneGatinho);
routes.delete("/:id", authNeeded, gatinhosController.deleteGatinho);

module.exports = routes;

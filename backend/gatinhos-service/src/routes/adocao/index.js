const express = require("express");

const routes = express.Router();
const { adocaoController } = require("../../controller");

routes.post("/", adocaoController.createForm);
routes.post("/:id", adocaoController.updateBadge);
routes.get("/", adocaoController.getAllForms);
routes.get("/:id", adocaoController.getOneForm);
routes.delete("/:id", adocaoController.deleteForm);

module.exports = routes;

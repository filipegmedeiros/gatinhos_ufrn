const express = require("express");

const { authNeeded } = require("../../middleware");
const { adocaoController } = require("../../controller");
const routes = express.Router();

routes.post("/", adocaoController.createForm);
routes.post("/:id", authNeeded, adocaoController.updateBadge);
routes.get("/", adocaoController.getAllForms);
routes.get("/:id", adocaoController.getOneForm);
routes.delete("/:id", authNeeded, adocaoController.deleteForm);

module.exports = routes;

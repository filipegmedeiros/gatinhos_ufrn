const express = require("express");
const multer = require("multer");

const routes = express.Router();
const { imageController } = require("../../controller");
const { uploadConfig } = require("../../config");
const { authNeeded } = require("../../middleware");

routes.post(
  "/:id",
  authNeeded,
  multer(uploadConfig).single("file"),
  imageController.upload
);

routes.get("/:id", imageController.getImage);

module.exports = routes;

const mongoose = require("mongoose");

const AdocaoSchema = new mongoose.Schema({
  versionKey: false,
  name: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
  },
  adress: {
    type: String,
    required: true,
  },
  screen_guard: {
    type: Boolean,
    required: true,
  },
  animals: {
    type: Boolean,
    required: true,
  },
  cat: {
    type: mongoose.SchemaTypes.ObjectId,
  },
  validateBadge: {
    type: String,
    default: "Validar",
  },
  isHouse: {
    type: Boolean,
  },
});

module.exports = mongoose.model("Adocao", AdocaoSchema);

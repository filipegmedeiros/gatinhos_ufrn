const mongoose = require("mongoose");

const GatinhosSchema = new mongoose.Schema({
  versionKey: false,
  name: {
    type: String,
    default: "Sem Nome",
  },
  description: {
    type: String,
    required: true,
  },
  rescueDate: {
    type: mongoose.SchemaTypes.Date,
    required: true,
  },
  gender: {
    type: String,
  },
  vaccines: {
    type: mongoose.SchemaTypes.Array,
  },
  castrate: {
    type: Boolean,
  },
});

module.exports = mongoose.model("Gatinhos", GatinhosSchema);

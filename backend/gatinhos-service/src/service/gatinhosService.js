const { gatinhosModel } = require("../model");

const getAll = async () => {
  return await gatinhosModel.find();
};

const getOne = async (id) => {
  return await gatinhosModel.findById(id);
};

const existsById = async (id) => {
  return await gatinhosModel.exists({ _id: id });
};

const del = async (id) => {
  return await gatinhosModel.findByIdAndDelete(id);
};

const exists = async (macAdress, name) => {
  return await gatinhosModel.exists({ macAdress, name });
};

const create = async (
  name,
  description,
  rescueDate,
  gender,
  vaccines,
  castrate
) => {
  try {
    let gatinhos = new gatinhosModel({
      name,
      description,
      rescueDate,
      gender,
      vaccines,
      castrate,
    });
    await gatinhos.save();
  } catch (error) {
    console.log("Erro ao salvar o Gatinho: ", error);
  }
};

module.exports = {
  create,
  del,
  exists,
  existsById,
  getOne,
  getAll,
};

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

const getAllByGender = async (gender) => {
  return await gatinhosModel.find({ gender });
};

const getAllByAge = async (age) => {
  return await gatinhosModel.find({ age: { $gte: age } });
};
const getAllByCastrate = async (castrate) => {
  return await gatinhosModel.find({ castrate });
};

const getAllByVaccines = async (vaccines) => {
  return await gatinhosModel.find({ vaccines });
};

module.exports = {
  create,
  del,
  existsById,
  getOne,
  getAll,
  getAllByGender,
  getAllByAge,
  getAllByCastrate,
  getAllByVaccines,
};

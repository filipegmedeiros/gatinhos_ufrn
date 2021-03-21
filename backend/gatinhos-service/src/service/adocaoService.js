const { adocaoModel } = require("../model");

const getAll = async () => {
  return await adocaoModel.find();
};

const getOne = async (id) => {
  return await adocaoModel.findById(id);
};

const existsById = async (id) => {
  return await adocaoModel.exists({ _id: id });
};

const del = async (id) => {
  return await adocaoModel.findByIdAndDelete(id);
};

const validatePhone = (phone) => {
  return (phone.match(/\d/g) || []).length == 10;
};

const create = async (name, phone, adress, screen_guard, animals, cat) => {
  try {
    let adocao = new adocaoModel({
      name,
      phone,
      adress,
      screen_guard,
      animals,
      cat,
    });
    await adocao.save();
  } catch (error) {
    console.log("Erro ao salvar o Formulário: ", error);
  }
};

const validateBadge = (badge) => {
  return badge === "validar" || badge === "aceito" || badge === "recusado";
};

const updateBadge = async (adocaoId, validateBadge) => {
  try {
    await adocaoModel.findByIdAndUpdate(adocaoId, { validateBadge });
  } catch (error) {
    console.log("Erro ao validar o Formulário");
  }
};

module.exports = {
  validatePhone,
  validateBadge,
  updateBadge,
  create,
  del,
  existsById,
  getOne,
  getAll,
};

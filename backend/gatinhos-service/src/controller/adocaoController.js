const { adocaoService } = require("../service");

const createForm = async (req, res) => {
  try {
    const { name, phone, adress, screen_guard, animals, cat } = req.body;

    if (adocaoService.validatePhone(phone)) {
      return res.status(422).send("Número Inválido");
    }

    await adocaoService.create(name, phone, adress, screen_guard, animals, cat);
    return res.status(200).send("Formulário Enviado com Sucesso!");
  } catch (error) {
    console.log("Erro no criar Formulário", error);
    return res.status(400).send("Erro na criação do formulário");
  }
};

const getOneForm = async (req, res) => {
  const { id } = req.params;
  try {
    if (!(await adocaoService.existsById(id))) {
      return res.status(400).send("Formulário não existe");
    }

    let adocaoForm = await adocaoService.getOne(id);

    return res.status(200).send(adocaoForm);
  } catch (error) {
    console.log("Erro no getOneForm", error);
    return res.status(400).send();
  }
};

const getAllForms = async (req, res) => {
  try {
    let gatinhos = JSON.parse(JSON.stringify(await adocaoService.getAll()));
    return res.status(200).send(gatinhos);
  } catch (error) {
    console.log("Erro no getAllForms", error);
    return res.status(400).send();
  }
};

const deleteForm = async (req, res) => {
  const { id } = req.params;
  try {
    await adocaoService.del(id);
    return res.status(200).send();
  } catch (error) {
    console.log("Erro no deleteGatinhos", error);
    return res.status(400).send();
  }
};

const updateBadge = async (req, res) => {
  const { id } = req.params;
  const { validateBadge } = req.body;

  try {
    if (!adocaoService.validateBadge(validateBadge)) {
      return res.status(422).send("Pedido Inválido.");
    }
    await adocaoService.updateBadge(id, validateBadge);
    return res.status(200).send("Pedido atualizado para: " + validateBadge);
  } catch (error) {
    console.log("Erro no updateBadge", error);
    return res.status(400).send();
  }
};

module.exports = {
  createForm,
  updateBadge,
  getOneForm,
  getAllForms,
  deleteForm,
};

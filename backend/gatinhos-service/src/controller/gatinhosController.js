const { gatinhosService } = require("../service");

const createGatinho = async (req, res) => {
  try {
    const {
      name,
      description,
      rescueDate,
      gender,
      vaccines,
      castrate,
    } = req.body;

    await gatinhosService.create(
      name,
      description,
      rescueDate,
      gender,
      vaccines,
      castrate
    );
    return res.status(200).send();
  } catch (error) {
    console.log("Erro no createGatinho", error);
    return res.status(400).send();
  }
};

const getOneGatinho = async (req, res) => {
  const { id } = req.params;
  try {
    let gatinho = await gatinhosService.getOne(id);

    return res.status(200).send(gatinho);
  } catch (error) {
    console.log("Erro no getOneGatinho", error);
    return res.status(400).send();
  }
};

const getAllGatinhos = async (req, res) => {
  try {
    let gatinhos = JSON.parse(JSON.stringify(await gatinhosService.getAll()));
    return res.status(200).send(gatinhos);
  } catch (error) {
    console.log("Erro no getAllGatinhos", error);
    return res.status(400).send();
  }
};

const deleteGatinho = async (req, res) => {
  const { id } = req.params;
  try {
    await gatinhosService.del(id);
    return res.status(200).send();
  } catch (error) {
    console.log("Erro no deleteGatinhos", error);
    return res.status(400).send();
  }
};

module.exports = {
  createGatinho,
  getOneGatinho,
  getAllGatinhos,
  deleteGatinho,
};

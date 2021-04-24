const { gatinhosService } = require("../service");

const createGatinho = async (req, res) => {
  console.log(req.body);
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
    return res.status(200).send("Criado gatinho com sucesso!");
  } catch (error) {
    console.log("Erro no createGatinho", error);
    return res.status(400).send(error.message);
  }
};

const getOneGatinho = async (req, res) => {
  const { id } = req.params;
  try {
    if (await gatinhosService.existsById(id)) {
      let gatinho = await gatinhosService.getOne(id);
      return res.status(200).send(gatinho);
    }
    return res.status(400).send("Gatinho não encontrado!");
  } catch (error) {
    console.log("Erro no getOneGatinho", error);
    return res.status(500).send();
  }
};

const getAllGatinhos = async (req, res) => {
  if (req.query.castrate) {
    try {
      let gatinhos = JSON.parse(
        JSON.stringify(
          await gatinhosService.getAllByCastrate(req.query.castrate)
        )
      );
      return res.status(200).send(gatinhos);
    } catch (error) {
      console.log("Erro no vaccines", error);
      return res.status(400).send();
    }
  }

  if (req.query.vaccines) {
    try {
      let gatinhos = JSON.parse(
        JSON.stringify(
          await gatinhosService.getAllByVaccines(req.query.vaccines)
        )
      );
      return res.status(200).send(gatinhos);
    } catch (error) {
      console.log("Erro no vaccines", error);
      return res.status(400).send();
    }
  }

  if (req.query.gender) {
    try {
      let gatinhos = JSON.parse(
        JSON.stringify(await gatinhosService.getAllByGender(req.query.gender))
      );
      return res.status(200).send(gatinhos);
    } catch (error) {
      console.log("Erro no vaccines", error);
      return res.status(400).send();
    }
  }

  if (req.query.age) {
    try {
      let gatinhos = JSON.parse(
        JSON.stringify(await gatinhos.getAllByAge(req.query.age))
      );
      return res.status(200).send(gatinhosCastrate);
    } catch (error) {
      console.log("Erro no sex", error);
      return res.status(400).send();
    }
  }

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

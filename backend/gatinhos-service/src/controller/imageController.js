const { gatinhosService } = require("../service");

const upload = async (req, res) => {
  const { id } = req.params;
  const { filename } = req.file;

  try {
    if (await gatinhosService.existsById(id)) {
      gatinhosService.uploadImage(id, filename);
      return res.status(200).send("Upload de imagem com sucesso!");
    }

    return res.status(400).send("Não foi achado o gatinho no ID especificado.");
  } catch (err) {
    return res.status(500).send(err.message);
  }
};

const getImage = async (req, res) => {
  const { id } = req.params;

  try {
    if (await gatinhosService.existsById(id)) {
      const filename = await gatinhosService.getImage(id);
      return res.redirect(process.env.API_URL + "/files/" + filename);
    }

    return res.status(400).send("Não foi achado o gatinho no ID especificado.");
  } catch (err) {
    return res.status(500).send(err.message);
  }
};

module.exports = {
  upload,
  getImage,
};

const { usuarioService } = require("../service");
const jwt = require("jsonwebtoken");

const create = async (req, res) => {
  try {
    const { role, login, password } = req.body;

    await usuarioService.create(role, login, password);
    return res.status(200).send();
  } catch (error) {
    return res
      .status(400)
      .json({ message: "Falha no Registro. Usuário já existente" });
  }
};

const sign_in = async (req, res) => {
  const { login, password } = req.body;

  try {
    if (await usuarioService.verifyUser(login, password))
      return res.json({
        token: jwt.sign({ login }, process.env.SECRET),
      });
    else {
      return res
        .status(401)
        .json({ message: "Falha na autenticação. Usuário ou senha inválidos" });
    }
  } catch (error) {
    console.log(error);
  }
};

module.exports = {
  create,
  sign_in,
};

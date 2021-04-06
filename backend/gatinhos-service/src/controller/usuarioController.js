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
        token:
          "JWT " +
          jwt.sign({ login: login, password: password }, process.env.SECRET),
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

const loginRequired = async (req, res, next) => {
  if (req.user) {
    next();
  } else {
    return res.status(401).json({ message: "Usuário não autorizado" });
  }
};

const profile = async (req, res, next) => {
  if (req.user) {
    res.send(req.user);
    next();
  } else {
    return res.status(401).json({ message: "Token Inválido" });
  }
};
module.exports = {
  create,
  sign_in,
  loginRequired,
  profile,
};

const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const token = req.headers["x-access-token"];
  if (!token)
    return res.status(401).send({ message: "Usuário não autenticado" });

  jwt.verify(token, process.env.SECRET, function (err, decoded) {
    if (err)
      return res.status(401).send({ message: "Usuário não autenticado" });

    req.username = decoded.username;
    next();
  });
};

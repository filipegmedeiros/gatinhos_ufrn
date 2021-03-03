const bcrypt = require("bcrypt");
const { userModel } = require("../model");

const create = async (role, login, password) => {
  let user = await userModel.findOne({ login: login });
  if (!user) {
    password = bcrypt.hashSync(password, 10);
    let user = new userModel({ role, login, password });
    await user.save();
  } else {
    throw "Usúario Existente";
  }
};

const verifyUser = async (login, password) => {
  try {
    let user = await userModel.findOne({ login: login });
    const passwordMatch = await bcrypt.compareSync(password, user.password);
    return passwordMatch;
  } catch (error) {
    console.log(error);
  }
  return false;
};

module.exports = {
  create,
  verifyUser,
};

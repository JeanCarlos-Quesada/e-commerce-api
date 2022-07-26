const mysql2 = require("mysql2");
const configDB = require("../config/config_db");
const connection = mysql2.createConnection(configDB);

exports.GetAll = (req, res) => {
  connection
    .promise()
    .query("call GetAllProducts()")
    .then((result) => {
      return res.status(200).json(result[0][0]);
    })
    .catch((error) => {
      return res.status(500).json(error);
    });
};

exports.GetMostPopular = (req, res) => {
  connection
    .promise()
    .query("call GetMostPopularProducts()")
    .then((result) => {
      return res.status(200).json(result[0][0]);
    })
    .catch((error) => {
      return res.status(500).json(error);
    });
};

exports.GetOne = (req, res) => {
  connection
    .promise()
    .query("call GetOneProduct(?)", [req.query.productID])
    .then((result) => {
      return res.status(200).json(result[0][0]);
    })
    .catch((error) => {
      return res.status(500).json(error);
    });
};

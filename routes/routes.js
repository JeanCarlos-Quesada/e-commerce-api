const router = require("express").Router();
const productController = require("../controllers/productController");

module.exports = () => {
  router.get("/Products/GetAll", productController.GetAll);
  router.get("/Products/GetMostPopular", productController.GetAll);
  router.get("/Products/GetOne", productController.GetOne);

  return router;
};

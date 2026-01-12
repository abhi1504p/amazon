const express = require('express');

const Product = require("../models/product");
const auth = require("../middleware/auth");
const productRouter = express.Router();


// get all product
productRouter.get('/api/products', auth, async (req, res) => {
    try {
        const products = await Product.find({category: req.query.category});

        return res.json(products);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

module.exports = productRouter;
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

// Search the product
productRouter.get('/api/products/search/:name', auth, async (req, res) => {
    try {
        const searchQuery = req.params.name;
        console.log(searchQuery)
        const products = await Product.find({
            name: {$regex: searchQuery, $options: 'i'},
        });
        console.log(products);
        res.json(products);
    } catch (e) {
        console.log(e.toString())
        res.status(500).json({error: e.message});
    }
})


module.exports = productRouter;
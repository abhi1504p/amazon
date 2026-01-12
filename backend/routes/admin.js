const express = require('express');
const admin = require("../middleware/admin");
const Product = require("../models/product");
const adminRouter = express.Router();

// add product

adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const {name, description, images, quantity, price, category} = req.body;

        let product = new Product({
            name,
            description,
            quantity,
            price,
            images,
            category
        });
        product = await product.save();
        res.json(product);


    } catch (e) {
        console.log(e.message);
        res.status(500).json({error: e.message})
    }
})

// get all product
adminRouter.get('/admin/get-product', admin, async (req, res) => {
    try {
        const products = await Product.find({});

        return res.json(products);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

adminRouter.delete('/admin/delete-product/:id', admin, async (req, res) => {
    try {
        const {id} = req.params;

        const product = await Product.findById(id);

        if (!product) {
            return res.status(404).json({msg: "Product not found"});
        }

        await Product.findByIdAndDelete(id);

        res.json({msg: "Product deleted successfully"});


    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

module.exports = adminRouter;
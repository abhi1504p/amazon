// Import packages
const express = require("express")
const mongoose = require("mongoose")
require('dotenv').config();


// Init
const app = express();
const PORT = process.env.PORT


// Import from other files
const authRouter = require("./routes/auth");

// Middleware
app.use(authRouter);

// Connections
mongoose.connect(process.env.DB_URL).then(() => {
    console.log("Connection Successful with database")
}).catch((e) => {
    console.log(e)
})


// Create Api Server
app.listen(PORT, () => {
    console.log(`Server started at port http://localhost:${PORT}`)
})

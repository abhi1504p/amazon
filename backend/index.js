// Import packages
const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();

// Init
const app = express();
const PORT = process.env.PORT;

// Import from other files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(userRouter);

app.use(productRouter);

// Connections
mongoose
  .connect(process.env.DB_URL)
  .then(() => {
    console.log("Connection Successful with database");
  })
  .catch((e) => {
    console.log(e);
  });

// Create Api Server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server started at port http://localhost:${PORT}`);
});

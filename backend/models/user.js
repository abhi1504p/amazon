const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        match: /.+\@.+\..+/
    },
    password: {
        type: String,
        required: true,
        minLength: 6
    },
    address: {
        type: String,
        default: ''
    },
    type: {
        type: String,
        default: "user"
    }


})

const User = mongoose.model("User", userSchema);

module.exports = User;
const mongoose = require('mongoose');
const bcrypt = require('bcrypt-nodejs');

let userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
    },
    password: {
        type: String, 
        require: true,
    },
    email: {
        type: String,
        require: true,
    },
    token: {
        type: String,
        require: true,
        default: '',
    },
});

userSchema.methods.hashPassword = password => {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(10));
}

userSchema.methods.comparePassword = (password, hash) => {
    return bcrypt.compareSync(password, hash);
}

module.exports = mongoose.model('User', userSchema);
const {Schema, model} = require('mongoose');

// Esquema do usuário
const userSchema = new Schema({
    firstName: String,
    lastName: String,
    email: String,
    cep: Number,
    password: String
})

module.exports = model('User', userSchema);
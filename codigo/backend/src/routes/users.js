const { Router } = require ('express');
const router = Router();
const User = require('../models/User');

const faker = require('faker');
faker.locale = 'pt_BR';

router.get('/api/users', async (req,res) =>{
    const users = await User.find();
    res.json({users});
})

router.get('/api/users/create', (req,res)=> {
    // Cria dados falsos para povoar o banco
    res.json({message: '5 Users created'});
     for (let i=0; i <5; i++){
         User.create({
            firstName: faker.name.firstName(),
            lastName: faker.name.lastName(),
            email: faker.internet.email(),
            cep: i+100,
            password: '1234'
         })
     }
})

module.exports = router;
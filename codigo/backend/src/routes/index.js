const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()
const Auction = require('../models/auction')
const User = require('../models/user')
const Item = require('../models/item')

router.get('/', (req, res) => {
    res.send("TÀ FUNCIONANDO")
})

//@desc Adicionando novo usuário
//@route POST /adduser
router.post('/adduser', actions.addNew)

//@desc Adicionando novo item
//@route POST /additem
router.post('/additem', actions.addNewItem)

//@desc Retornando todos os leilões cadastrados no banco
//@desc GET /getauctions
router.get('/getauctions', (req,res) =>{
    Auction.find(function(err,auction){
        res.json(auction)
    })
})

//@desc Retornando todos os itens cadastrados no banco
//@desc GET /getitens
router.get('/getitens', (req,res) =>{
    Item.find(function(err,auction){
        res.json(auction)
    })
})

//@desc Retornando todos os leilões cadastrados no banco
//@desc GET /getauctions
router.get('/teste', actions.teste)

//@desc Procurando um item
//@route POST /finditem
router.post('/finditem', actions.findItem)

//@desc Adicionando novo leilão
//@route POST /addauction
router.post('/addauction', actions.addNewAuction)

//@desc Autenticação de um usuário
//@route POST /authenticate
router.post('/authenticate', actions.authenticate)

//@desc Pegar token de um usuário
//@route GET /getinfo
router.get('/getinfo', actions.getinfo)

//@desc Pegar token de um usuário
//@route GET /getinfo
router.post('/sendemail', actions.sendemail)

//@desc Dar um lance
//@route POST /bid
router.post('/bid', actions.bid)

module.exports = router
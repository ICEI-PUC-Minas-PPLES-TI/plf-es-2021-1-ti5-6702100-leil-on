const express = require('express')
const actions = require('../methods/actions')
const webActions = require('../methods/webActions')
const router = express.Router()
const Auction = require('../models/auction')
const User = require('../models/user')
const Item = require('../models/item')


router.get('/', (req, res) => {
    res.render('login')
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
router.get('/teste', (req,res) =>{
    res.render('teste')
})

//@desc Procurando um item
//@route POST /finditem
router.post('/finditem', actions.findItem)

//@desc Adicionando novo leilão
//@route POST /addauction
router.post('/addauction', actions.addNewAuction)

//@desc Autenticação de um usuário
//@route POST /authenticate
router.post('/authenticate', actions.authenticate)

//@desc Autenticação de um usuário
//@route POST /authenticate
router.get('/dashboard', (req,res) => {
    Auction.find().lean().then((auctions) => {
        res.render('dashboard', {auctions: auctions})
    }).catch((err)=>{
        res.render('login')
    })
})

router.get('/registerauction/:email', (req,res) => {
    res.render('addauction')
})

//@desc Autenticação de um usuário
//@route POST /authenticate
router.post('/authenticateweb', (req,res) => {
    webActions.authenticate(req, req.body.email, req.body.password, function(response){
        if(response.success == true){
            Auction.find().lean().then((auctions) => {
                    res.render('dashboard', {auctions: auctions, email: req.body.email})
            }).catch((err)=>{
                res.render('login')
            }) 
        }
        else{
            res.render('login')
        }
    })
})

//@desc Pegar token de um usuário
//@route GET /getinfo
router.post('/search', actions.search)

//@desc Pegar token de um usuário
//@route GET /getinfo
router.post('/sendemail', actions.sendemail)

//@desc Dar um lance
//@route POST /bid
router.post('/bid', actions.bid)


module.exports = router
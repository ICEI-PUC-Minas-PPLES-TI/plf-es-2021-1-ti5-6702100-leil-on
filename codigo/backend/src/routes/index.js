const express = require('express')
const actions = require('../methods/actions')
const webActions = require('../methods/webActions')
const dataActions = require('../methods/dataActions')
const router = express.Router()
const Auction = require('../models/auction')
const User = require('../models/user')
const Item = require('../models/item')

const localFunctions = require('../scratch/store')
if (typeof localStorage === "undefined" || localStorage === null) {
    var LocalStorage = require('node-localstorage').LocalStorage;
    localStorage = new LocalStorage('./scratch');
  }


router.get('/', (req, res) => {res.render('login')})


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
    var date = localStorage.getItem('date')
    var formatedDate = date.split('-')
    dataActions.returnDays(formatedDate[2],formatedDate[1], formatedDate[0])
    res.send(date)
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

router.post('/additemWeb', (req,res)=> {
    if(!req.body.name || !req.body.description || !req.body.endDate){
        res.redirect('/')
    }else{
        localFunctions.setDataEmail(req.body.name, req.body.description, req.body.endDate)
        res.render('additem')     
    }
   })

router.post('/finalize', (req,res)=> {
    var nameAuction = localStorage.getItem('nameAuction')
    var email = localStorage.getItem('email')
    var description = localStorage.getItem('description')
    var items = localStorage.getItem('items')
    var date = localStorage.getItem('date')
    var formatedDate = date.split('-')
    dataActions.returnDays(formatedDate[2],formatedDate[1], formatedDate[0], function(timeDiff){
        User.find({email: email}, function(err, user){
            webActions.addNewAuction(nameAuction, items, user.name, email, date, description, timeDiff, function(success){
                 if(success == true){
                     localStorage.removeItem('items')
                     req.flash('success_msg', 'Leilão gravado com sucesso')
                     res.redirect('dashboard')
                 }else{
                    localStorage.removeItem('items')
                    req.flash('error_msg', 'Leilão não gravado')
                    res.redirect('dashboard')
                 }
            } )
        })
    })
    
})

router.post('/registerItem', (req,res) => {
    localFunctions.getEmail(function(email){
        User.find({email: email}, function(err, user){
            var linkedAuction = localStorage.getItem('nameAuction')
            webActions.addNewItem(req.body.name, req.body.price, user.name, linkedAuction, req.body.description, function(success){
                if(success == true){
                    req.flash('success_msg', 'Item cadastrado com sucesso')
                    var items = localStorage.getItem('items')
                    localStorage.removeItem('items')
                    if(items == null){
                        localStorage.setItem('items', req.body.name + ',')
                    }else{
                        localStorage.setItem('items', items + req.body.name + ',')
                    }
                    res.render('additem')
                }else{
                    req.flash('error_msg', 'Item não foi cadastrado')
                    res.render('additem')
                }
            })
        })
    })
    
    
})

router.get('/registerauction/', (req,res) => {res.render('addauction')})

router.get('/logout', (req,res) => {
    localFunctions.delete()
    res.redirect('./')
})

//@desc Autenticação de um usuário
//@route POST /authenticate
router.post('/authenticateweb', (req,res) => {
    webActions.authenticate(req, req.body.email, req.body.password, function(response){
        if(response.success == true){
            Auction.find().lean().then((auctions) => {
                localStorage.setItem('items','')
                localFunctions.delete()
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
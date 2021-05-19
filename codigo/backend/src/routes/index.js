const express = require('express')
const actions = require('../methods/actions')
const webActions = require('../methods/webActions')
const dataActions = require('../methods/dataActions')
const router = express.Router()
const Auction = require('../models/auction')
const User = require('../models/user')
const Item = require('../models/item')
const fs = require('fs')
var FileReader = require('filereader')
  , fileReader = new FileReader()
  ;

const { resolve } = require('path')
if (typeof localStorage === "undefined" || localStorage === null) {
    var LocalStorage = require('node-localstorage').LocalStorage;
    localStorage = new LocalStorage('./scratch');
  }

//@desc Rota padrão
//@route GET /
router.get('/', (req, res) => {res.render('login')})

//@desc Adicionando novo usuário
//@route POST /adduser
router.post('/adduser', actions.addNew)

//@desc Adicionando novo usuário versão web
//@route POST /adduserweb     
router.post('/adduserweb', webActions.addNew)

//@desc Adicionando novo item
//@route POST /additem
router.post('/additem', actions.addNewItem)

//@desc Retornando todos os leilões cadastrados no banco
//@desc GET /getauctions
router.get('/teste', (req,res) =>{
    dataActions.returnTime(21,5,2021,function(days){
        console.log('dias ' + days)
    })
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

//@desc Dashboard
//@route GET /dashboard
router.get('/dashboard', (req,res) => {
    var email = localStorage.getItem('email')
    if(email == null)
    res.redirect('/',{error:true, msg:'Faça o login para ter acesso ao site'})
    else{
        Auction.find().lean().then((auctions) => {
            res.render('dashboard', {auctions: auctions})
        }).catch((err)=>{
            res.redirect('/')
        })
    } 
})

//@desc Dashboard
//@route GET /dashboard
router.get('/myauctions', (req,res) => {
    var email = localStorage.getItem('email')
    if(email == null)
    res.redirect('/',{error:true, msg:'Faça o login para ter acesso ao site'})
    else{
        User.findOne({"email": email}, function(err,user){
            Auction.find({"owner":user.name}).lean().then((auctions) => {
                res.render('dashboard', {auctions: auctions})
            }).catch((err)=>{
                res.redirect('/')
            })
        })

        
    } 
})

//@desc Redirecionamento para a tela de cadastro de item
//@route POST /additemWeb
router.post('/additemWeb', (req,res)=> {
    if(!req.body.name || !req.body.description || !req.body.endDate){
        res.render('addauction', {error:true, msg:'Coloque todos os dados do leilão'})
    }else{
        localStorage.setItem('nameAuction',req.body.name)
        localStorage.setItem('description',req.body.description)
        localStorage.setItem('date',req.body.endDate)
        res.render('additem')     
    }
   })

   router.post('/saveimg',(req,res)=>{
    var linkedAuction = localStorage.getItem('nameAuction')
    console.log('salvei a img')
    localStorage.setItem('img' + linkedAuction, req.body.imagens)
    res.send('ok')
})
//@desc Finaliza o cadastro do leilão
//@route POST /finalize
router.post('/finalize', (req,res)=> {
    var email = localStorage.getItem('email')
    if (email == null){
        res.redirect('/')
    }else{
        var nameAuction = localStorage.getItem('nameAuction')
        var description = localStorage.getItem('description')
        var items = localStorage.getItem('items')
        var date = localStorage.getItem('date')
        var formatedDate = date.split('-')
        dataActions.returnTime(formatedDate[0],formatedDate[1], formatedDate[2], function(timeDiff){
            User.findOne({"email": email}, function(err, user){
    
                webActions.addNewAuction(nameAuction, items, user.name, email, date, description, timeDiff, function(success){
                     if(success == true){
                         localStorage.removeItem('items')
                         res.redirect('dashboard')
                     }else{
                        localStorage.removeItem('items')
                        res.redirect('dashboard')
                     }
                } )
            })
        })
        
    }
   
   
})

//@desc Redirecionamento da tela de cadastro de itens
//@route GET /additemweb
router.get('/additemweb', (req,res) =>{ 
    var linkedAuction = localStorage.getItem('nameAuction')
    var img = localStorage.getItem('img' + linkedAuction)
    if (img == null){
        res.render('additem', {error:true, msg:'Salve a imagem do seu item.'})
    }
    if(req.body.name == undefined){
        res.render('additem', {error:true, msg:'Houve um erro na hora de salvar o item.'})
    }else{
        var email = localStorage.getItem('email')
        if(email == null)
           res.redirect('/',{error:true, msg:'Faça o login para ter acesso ao site'})
        else{ 
            var email = localStorage.getItem('emaill')
                User.find({email: email}, function(err, user){
                   
                    webActions.addNewItem(req.body.name, req.body.price, user.name, linkedAuction, req.body.description,img, function(success){
                        if(success == true){
                            localStorage.removeItem('img' + linkedAuction)
                            var items = localStorage.getItem('items')
                            localStorage.removeItem('items')
                            if(items == null){
                                localStorage.setItem('items', req.body.name + ',')
                            }else{
                                localStorage.setItem('items', items + req.body.name + ',')
                            }
                            res.render('additem', {success: true})
                        }else{
                            res.render('additem', {error: true, msg:'Item não foi cadastrado'})
                        }
                    })
                })
            
        
        }    
    }
    
}
)

//@desc Cadastro de um item
//@route POST /registerItem
router.post('/registerItem', (req,res) => {
    if(!req.body.name || !req.body.price || !req.body.description ){
        req.flash('error_msg', 'Item não foi cadastrado')
                    res.render('additem', {error: true, msg:'Informe todos os dados'})
    }
    else {       
        var email = localStorage.getItem('email') 
            User.findOne({"email": email}, function(err, user){
                var linkedAuction = localStorage.getItem('nameAuction')
                var img = localStorage.getItem('img'+ linkedAuction)
                    webActions.addNewItem(req.body.name, req.body.price, user.name, linkedAuction, req.body.description,img, function(success){
                        if(success == true){
                            req.flash('success_msg', 'Item cadastrado com sucesso')
                            var items = localStorage.getItem('items')
                            localStorage.removeItem('items')
                            if(items == null){
                                localStorage.setItem('items', req.body.name + ',')
                            }else{
                                localStorage.setItem('items', items + req.body.name + ',')
                            }
                            res.render('additem', {success: true})
                        }else{
                            req.flash('error_msg', 'Item não foi cadastrado')
                            res.render('additem', {error: true, msg:'Item não foi cadastrado'})
                        }
                    })
                
                
            })
        
    }
    
})

//@desc Redirecionamento para a tela de registro de leilão
//@route GET /registerauction
router.get('/registerauction/', (req,res) => {res.render('addauction')})

//@desc Logout do usuário
//@route GET /logout
router.get('/logout', (req,res) => {
    localStorage.clear()
    res.redirect('./')
})

//@desc Autenticação de um usuário
//@route POST /authenticate
router.post('/authenticateweb', (req,res) => {
    webActions.authenticate(req, req.body.email, req.body.password, function(response){
        if(response.success == true){
            Auction.find().lean().then((auctions) => {
                localStorage.clear()
                localStorage.setItem('items','')
                localStorage.setItem('email', req.body.email)
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
    
router.post('/sendmsg', actions.sendmsg)

router.get('/faq',(req,res)=>{res.render('faq')})

module.exports = router
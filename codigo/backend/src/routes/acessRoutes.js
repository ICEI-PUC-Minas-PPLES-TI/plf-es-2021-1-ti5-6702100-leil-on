const express = require('express')
const router = express.Router()
const Auction = require('../models/auction')
const User = require('../models/user')
const Item = require('../models/item')

//@desc Retorna o item do id
//@route GET /item/id
router.get('/item/:id', (req,res) =>{
    Item.findById(req.params.id, function(err, item){
        if(err) res.json({sucess:false, msg:'Houve um erro'})
        else if(!item) res.json({sucess: false, msg:'Item não encontrado'})
        else res.json({success: true, item: item})
    })
})

//@desc Retorna o usuário do id
//@route GET /user/id
router.get('/user/:id', (req,res) =>{
    User.findById(req.params.id, function(err, user){
        if(err) res.json({sucess:false, msg:'Houve um erro'})
        else if(!user) res.json({sucess: false, msg:'Não encontrado'})
        else res.json({sucess:true, user:user})
    })
})

//@desc Retorna o auction do id
//@route GET /auction/id
router.get('/auction/:id', (req,res) =>{
    Auction.findById(req.params.id, function(err, auction){
        if(err) res.json({sucess:false, msg:'Houve um erro'})
        else if(!auction) res.json({sucess: false, msg:'Não encontrado'})
        else res.json({sucess: true, auction: auction})
    })
})

module.exports = router
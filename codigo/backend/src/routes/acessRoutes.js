const express = require('express')
const router = express.Router()
const Auction = require('../models/auction')
const User = require('../models/user')
const Item = require('../models/item')
const webActions = require('../methods/webActions')
const actions = require('../methods/actions')

//@desc Retorna o item do id
//@route GET /item/id
router.get('/item/:id', (req,res) =>{
    Item.findById(req.params.id, function(err, item){
        if(err) res.json({sucess:false, msg:'Houve um erro'})
        else if(!item) res.json({sucess: false, msg:'Item não encontrado'})
        else{
            var categorias = item.categories.toString()
           res.render('item', {name: item.name, 
            price: item.price, 
            imagens: item.imagens, 
            categorias : categorias,
           description: item.description,
        image1: item.imagens[0],
        image2: item.imagens[1],
        image3: item.imagens[2],
        image4: item.imagens[3],})
        } 
        
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
        else{
            Item.find().lean().then((items) => {
                var auctionItems = []
                items.forEach(function(item,index){
                    if(item.linkedAuction == auction.name){
                        auctionItems.push(item)
                    }
                })
                var name = auction.name
                var endDate = auction.endDate
                var description = auction.description
                var owner = auction.owner
                res.render('auction', {name: name,
                    endDate: endDate,
                    items : auctionItems,
                    description: description,
                owner: owner})
            }).catch((err)=>{
                console.log(err)
                res.redirect('/dashboard')
            })
                    
          //  console.log('Os itens são ' + itemsAuction)
            
        }
    })
})

router.get('/cookie', (req,res) =>{
    res.send('cookie')
})

router.post('/searchItemsWeb', webActions.searchItems)

module.exports = router
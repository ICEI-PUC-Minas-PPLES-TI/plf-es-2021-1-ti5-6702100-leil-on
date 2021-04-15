var User = require('../models/user')
var Auction = require('../models/auction')
var Item = require('../models/item')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var emailconfig = require('../config/emailconfig')

var functions = {
    // Função para cadastrar novo usuário 
    addNew: function (req, res) {
     if ((!req.body.name) || (!req.body.password) || (!req.body.email) || (!req.body.cep) || (!req.body.telefone)) {
            res.json({success: false, msg: 'Preencha todos os campos'})
        }
        else {
            User.findOne({
                email: req.body.email
            }, function (err, user) {
                    if (err) throw err
                    if (!user) {
                        var newUser = User({
                            name: req.body.name,
                            password: req.body.password,
                            email: req.body.email,
                            cep: req.body.cep,
                            telefone: req.body.telefone
                        })
                        newUser.save(function (err, newUser) {
                            if (err) {
                                res.json({success: false, msg: 'Falha ao gravar o usuário.'})
                            }
                            else {
                                res.json({success: true, msg: 'Usuário gravado com sucesso.'})
                            }
                        })
                      }
                    else {
                        res.json({sucess: false, msg: 'Usuário já cadastrado'})
                    }
            }
            )           
        }
    },
    // Função para fazer um lance, atualiza o maior lance e o histórico de lances
    bid: function(req,res){
console.log("Dei um lance")
    },
    // Função para enviar email para o comprador e vencedor
    sendemail: function(req,res){
         if(!req.body.owner  || !req.body.winner  || !req.body.item){
             res.json({sucess: false, msg: 'Preencha todos os campos'})
         }
         else{
             var mailOption1 = {
              from: ' plataformadeleiloesleilon@gmail.com',
              to: req.body.owner,
              subject: 'Você vendeu o item ' + req.body.item,
              text: 'O seu item foi vendido para ' + req.body.winner + ', entre em contato para finalizar a venda.'
             }
             var mailOption2 = {
                from: ' plataformadeleiloesleilon@gmail.com',
                to: req.body.winner,
                subject: 'Você venceu o leilão do item ' + req.body.item,
                text: 'O item foi comprado por você, o dono é ' + req.body.owner + ', entre em contato para finalizar a venda.'
             }
             emailconfig.sendMail(mailOption1, function(error, info){
                if (error) {
                  res.json({sucess: false, msg: 'Email não foi enviado ', error: error})
                } else {
                    transporter.sendMail(mailOption2, function(error, info){
                        if (error) {
                            res.json({sucess: false, msg: 'Email não foi enviado ', error: error})
                        } else {
                            res.json({sucess:true, msg: info.response});
                        }
                      });
                }
              });
         }
    },
    // Função para cadastrar um item no banco de dados
    addNewItem: function (req, res) {
        if ((!req.body.name) || (!req.body.price)|| (!req.body.linkedAuction)|| (!req.body.image) || (!req.body.itemOwner) || (!req.body.description) || (!req.body.historic) || (!req.body.hightestbidder) || (!req.body.categories) ) {
               res.json({success: false, msg: 'Preencha todos os campos'})
           }
           else {
            var newItem = Item({
                   name: req.body.name,
                   price: req.body.price,
                   image: req.body.image,
                   itemOwner: req.body.itemOwner,
                   linkedAuction: req.body.linkedAuction,
                   description: req.body.description,
                   historic: req.body.historic,
                   hightestbidder: req.body.hightestbidder,
                   categories: req.body.categories
               });
               newItem.save(function (err, newItem) {
                   if (err) {
                       res.json({success: false, msg: 'Falha ao gravar o item ' + newItem.name})
                   }
                   else {
                       res.json({success: true, msg: 'Item gravado com sucesso' + newItem.name})
                   }
               })
           }
       },
       // Função para cadastrar um leilão no banco de dados
    addNewAuction: function (req, res) {
        if ((!req.body.name) || (!req.body.items)|| (!req.body.endDate) || (!req.body.owner)) {
               res.json({success: false, msg: 'Preencha todos os campos'})
           }
           else {
            var newAuction = Auction({
                   name: req.body.name,
                   items: req.body.items,
                   owner: req.body.owner,
                   endDate: req.body.endDate
               });
               newAuction.save(function (err, newAuction) {
                   if (err) {
                       res.json({success: false, msg: 'Falha ao gravar o leilão.'})
                   }
                   else {
                       res.json({success: true, msg: 'Leilão gravado com sucesso.'})
                   }
               })
           }
       },
       // Função para encontrar um item, ele passa o nome do item, o dono e o leilão que ele está vinculado
       findItem: function(req, res){  
        Item.findOne({
            name: req.body.name,
            itemOwner: req.body.itemOwner,
            linkedAuction: req.body.linkedAuction
           }, function(err, item){
               if(err) throw err
               if(!item){
                   res.status(403).send({sucess: false, msg: 'Falha ao procurar o item, item não existe ou os dados estão errados'})
               }
               else{
                   res.json({sucess: true, msg:'Item encontrado.',item: item})
               }
           }
           )
       },
       // Autenticação do usuário, procura se o usuário existe e caso esse usuário exista verifica se a senha está certa
    authenticate: function (req, res) {
        User.findOne({
            email: req.body.email
        }, function (err, user) {
                if (err) throw err
                if (!user) {
                    res.status(403).send({success: false, msg: 'Falha na autenticação, usuário não encontrado'})
                }
                else {
                    user.comparePassword(req.body.password, function (err, isMatch) {
                        if (isMatch && !err) {
                            var token = jwt.encode(user, config.secret)
                            var decodedtoken = jwt.decode(token, config.secret)
                            res.json({success: true, token: token, decodedtoken: decodedtoken })
                        }
                        else {
                            return res.status(403).send({success: false, msg: ' Autenticação falhou, senha errada'})
                        }
                    })
                }
        }
        )
    },
    // Procura um usuário e retorna seu token
    getinfo: function (req, res) {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, config.secret)
            return res.json({success: true, msg: 'Olá ' + decodedtoken.name})
        }
        else {
            return res.json({success: false, msg: 'Sem headers'})
        }
    }
}

module.exports = functions
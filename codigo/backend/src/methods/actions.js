var User = require('../models/user')
var Auction = require('../models/auction')
var Item = require('../models/item')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var emailconfig = require('../config/emailconfig')
const gdrive = require("../config/imageupload");
var drive = require("../config/driveId")
var fs = require('fs')
const { sendMail } = require('../config/emailconfig')

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
                            telefone: req.body.telefone,
                            reputation: -1,
                            counttransaction: 0
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
       if(!req.body.hightestbidder || !req.body.hightestbidderEmail || !req.body.itemName || !req.body.linkedAuction || !req.body.bid){
           res.json({sucess:false, msg:'Preencha todos os campos.'})
       }else{
        Item.findOne({
            name: req.body.itemName,
            linkedAuction: req.body.linkedAuction
           }, function(err, item){
               if(err) throw err
               if(!item){
                   res.status(403).send({sucess: false, msg: 'Falha ao procurar o item, item não existe ou os dados estão errados'})
               }
               else{
                if(req.body.bid <= item.price)
                res.json({sucess:false, msg:'Valor menor ou igual ao valor atual, dê um lance maior'})
               var historic = []
               historic = item.historic
               historic.push(req.body.hightestbidder + "-" +req.body.bid)
                Item.findOneAndUpdate({
                    "name": item.name,
                    "itemOwner": item.itemOwner,
                    "linkedAuction": item.linkedAuction },
                    {
                        $set:{
                            "historic": historic,
                            "hightestbidder": req.body.hightestbidder,
                            "name": item.name,
                            "price": req.body.bid,
                            "imagens": item.imagens,
                            "itemOwner": item.itemOwner,
                            "linkedAuction": req.body.linkedAuction,
                            "description": item.description,
                            "hightestbidderEmail": req.body.hightestbidderEmail,
                            "categories": item.categories
                        }
                    
                },function(err){
                    if(err)
                    res.json({sucess:false, msg:'Não atualizou'})
                    else
                    res.json({sucess:true, msg:'Lance computado'})
                })
            }
           }
           )
       }
    },
    // Função para enviar email para o comprador e vencedor
    sendemail: function(item, winner, owner){
             var mailOption1 = {
              from: ' plataformadeleiloesleilon@gmail.com',
              to: owner,
              subject: 'Você vendeu o item ' + item,
              text: 'O seu item foi vendido para ' + winner + ', entre em contato para finalizar a venda.'
             }
             var mailOption2 = {
                from: ' plataformadeleiloesleilon@gmail.com',
                to: winner,
                subject: 'Você venceu o leilão do item ' + item,
                text: 'O item ' + item +' foi comprado por você, o dono é ' + owner + ', entre em contato para finalizar a venda.'
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
         
    },
    // Função para cadastrar um item no banco de dados
    addNewItem: async function (req, res) {
        if ((!req.body.name) || (!req.body.price)|| (!req.body.linkedAuction)|| (!req.body.imagens) || (!req.body.itemOwner) || (!req.body.description) || (!req.body.categories) ) {
               res.json({success: false, msg: 'Preencha todos os campos'})
           }
           else {
            var links = [] 
            for(i = 0; i < 4; i++){
                saveInDrive(req.body.imagens[i], req.body.name + i, function(link){
                    links.push(link)
                    if(links.length == req.body.imagens.length){
                        var newItem = Item({
                            name: req.body.name,
                            price: req.body.price,
                            imagens: links,
                            itemOwner: req.body.itemOwner,
                            linkedAuction: req.body.linkedAuction,
                            description: req.body.description,
                            historic: undefined,
                            hightestbidder: undefined,
                            hightestbidderEmail: undefined,
                            categories: req.body.categories
                        });
                        newItem.save(function (err, newItem) {
                            if (err) {
                                remove(newItem.name, links.length)
                                res.json({success: false, msg: 'Falha ao gravar o item ' + newItem.name})
                            }
                            else {
                                remove(newItem.name,links.length)
                               res.json({success: true, msg: 'Item gravado com sucesso ' + newItem.name})
                            }
                        })
                    }
                })
               }     
           }
       },
       // Função para cadastrar um leilão no banco de dados
    addNewAuction: function (req, res) {
        if ((!req.body.time) || (!req.body.name) || (!req.body.items)|| (!req.body.endDate) || (!req.body.owner)|| (!req.body.description)|| (!req.body.owneremail)) {
               res.json({success: false, msg: 'Preencha todos os campos'})
           }
           else {
            var newAuction = Auction({
                   name: req.body.name,
                   items: req.body.items,
                   owner: req.body.owner,
                   owneremail: req.body.owneremail,
                   endDate: req.body.endDate,
                   description: req.body.description
               });
                timeoutAuction(newAuction, req.body.time)
               newAuction.save(function (err, newAuction) {
                   if (err) {   
                    res.json({success: false, msg: 'Falha ao gravar o leilão' + newAuction.name})
                   }
                   else {
                       res.json({success: true, msg: 'Leilão gravado com sucesso ' + newAuction.name})
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
    },
    teste: function(req, res){
        console.log('teste')
    }
}

async function timeoutAuction(auc, time){
    setTimeout(async function(){
        Auction.findOneAndDelete({name: auc.name,
            owner: auc.owner,
            endDate: auc.endDate,
            items: auc.items,
            description: auc.description,
            emailowner: auc.emailowner
        }, function(err){
            for(i = 0; i < auc.items.length;i++){
                Item.findOneAndDelete({
                    name: auc.items[i],
                    linkedAuction: auc.name
                }, function(err, item){
                    if(err) throw err
                    sendemail(item.name,item.hightestbidderEmail, auc.emailowner )
                })
            }
            if(err) throw err
        }) }, time*3600000)
}

// Função que gera o arquivo baseado na String Base64 que é passada, gera o arquivo e o salva no drive. Retorna o link
 function saveInDrive(str,name, callback) {
    var decodedStr = str.replace(/^data:image\/\w+;base64,/, '');
        fs.writeFileSync("./temp/" + name +".jpg", decodedStr,{encoding: 'base64'}, function(err) {
            if(err) throw err
    });
     gdrive.imageUpload(name+".jpg", "./temp/" + name +".jpg",(fileId) =>{
        link = "https://drive.google.com/file/d/" + fileId + "/view"      
        return callback(link)  
     })
    
      }

      // Função assíncrona para remover os arquivos temp gerados para gravar no drive
  async function remove(name, quant){
    for(i = 0; i < quant; i++){
          fs.unlink("./temp/" + name+ i +".jpg",function(err){
            if(err) throw err
        })
    }   
  }

module.exports = functions
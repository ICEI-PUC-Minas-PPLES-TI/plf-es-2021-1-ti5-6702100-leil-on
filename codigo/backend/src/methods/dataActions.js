var Auction = require('../models/auction')
var Item = require('../models/item')
var fs = require('fs')

var functions = {
    timeoutAuction: async function timeoutAuction(auc, time){
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
    },
         remove:     // Função assíncrona para remover os arquivos temp gerados para gravar no drive
         async function remove(name, quant){
           for(i = 0; i < quant; i++){
                 fs.unlink("./temp/" + name+ i +".jpg",function(err){
                   if(err) throw err
               })
           }   
         },
         generateImg: function (str,name) {
            
            var decodedStr = str.replace(/^data:image\/\w+;base64,/, ''); 
            fs.writeFileSync("./views/images/" + name +".jpg", decodedStr,{encoding: 'base64'}, function(err) {
                    if(err) throw err
                    else console.log('Gerei a imagem')
            });
              }
}

module.exports = functions



  
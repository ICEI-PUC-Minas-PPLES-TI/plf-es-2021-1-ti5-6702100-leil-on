var Auction = require('../models/auction')
var Item = require('../models/item')
const gdrive = require("../config/imageupload");
var drive = require("../config/driveId")
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
    saveInDrive :// Função que gera o arquivo baseado na String Base64 que é passada, gera o arquivo e o salva no drive. Retorna o link
    function saveInDrive(str,name, callback) {
       var decodedStr = str.replace(/^data:image\/\w+;base64,/, '');
           fs.writeFileSync("./temp/" + name +".jpg", decodedStr,{encoding: 'base64'}, function(err) {
               if(err) throw err
       });
        gdrive.imageUpload(name+".jpg", "./temp/" + name +".jpg",(fileId) =>{
           link = "https://drive.google.com/file/d/" + fileId + "/view"      
           return callback(link)  
        })
       
         },
         remove:     // Função assíncrona para remover os arquivos temp gerados para gravar no drive
         async function remove(name, quant){
           for(i = 0; i < quant; i++){
                 fs.unlink("./temp/" + name+ i +".jpg",function(err){
                   if(err) throw err
               })
           }   
         },
}

module.exports = functions



  
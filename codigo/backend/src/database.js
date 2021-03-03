const moongose = require('mongoose');

function connect(){
      moongose.connect('mongodb://localhost/leil-on', {
        useUnifiedTopology: true
     })

     console.log('Banco conectado')
    }

module.exports = { connect };
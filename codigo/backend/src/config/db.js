const moongose = require('mongoose')
const dbConfig = require('./dbconfig')

    const connectDB = async() =>{
      try{
        console.log('Conectando')
        const conn = await moongose.connect(dbConfig.database,{
          useNewUrlParser: true,
          useUnifiedTopology: true,
          useFindAndModify: true
        })
        console.log('MongoDb conectado:' + conn.connection.host)
      }
      catch(err){
        console.log(err)
        process.exit(1)
      }
    }


module.exports = connectDB    

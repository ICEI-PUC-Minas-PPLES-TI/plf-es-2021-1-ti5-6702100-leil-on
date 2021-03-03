const app = require('./app');
const { connect } = require('./database'); 

function main(){
      // Conectando ao banco de dados
       connect();
      // Iniciando aplicação express
      app.listen(8081)
      console.log('Server na porta 8081')
}

main();

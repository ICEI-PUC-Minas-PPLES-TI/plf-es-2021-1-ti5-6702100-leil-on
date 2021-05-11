const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/db')
const passport = require('passport')
var bodyParser = require('body-parser')
const routes = require('./routes/index')
const acessRoutes = require('./routes/acessRoutes')
const handlebars = require('express-handlebars')
const session = require('express-session')
const flash = require('connect-flash')
//Configurações
  // Conecta-se ao banco mongoDB
  connectDB()

  const app = express()

  if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'))
  }

  // View Engine
  app.engine('handlebars', handlebars({defaultLayout: 'main'}))
  app.set('view engine', 'handlebars')
  app.use(cors())
  // Sessão
  app.use(session({
    secret: "1a2b3c4dLeilonebom",
    resave: true,
    saveUninitialized: true
  }))
  app.use(flash())
  // Body Parser
  app.use(bodyParser.json({limit: "50mb"}));
  app.use(bodyParser.urlencoded({limit: "50mb", extended: true, parameterLimit:50000}));
  // Routes
  app.use(routes)
  app.use(acessRoutes)
  app.use(passport.initialize())
  // Static files
  app.use(express.static('views/images'))
  app.use(express.static('views/'))
  // Passport config
  require('./config/passport')(passport)
  // Middleware
  app.use(function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
  });
  app.use((req,res,next) =>{
      res.locals.success_msg = req.flash("success_msg")
      res.locals.error_msg = req.flash("error_msg")
      next()
  })

const PORT = process.env.PORT || 3000

app.listen(PORT, console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`))
const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/db')
const passport = require('passport')
var bodyParser = require('body-parser')
const routes = require('./routes/index')
const acessRoutes = require('./routes/acessRoutes')
const handlebars = require('express-handlebars')

// Conecta-se ao banco mongoDB
connectDB()

const app = express()

if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'))
}

app.engine('handlebars', handlebars({defaultLayout: 'main'}))
app.set('view engine', 'handlebars')
app.use(cors())
app.use(bodyParser.json({limit: "50mb"}));
app.use(bodyParser.urlencoded({limit: "50mb", extended: true, parameterLimit:50000}));
app.use(routes)
app.use(acessRoutes)
app.use(passport.initialize())
app.use(express.static('views/images'))
app.use(express.static('views'))
require('./config/passport')(passport)


const PORT = process.env.PORT || 3000

app.listen(PORT, console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`))
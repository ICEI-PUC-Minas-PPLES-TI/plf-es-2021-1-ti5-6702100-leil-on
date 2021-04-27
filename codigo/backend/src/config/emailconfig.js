const nodemailer = require ('nodemailer')

var trasponter = nodemailer.createTransport({
    service: 'gmail',
    secure: false,
    requireTLS: true,
    port: 587,
    auth: {
        user: 'plataformadeleiloesleilon@gmail.com',
        pass: 'projetotis5'
    }
})

module.exports = trasponter
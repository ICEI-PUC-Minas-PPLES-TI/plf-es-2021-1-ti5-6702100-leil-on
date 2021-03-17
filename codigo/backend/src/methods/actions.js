var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')

var functions = {
    addNew: function (req, res) {
        if ((!req.body.name) || (!req.body.password) || (!req.body.email) || (!req.body.cep)) {
            res.json({success: false, msg: 'Preencha todos os campos'})
        }
        else {
            var newUser = User({
                name: req.body.name,
                password: req.body.password,
                email: req.body.email,
                cep: req.body.cep
            });
            newUser.save(function (err, newUser) {
                if (err) {
                    res.json({success: false, msg: 'Erro ao salvar'})
                }
                else {
                    res.json({success: true, msg: 'Salvo com sucesso'})
                }
            })
        }
    },
    authenticate:  function  (req, res) {
        User.findOne({
            email: req.body.email
        }, function (err, user) {
                if (err) throw err
                if (!email) {
                    res.status(403).send({success: false, msg: 'Autenticação falhou, usuário não encontrado'})
                }

                else {
                    user.comparePassword(req.body.password, function (err, isMatch) {
                        if (isMatch && !err) {
                            var token = jwt.encode(user, config.secret)
                            res.json({success: true, token: token})
                        }
                        else {
                            return res.status(403).send({success: false, msg: 'Autenticação falhou, senha errada'})
                        }
                    })
                }
        }
        )
    },
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
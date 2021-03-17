const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()
const path = require('path')
const { response } = require('express');

router.get('/', (req, res) => {
    res.send('O fumaça mandou você me dar 20 reais')
})

router.get('/dashboard', (req, res) => {
    res.send('Dashboard')
})

//@desc Adding new user
//@route POST /adduser
router.post('/adduser', actions.addNew)

//@desc Authenticate a user
//@route POST /authenticate
router.post('/authenticate', actions.authenticate)

//@desc Get info on a user
//@route GET /getinfo
router.get('/getinfo', actions.getinfo)


module.exports = router
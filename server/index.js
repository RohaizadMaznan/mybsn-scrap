const express = require('express')
const { urlencoded } = require('body-parser');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const { checkUserIsAuthorize } = require('./middleware');
const PORT = 5000;

const app = express()

app.use(urlencoded({ extended: false }))

const whitelist = ['http://localhost:3000']
app.use(cors({ 
    allowedHeaders: ['Content-Type', 'Cookie', 'set-cookie'], 
    credentials: true, 
    origin: (origin, callback)=>{
      // if(origin){
      //     if (whitelist.indexOf(origin) !== -1) {
      //       callback(null, true)
      //     } else {
      //       callback(new Error('Not allowed by CORS'))
      //     }
      // }
        callback(null, true)
    }, 
    methods: ['POST', 'PUT', 'GET', 'OPTIONS', 'HEAD'] 
}))
app.use(express.json())
app.use(cookieParser())

app.use('/login', require('./login'))
app.use('/authorized', checkUserIsAuthorize, require('./authorized'))

app.listen(PORT)


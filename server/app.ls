cluster = require 'cluster'
numCPUs = require('os').cpus().length
prelude = require 'prelude-ls'

log = console.log.bind(console)

express = require 'express'
port = 3000

runServer = ->
  app = express()

  app.get '/', (req,res)->
    res.send "Hello World"


  app.listen port
  log "Server listening on port #{port}"

if cluster.isMaster
  [cluster.fork() for i from 1 to numCPUs]

  cluster.on 'exit', (worker,code,signal)->
    log "Worker #{worker.process.pid} died"
else
  runServer()

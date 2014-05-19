cluster = require 'cluster'
num-cpus = require('os').cpus().length - 1
_ = require 'prelude-ls'

log = console.log.bind(console)

express = require 'express'
exp-hbs = require 'express3-handlebars'
moment = require 'moment'
port = 3000

data = require '../server/test.json'


# given an array of objects and a key,
# return a hash where the keys are the values of the
# provided key, and the values are the objects.
# example: make-index("id", array) ==>
# {"12-af-3c": <data>,  "99-4b-08": <data>}
make-index = (index, arr)->
  hash = {}
  push = (tag, value)->
    hash[tag] = _.concat [[value], (hash[tag] ? [])]

  for x in arr
    tag = x[index]

    switch typeof! tag
    | "Array"   => [push(t, x) for t in tag]
    | otherwise => push(tag, x)

  return hash


model = {
  by-id: make-index('guid', data.events)
  by-tag: make-index('tags', data.events)
  by-date: make-index('date', data.events)

  tags: data.events
    |> _.concat-map (.tags)
    |> _.unique
}


/*
usage

do-format req, res, {
  json: -> res.send data
  html: -> res.render "home"
}

is roughly equivalent to

fmt = req.accepts('json','html')
switch fmt
| "json" => res.send data
| "html" => res.render "home"
| otherwise => res.send 406


*/
do-format = (req, res, options)->
  fmt = req.accepts Object.keys(options)
  (options[fmt] ? res.send.bind(res,406))()


# filter an object to match array keys
with-keys = (obj, keys)->
  fn = (prev,curr)->
    prev[curr] = obj[curr]
    prev
  _.fold(fn, {}, keys)

hbs-helpers = {
  date: (ctx,block)->
    fmt = block?.hash?.format || "MMM Do, YYYY"
    return moment(new Date(ctx)).format(fmt)
  log: (ctx)->
    log ctx
}




run-server = ->
  app = express()

  # set template system
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', '.hbs'

  app.engine '.hbs', exp-hbs {
    layouts-dir: "#{__dirname}/views/layouts"
    default-layout: 'main'
    extname: '.hbs'
    helpers: hbs-helpers
  }

  app.route('/')
    .get (req,res,next)->
      do-format req, res, {
        json : -> res.send data
        html : -> res.render "home", {
          title: "Home"
          tags: model.by-tag
        }
      }

  app.route('/event/:id')
    .get (req,res,next)->
      event = _.head(model.by-id[req.params.id]) ? {}
      tags =  model.by-tag `with-keys` event.tags

      do-format req,res, {
        json: -> res.send event
        html: -> res.render "event", {
          event: event
          tags: tags
        }
      }

  app.route('/tag')
    .get (req,res,next)->
      res.send model.tags

  app.route('/tag/:tag')
    .get (req,res,next)->
      res.send model.by-tag[req.params.tag]



  app.listen port
  log "Server listening on port #{port}"

if cluster.is-master
  [cluster.fork() for i from 1 to num-cpus]

  cluster.on 'exit', (worker,code,signal)->
    log "Worker #{worker.process.pid} died"
else
  run-server()
#
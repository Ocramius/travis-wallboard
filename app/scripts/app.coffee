React = require('react')
pkg = require('../../package.json')

TravisApi = require './travis/api.coffee'
RepositoryList = require './repository-list.coffee'

api = new TravisApi()


render = ->
  api.getRepos(member: 'Halama').done((repos) ->
    console.log 'repos', repos
    React.renderComponent(RepositoryList(repos: repos), document.body)
  )

render()
setInterval(render, 10000)
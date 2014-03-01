React = require 'react'
director = require 'director'
pkg = require '../../package.json'

TravisApi = require './travis/api.coffee'
RepositoryList = require './repository-list.coffee'
RepositoryFilter = require './repository-filter.coffee'

api = new TravisApi()
interval = false

router = new director.Router(

  '/board/:filterName/:filterValue':
    on: (filterName, filterValue) ->
      clearInterval(interval)

      filterParams = {}
      filterParams[filterName] = filterValue

      render = () ->
        api.getRepos(filterParams).done((repos) ->
          React.renderComponent(RepositoryList(repos: repos), document.body)
        )

      render()
      interval = setInterval(render, 10000)
    after: ->
      clearInterval( interval )

  '/': ->
    React.renderComponent(RepositoryFilter(
      onSubmit: (response) ->
        router.setRoute "board/member/#{response.member}"
    ), document.body)


)
router.init('/')


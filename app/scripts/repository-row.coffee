
React = require('react')
Repository = require './repository.coffee'

{table, tr, td, th, thead, tbody, span, div, a} = React.DOM

RepositoryRow = React.createClass(
  render: ->
    repos = @props.repos.map((repo) ->
      (div {className: 'col-md-6'},
        (Repository {repository: repo, key: repo.id})
      )
    )
    (div {className: 'row'}, repos)
)

module.exports = RepositoryRow
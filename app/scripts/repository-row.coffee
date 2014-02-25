
React = require('react')
Repository = require './repository.coffee'

{table, tr, td, th, thead, tbody, span, div, a} = React.DOM

RepositoryRow = React.createClass(

  displayName :'RepositoryRow'

  render: ->
    repos = @props.repos.map((repo) ->
      (div {className: 'col-md-6', key: repo.id},
        (Repository {repository: repo})
      )
    )
    (div {className: 'row'}, repos)
)

module.exports = RepositoryRow
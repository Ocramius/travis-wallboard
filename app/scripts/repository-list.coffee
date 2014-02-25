
React = require('react')
RepositoryRow = require './repository-row.coffee'
_ = require('underscore')

{table, tr, td, th, thead, tbody, span, div, a, input} = React.DOM

RepositoryList = React.createClass(

  displayName :'RepositoryList'

  render: ->
    repositoryRows = _.chain(@props.repos)
    .groupBy (repo, index) ->
        Math.floor(index / 2)
    .toArray()
    .map((reposPair) ->
        (RepositoryRow {repos: reposPair, key: reposPair[0].id + '-' + reposPair[1].id})
      )

    (div {className: 'container-fluid'}, repositoryRows)
)

module.exports = RepositoryList
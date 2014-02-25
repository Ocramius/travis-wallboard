
React = require('react')
RepositoryRow = require './repository-row.coffee'
_ = require('underscore')

{table, tr, td, th, thead, tbody, span, div, a, input} = React.DOM

RepositoryList = React.createClass(

  render: ->
    repositoryRows = _.chain(@props.repos)
    .groupBy (repo, index) ->
        Math.floor(index / 2)
    .toArray()
    .map((reposPair) ->
        (RepositoryRow {repos: reposPair})
      )

    (div {className: 'container-fluid'}, repositoryRows)
)

module.exports = RepositoryList
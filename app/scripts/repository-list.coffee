
React = require('react')
RepositoryRow = require './repository-row.coffee'
_ = require('underscore')

{table, tr, td, th, thead, tbody, span, div, a, input} = React.DOM

RepositoryList = React.createClass(

  displayName :'RepositoryFilter'

  pairs: ->
    _.chain(@props.repos)
      .groupBy (repo, index) ->
          Math.floor(index / 2)
      .toArray()

  render: ->
    if !@props.repos.length
      (div {className: 'container-fluid'},
        (div {className: 'alert alert-default'}, 'No repositories found.')
      )
    else
      rows = @pairs().map((reposPair) ->
        (RepositoryRow {repos: reposPair, key: reposPair[0].id + '-' + reposPair[1]?.id})
      )

      (div {className: 'container-fluid'}, rows)
)

module.exports = RepositoryList
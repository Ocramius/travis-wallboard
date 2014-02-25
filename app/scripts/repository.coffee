
React = require 'react'
Duration = require './duration.coffee'
timeAgo = require 'damals'
_ = require 'underscore'

{span, div, a} = React.DOM

Repository = React.createClass

  displayName: 'Repository'

  travisUrl: ->
    "https://travis-ci.org/#{@props.repository.slug}"

  classForStatus: ->
    switch @props.repository.last_build_state
      when 'started', 'created' then 'alert-warning'
      when 'errored' then 'alert-danger'
      else 'alert-success'

  humanFinished: ->
    'Finished ' + timeAgo(new Date(@props.repository.last_build_finished_at)) if @props.repository.last_build_finished_at

  shouldComponentUpdate: (nextProps) ->
    !_.isEqual(@props, nextProps)

  render: ->
    (div {className: "repository alert #{@classForStatus()}"},
      (a {href: @travisUrl()}, @props.repository.slug),
      (span {className: 'pull-right'}, @props.repository.last_build_number)
      (div {className: 'repository-details'},
        (Duration {startedAt: @props.repository.last_build_started_at, finishedAt: @props.repository.last_build_finished_at }) if @props.repository.last_build_started_at
        (span {}, 'Waiting') if !@props.repository.last_build_started_at
        (span {className: 'pull-right'}, @humanFinished())
      )
    )

module.exports = Repository
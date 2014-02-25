
React = require 'react'
duration = require 'humanize-duration'
timeAgo = require 'damals'

{span, div, a} = React.DOM

Repository = React.createClass

  travisUrl: ->
    "https://travis-ci.org/#{@props.repository.slug}"

  classForStatus: ->
    switch @props.repository.last_build_state
      when 'started', 'created' then 'alert-warning'
      when 'errored' then 'alert-danger'
      else 'alert-success'

  humanDuration: ->
    if @props.repository.last_build_duration
       buildDuration = @props.repository.last_build_duration * 1000
    else
      buildDuration = Math.round((new Date() - new Date(@props.repository.last_build_started_at)) / 1000) * 1000

    duration( buildDuration )

  humanFinished: ->
    'Finished ' + timeAgo(new Date(@props.repository.last_build_finished_at)) if @props.repository.last_build_finished_at

  componentDidMount: ->
    repository = @
    @interval = setInterval ->
      repository.forceUpdate()
    , 1000

  componentWillUnmount: ->
    clearInterval @interval

  render: ->
    (div {className: "repository alert #{@classForStatus()}"},
      (a {href: @travisUrl()}, @props.repository.slug),
      (span {className: 'pull-right'}, @props.repository.last_build_number)
      (div {className: 'repository-details'},
        (span {className: 'fa fa-clock-o '}),
        (span {}, "#{@humanDuration()}")
        (span {className: 'pull-right'}, @humanFinished())
      )
    )

module.exports = Repository
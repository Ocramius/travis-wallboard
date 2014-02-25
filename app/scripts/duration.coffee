
React = require 'react'
duration = require 'humanize-duration'
timeAgo = require 'damals'

{span, div, a} = React.DOM

Duration = React.createClass

  displayName: 'Duration'

  humanDuration: ->
    end = if @props.finishedAt then new Date(@props.finishedAt) else new Date()
    buildDuration = Math.round((end - new Date(@props.startedAt)) / 1000) * 1000

    duration( buildDuration )

  isRunning: ->
    !@props.finishedAt


  componentWillMount: ->
    @resolveRunning()

  componentDidUpdate: ->
   @resolveRunning()

  resolveRunning: ->
    if @isRunning()
      @startCounter()
    else
      @stopCounter()

  componentWillUnmount: ->
    @stopCounter()

  startCounter: ->
    return if @interval
    repository = @
    @interval = setInterval ->
      repository.forceUpdate()
    , 1000

  stopCounter: ->
    clearInterval( @interval ) if @interval

  render: ->
    (span {},
      (span {className: 'fa fa-clock-o '}),
      (span {}, "#{@humanDuration()}")
    )

module.exports = Duration
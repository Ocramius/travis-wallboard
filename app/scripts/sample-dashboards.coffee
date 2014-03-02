
React = require 'react'

{span, a, ul, li} = React.DOM

SampleDashboards = React.createClass

  displayName: 'SampleDashboards'

  dashboards: [
    'keboola'
    'facebook'
    'travis-ci'
    'gruntjs'
    'apiaryio'
    'twitter'
    'aws'
  ]

  render: ->
    (span {className: 'sample-dashboards'},
      "Sample dashboards:",
      (ul {className: 'list-inline'}, @dashboards.map((dashboard) ->
        (li null,
          (a {href: "#/board/owner_name/#{dashboard}"}, dashboard)
        )
      ))
    )

module.exports = SampleDashboards
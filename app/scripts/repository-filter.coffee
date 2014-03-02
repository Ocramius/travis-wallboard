
React = require('react')
SampleDashborads = require './sample-dashboards.coffee'
TravisApi = require './travis/api.coffee'

_ = require('underscore')

{div, form, h1, input, span, button, img} = React.DOM
travisApi = new TravisApi()

RepositoryFilter = React.createClass(

  displayName :'RepositoryFilter'

  getInitialState: ->
    error: ''
    isLoading: false

  getMember: ->
    @refs.member.getDOMNode().value.trim()

  focusMember: ->
    @refs.member.getDOMNode().focus()

  componentDidMount: ->
    @focusMember()

  handleSubmit: ->
    member = @getMember()

    @setState(
      error: ''
      isLoading: true
    )
    travisApi
    .getRepos(member: member)
    .done(((repos) ->
        @handleReposResponse(member, repos)
      ).bind(@))

    false

  handleReposResponse: (member, repos) ->

    @setState(
      error: if repos.length then '' else 'No repositories found for member ' + member
      isLoading: false
    )
    @focusMember()

    if repos.length
      @props.onSubmit(
        member: member
      )

  render: ->
    formClass = 'form-horizontal form-repository-filter ' + if @state.error then 'has-error' else ''
    (form {className: formClass, onSubmit: @handleSubmit },
      (h1 null, 'Travis CI Wallboard')
      (div {className: 'input-group input-group-lg has-feedback'},
        (input {type: 'text', ref: 'member', className: 'form-control', placeholder: 'Your Github name'})
        (span className: 'fa fa-refresh fa-spin form-control-feedback') if @state.isLoading
        (span {className: 'input-group-btn'},
          (button {className: 'btn btn-success', type: 'submit'}, 'Go to dashboard!')
        )
      )
      (span {className: 'help-block'}, @state.error)
      (SampleDashborads())
    )
)

module.exports = RepositoryFilter

_ = require 'underscore'

class Api

  getRepos: (params) ->
    $.ajax
      type: 'GET'
      url: 'https://api.travis-ci.org/repos'
      dataType: 'json'
      data: _.extend params,
        orderBy: 'name'
      accepts:
        json: 'application/json; version=2'
    .then((response) ->
      return response.repos
    )

module.exports = Api

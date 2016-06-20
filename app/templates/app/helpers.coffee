Github = require 'github'
_      = require 'lodash'

class Helpers
  extractSentinelName: (appName) =>
    _.kebabCase appName

  githubUserInfo: (user, callback) =>
    github = new Github

    unless _.isEmpty process.env.GITHUB_TOKEN
      github.authenticate
        type: 'oauth'
        token: process.env.GITHUB_TOKEN

    github.users.getForUser {user}, (error, user) =>
      callback error, user

module.exports = new Helpers

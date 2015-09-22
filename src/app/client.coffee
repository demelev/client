redmine = require 'promised-redmine'

var config = {
  host: "10.3.10.58", // required
  apiKey: "a9f8aa3391da26c74da09d6537084f63b4e62dfe", // required
  protocol: "http"
}

redmineApi = new Redmine(config)
redmineApi.getIssues()
  .success(function(issues){
    console.log("Get issues: " + JSON.stringify(issues));
  }) 

module.exports = redmineApi


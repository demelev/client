Redmine = require 'promised-redmine'
{View, $} = require 'space-pen'
$ = require 'jquery'
require 'jquery-ui'

class Issue extends View
    @content: (params) ->
        @div class: "issue-item", =>
            @h3 "Name: #{params.issue.subject}"

class IssueList extends View
    @content: (params) ->
        @div outlet: "list", id: "issue-list", =>
            @h1 class: "issue-text", "Issues"
            @ul outlet: "list", =>
    
    initialize: (params) ->
        $(@list).sortable({
            axis: "y",
            containment: "parent"
        })
        $(@list).disableSelection()
    
    add_issue: (issue) ->
        issue = new Issue(issue: issue)
        @list.append(issue)
            

class MainScreen extends View
    @content: (params) ->
        @div id: "main-screen", =>
            @div id: "top-panel"
            @div id: "central-panel"
            @div id: "bottom-panel"

# Create redmine client
config = {
  host: "10.3.10.249",
  apiKey: "a4489a9592b2153dfcb6de7b58096da4fcd7c4c8",
  protocol: "http"
}

redmineApi = new Redmine(config)

issue_list = new IssueList()
main_screen = new MainScreen()

$("body").append main_screen
$("#central-panel").append issue_list
$ ->
    $("#issue-list").sortable
    $("#issue-list").disableSelection

redmineApi.getIssues().success( (issues) -> 
     for issue in issues.issues
         issue_list.add_issue issue
).otherwise( ->
    console.log "otherwise"
) 




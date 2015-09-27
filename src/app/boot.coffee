Redmine = require 'promised-redmine'
{View, $} = require 'space-pen'
$ = require 'jquery'
require 'jquery-ui'

class Issue extends View
    @content: (params) ->
        @div class: "issue-item", =>
            @h3 "Name: #{params.title}"

class IssueList extends View
    @content: (params) ->
        @div outlet: "list", id: "issue-list", =>
            @h1 class: "issue-text", "Issues"
            @ul outlet: "list", =>
                @li "Eugene"
                @li "Dmitrii"
                @li "Dm2"
    
    initialize: (params) ->
        $(@list).sortable()
        $(@list).disableSelection()
    
    add_issue: (issue) ->
        issue = new Issue(title: issue.subject)
        @list.append(issue)
            

class MainScreen extends View
    @content: (params) ->
        @div id: "main-screen", =>
            @div id: "top-panel"
            @div id: "central-panel"
            @div id: "bottom-panel"

# Create redmine client
config = {
  host: "10.3.10.58",
  apiKey: "a9f8aa3391da26c74da09d6537084f63b4e62dfe",
  protocol: "http"
}

redmineApi = new Redmine(config)

issue_list = new IssueList()
main_screen = new MainScreen()

$("body").append main_screen
$("#central-panel").append issue_list
$ ->
    $("#issue-list").sortable
    $("#main-screen").sortable
    $("#issue-list").disableSelection

redmineApi.getIssues().success( (issues) -> 
     for issue in issues.issues
         issue_list.add_issue issue
).otherwise( ->
    console.log "otherwise"
) 




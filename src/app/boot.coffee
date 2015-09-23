Redmine = require 'promised-redmine'
{View, $} = require 'space-pen'

class Issue extends View
    @content: (params) ->
        @div class: "issue-item", =>
            @h3 "Name: #{params.title}"

class IssueList extends View
    @content: (params) ->
        @div id: "issue-list", =>
            @h1 class: "issue-text", "Issues"
            @ol outlet: "list" 
    
    add_issue: (issue) ->
        issue = new Issue(title: issue.subject)
        @list.append(issue)
            

# Create redmine client
config = {
  host: "10.3.10.58",
  apiKey: "a9f8aa3391da26c74da09d6537084f63b4e62dfe",
  protocol: "http"
}

redmineApi = new Redmine(config)

issue_list = new IssueList()
$("div").append issue_list

redmineApi.getIssues().success( (issues) -> 
     for issue in issues.issues
         issue_list.add_issue issue
         #console.log issue.subject
).otherwise( ->
    console.log "otherwise"
) 




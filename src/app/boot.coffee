Redmine = require 'promised-redmine'
#{View, $} = require 'space-pen'
#
#class Issue extends View
#    @content: (params) ->
#        @div class: "issue-item", =>
#            @h3 "Name: #{params.title}"
#
#class IssueList extends View
#    @content: (params) ->
#        @div class: "issue-list", =>
#            @h1 "Issues"
#            @div outlet: "list" 
#    
#    add_issue: (issue) ->
#        issue = new Issue(title: issue.subject)
#        @list.append(issue)
            

config = {
  host: "10.3.10.58",
  apiKey: "a9f8aa3391da26c74da09d6537084f63b4e62dfe",
  protocol: "http"
}


redmineApi = new Redmine(config)

#issue_list = new IssueList()
#$('body').append issue_list

console.log "Before"
redmineApi.getIssues().success( (issues) -> 
     console.log "After"
#     for issue in issues.issues
#         console.log issue.subject
         #issue_list.add_issue issue
).otherwise( ->
    console.log "otherwise"
) 




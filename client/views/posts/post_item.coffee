Template.postItem.helpers 
  domain: () ->
    a = document.createElement 'a'
    a.href = @url
    a.hostname
  ownPost: () ->
    @userId is Meteor.userId()
  commentsCount: () ->
    Comments.find(postId: @_id).count()
  upvotedClass: ->
    if Meteor.userId() && !_.include @upvoters, Meteor.userId()
      return 'btn-primary upvoteable'
    else
      return 'disabled'

Template.postItem.events
  'click .upvoteable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id
Template.commentSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()

    comment = 
      body: e.target.body.value
      postId: template.data._id

    Meteor.call 'comment', comment, (err, commentId) ->
      if err
        throwError err.reason
      else
        e.target.body.value = ''
      
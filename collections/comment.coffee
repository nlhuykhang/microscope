@Comments = new Meteor.Collection 'comments'

Meteor.methods
  comment: (attr) ->
    user = Meteor.user()
    post = Posts.findOne attr.postId

    unless user
      throw new Meteor.Error 401, 'fasfasdf'

    unless attr.body
      throw new Meteor.Error 422, 'swerewr'

    unless attr.postId
      throw new Meteor.Error 422, 'qwrwe'
    
    comment = _.extend (_.pick attr, 'postId', 'body'),
      userId: user._id
      author: user.username,
      submitted: new Date().getTime() 

    comment._id = Comments.insert comment

    createCommentNotificaiton comment

    return comment._id
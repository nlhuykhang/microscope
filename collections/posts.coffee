@Posts = new Meteor.Collection 'posts'

Posts.allow 
  update: ownsDocument
  remove: ownsDocument

Posts.deny
  update: (userId, post, fieldNames) ->
    (_.without fieldNames, 'url', 'title').length > 0

Meteor.methods
  post: (postAttr) ->
    user = Meteor.user()
    postWithSameLink = Posts.findOne url: postAttr.url

    unless user
      throw new Meteor.Error 401, 'You need to login to post a new story'

    unless postAttr.title
      throw new Meteor.Error 422, 'Please fill in a headline'

    if postAttr.url && postWithSameLink
      throw new Meteor.Error 302, 'This link has already been posted', postWithSameLink._id

    post = _.extend(_.pick(postAttr, 'url', 'title', 'message'), {
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
      commentsCount: 0
      upvoters: []
      votes: 0
    })

    return Posts.insert(post)

  upvote: (postId) ->
    user = Meteor.user()

    unless user
      throw new Meteor.Error 401, 'You need to login to upvote'

    Posts.update 
      _id: post._id
      upvoters: $ne: user._id
    ,
      $addToSet: 
        upvoters: user._id
      $inc: 
        votes: 1

    return
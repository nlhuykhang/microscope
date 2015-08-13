Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: ->
    [
      Meteor.subscribe 'notifications' 
    ]

@PostListController = RouteController.extend
  template: 'postsList'
  increment: 5
  limit: ->
    return parseInt(@params.postsLimit) || @increment
  findOptions: ->
    limit: @limit()
    sort: @sort
  waitOn: ->
    return Meteor.subscribe 'posts', @findOptions()
  data: ->
      posts: Posts.find {}, @findOptions()
      nextPath: @nextPath()

@NewPostListController = PostListController.extend
  sort: 
    submitted: -1
    _id: -1
  nextPath: ->
    return Router.routes.newPosts.path 
      postsLimit: @limit() + @increment

@BestPostListController = PostListController.extend
  sort:
    votes: -1
    submitted: -1
    _id: -1
  nextPath: ->
    return Router.routes.bestPosts.path 
      postsLimit: @limit() + @increment


@Router.map () ->
  @route 'home',
    path: '/'
    controller: NewPostListController

  @route 'newPosts',
    path: '/new/:postsLimit?'
    controller: NewPostListController

  @route 'bestPosts',
    path: '/best/:postsLimit?'
    controller: BestPostListController

  @route 'postPage', 
    path: '/posts/:_id'
    waitOn: () ->
      Meteor.subscribe 'comments', @params._id
    data: () -> 
      Posts.findOne @params._id

  @route 'postEdit', 
    path: '/posts/:_id/edit'
    data: () ->
      Posts.findOne @params._id

  @route 'postSubmit', path: '/submit'

  @route 'postsList', 
    path: '/:postsLimit?'
    controller: PostListController

requireLogin = () ->
  if !Meteor.user()
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
      @render 'accessDenied'

    @stop()
  else
    @next()

Router.before requireLogin, only: 'postSubmit'

Router.before (page) ->
  Errors.clearSeen()
  @next()
  return page
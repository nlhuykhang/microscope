Template.postsList.helpers
	hasMorePosts: ->
    @posts.rewind()
    return Router.current().postsLimit is @posts.fetch().length
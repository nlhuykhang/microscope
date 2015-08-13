Template.postEdit.helpers
	post: () ->
		console.log Session.get 'currentPostId'
		Posts.findOne Session.get 'currentPostId'


Template.postEdit.events
	'submit form': (e) ->
		e.preventDefault()

		currentPostId = this._id

		postProperties = 
			url: e.target.url.value
			title: e.target.title.value

		Posts.update currentPostId, {
			$set: postProperties
		}, (err) ->
			if err
				# alert err.reason
				Erros.throw error.reason
			else
				Router.go 'postPage', _id: currentPostId

	'click .delete': (e) ->
		e.preventDefault()

		if confirm 'Delete this post?'
			currentPostId = this._id
			
			Posts.remove currentPostId
			
			Router.go 'postsList'
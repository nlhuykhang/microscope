Template.postSubmit.events 
  'submit form': (e) ->
    e.preventDefault()

    post = 
      url: e.target.url.value
      title: e.target.title.value
      message: e.target.message.value

    Meteor.call 'post', post, (error, id) ->
      if error
        Errors.throw error.reason

        if error.error is 302
          Router.go 'postPage', _id: error.details
      else
        Router.go 'postPage', _id: id



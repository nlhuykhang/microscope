Template.notifications.helpers
  notifications: ->
    return Notifications.find userId: Meteor.userId(), read: false

  notificationCount: ->
    return Notifications.find(userId: Meteor.userId(), read: false).count()

Template.notification.helpers
  notificationPostPath: ->
    return Router.ruotes.postPage.path _id: @postId

Template.notification.events
  'click a': ->
    Notifications.update @_id, $set: read: true
    return
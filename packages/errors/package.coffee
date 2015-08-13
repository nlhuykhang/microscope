Package.describe
  summary: 'A pattern blad blad blad...'
  name: 'errors'
  version: '1.0.0'

Package.on_use (api, where) ->
  
  api.use ['minimongo', 'mongo-livedata', 'templating'], 'client'

  api.add_files ['errors.coffee', 'errors_list.html', 'errors_list.coffee'], 'client'

  if api.export
    api.export ['Errors']

  return
Package.describe({
  summary: 'asdfds',
  name: 'errors',
  version: '1.0.0'
});

Package.onUse(function(api, where){

  api.use(['minimongo', 'mongo-livedata', 'templating'], 'client');

  api.addFiles(['errors.js', 'errors_list.html', 'errors_list.js'], 'client');

  if(api.export)
    api.export('Errors');
});
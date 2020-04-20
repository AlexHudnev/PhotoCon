#= require ./cable

App.room = App.cable.subscriptions.create "ReportsChannel",
  received: (data) ->
    $('#messages').append data['report']

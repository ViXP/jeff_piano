# Timers objects class
export default class Timer
  constructor: ->
    @_counter = 0
    @_counting = null

  start: ->
    @_counting = setInterval(@_increment, 1)

  stop: ->
    clearInterval(@_counting)

  reset: ->
    @_counter = 0

  clear: ->
    @stop()
    @reset()

  display: ->
    @_counter

  _increment: =>
    @_counter += 1
# Dependencies
import Dispatcher from 'dispatcher'

export default recording_default = {
  fetchRecordings: ->
    Dispatcher.dispatch(type: 'FETCH_RECORDINGS_PENDING')
    window.fetch(
      Routes.recordings_url(), {
        method: 'GET'
      }
    ).then((resp) ->
      resp.json()
    ).then((data) ->
      Dispatcher.dispatch({ type: 'FETCH_RECORDINGS_FULLFILLED', data: data })
    ).catch((...errors) ->
      Dispatcher.dispatch(type: 'FETCH_RECORDINGS_REJECTED'))

  createRecording: (data) ->
    Dispatcher.dispatch(type: 'CREATE_RECORDING', data: data)
}
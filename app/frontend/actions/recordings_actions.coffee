# Dependencies
import Dispatcher from 'dispatcher'
import handle_errors from 'lib/handle_errors'

export default recording_default = {
  fetchRecordings: ->
    Dispatcher.dispatch(type: 'FETCH_RECORDINGS_PENDING')
    window.fetch(
      Routes.recordings_url()
      method: 'GET'
      credentials: 'same-origin'
      headers: new Headers({'Content-Type': 'application/json'})
    ).then(
      handle_errors
    ).then((resp) ->
      resp.json()
    ).then((data) ->
      Dispatcher.dispatch(type: 'FETCH_RECORDINGS_FULLFILLED', data: data)
    ).catch((...errors) ->
      Dispatcher.dispatch(type: 'FETCH_RECORDINGS_REJECTED'))

  saveRecording: (recording) ->
    Dispatcher.dispatch(type: 'SAVE_RECORDING_PENDING', data: recording)
    window.fetch(
      Routes.recordings_url()
      method: 'POST'
      credentials: 'same-origin'
      headers: new Headers(
        'Content-Type': 'application/json', 
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
          .content)
      body: JSON.stringify(recording: {
        title: recording.title, 
        recording_clips_attributes: recording.clips
      })
    ).then(
      handle_errors
    ).then((data) -> 
      Dispatcher.dispatch(type: 'SAVE_RECORDING_FULLFILLED', data: recording)
    ).catch((...errors) ->
      Dispatcher.dispatch(type: 'SAVE_RECORDING_REJECTED')
    )

  createRecording: (data) ->
    Dispatcher.dispatch(type: 'CREATE_RECORDING', data: data)

  startRecording: ->
    Dispatcher.dispatch(type: 'START_RECORDING')

  stopRecording: ->
    Dispatcher.dispatch(type: 'STOP_RECORDING')

  resetCurrentRecording: ->
    Dispatcher.dispatch(type: 'CLEAR_CURRENT_RECORDING')

  addClipToCurrentRecording: (clip) ->
    Dispatcher.dispatch(type: 'ADD_TO_CURRENT_RECORDING', data: clip)
}
# Dependencies
import Dispatcher from 'dispatcher'
import handle_errors from 'lib/handle_errors'

export default clips_actions = {
  fetchClips: ->
    Dispatcher.dispatch(type: 'FETCH_CLIPS_PENDING')
    window.fetch(
      Routes.clips_url()
      method: 'GET'
      credentials: 'same-origin'
      headers: new Headers({'Content-Type': 'application/json'})
    ).then(
      handle_errors
    ).then((resp) ->
      resp.json()
    ).then((data) ->
      Dispatcher.dispatch({ type: 'FETCH_CLIPS_FULLFILLED', data: data })
    ).catch((...errors) ->
      Dispatcher.dispatch(type: 'FETCH_CLIPS_REJECTED'))

  resetCurrentClip: ->
    Dispatcher.dispatch(type: 'CLEAR_CURRENT_CLIP')

  changeCurrentClip: (data) ->
    Dispatcher.dispatch({ type: 'CHANGE_CURRENT_CLIP', data: data })
}

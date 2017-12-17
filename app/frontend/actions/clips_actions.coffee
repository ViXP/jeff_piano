# Dependencies
import Dispatcher from 'dispatcher'

export default clips_actions = {
  fetchClips: ->
    Dispatcher.dispatch(type: 'FETCH_CLIPS_PENDING')
    window.fetch(
      Routes.clips_url(), {
        method: 'GET'
      }
    ).then((resp) ->
      resp.json()
    ).then((data) ->
      Dispatcher.dispatch({ type: 'FETCH_CLIPS_FULLFILLED', data: data })
    ).catch((...errors) ->
      Dispatcher.dispatch(type: 'FETCH_CLIPS_REJECTED'))
}

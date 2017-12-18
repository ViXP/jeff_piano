# Dependencies
import { ReduceStore } from 'flux/utils'
import Dispatcher from 'dispatcher'

class CurrentClipStore extends ReduceStore
  constructor: (p) ->
    super(Dispatcher)

  getInitialState: () ->
    return new Object()

  reduce: (state, action) ->
    switch action.type
      when 'CHANGE_CURRENT_CLIP'
        return action.data
      when 'CLEAR_CURRENT_CLIP', 'SAVE_RECORDING_PENDING'
        return new Object()
    return state

export default current_recording_store = new CurrentClipStore()
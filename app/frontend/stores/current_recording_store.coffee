# Dependencies
import { ReduceStore } from 'flux/utils'
import Dispatcher from 'dispatcher'

class CurrentRecordingStore extends ReduceStore
  constructor: (p) ->
    super(Dispatcher)

  getInitialState: () ->
    return
      clips: []
      recording: false

  reduce: (state, action) ->
    switch action.type
      when 'START_RECORDING'
        return { clips: [], recording: true }
      when 'STOP_RECORDING'
        return { ...state, recording: false }
      when 'CLEAR_CURRENT_RECORDING', 'SAVE_RECORDING_FULLFILLED'
        return { clips: [], recording: false }
      when 'ADD_TO_CURRENT_RECORDING'
        return {
          clips: [...state.clips, { 
            number: action.data.number, 
            start_time: action.data.start_time, 
            url: action.data.url
          }], recording: state.recording
        }
    return state

export default current_recording_store = new CurrentRecordingStore()
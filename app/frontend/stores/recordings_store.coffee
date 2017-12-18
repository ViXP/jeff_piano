# Dependencies
import { ReduceStore } from 'flux/utils'
import Dispatcher from 'dispatcher'
import uv4 from 'uuid/v4'

class RecordingsStore extends ReduceStore
  constructor: (p) ->
    super(Dispatcher)

  getInitialState: () ->
    return
      collection: []
      loading: true

  reduce: (state, action) ->
    switch action.type
      when 'FETCH_RECORDINGS_PENDING', 'SAVE_RECORDING_PENDING'
        return { ...state, loading: true }
      when 'FETCH_RECORDINGS_REJECTED', 'SAVE_RECORDING_REJECTED'
        return { ...state, loading: false }
      when 'FETCH_RECORDINGS_FULLFILLED'
        return { collection: action.data, loading: false }
      when 'SAVE_RECORDING_FULLFILLED'
        return { 
          collection: [{ ...action.data, id: uv4() }, ...state.collection],
          loading: false
        }
    return state

export default recordings_store = new RecordingsStore()
# Dependencies
import { ReduceStore } from 'flux/utils'
import Dispatcher from 'dispatcher'

class RecordingsStore extends ReduceStore
  constructor: (p) ->
    super(Dispatcher)

  getInitialState: () ->
    return
      collection: []
      loading: true

  reduce: (state, action) ->
    switch action.type
      when 'FETCH_RECORDINGS_PENDING'
        return { ...state, loading: true }
      when 'FETCH_RECORDINGS_REJECTED'
        return { ...state, loading: false }
      when 'FETCH_RECORDINGS_FULLFILLED'
        return { collection: action.data, loading: false }
    return state

export default recordings_store = new RecordingsStore()
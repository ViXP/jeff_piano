# Dependencies
import { ReduceStore } from 'flux/utils'
import Dispatcher from 'dispatcher'
import ClipsActions from 'actions/clips_actions'

class ClipsStore extends ReduceStore
  constructor: (p) ->
    super(Dispatcher)

  getInitialState: () ->
    return
      collection: new Object()
      loading: true

  reduce: (state, action) ->
    switch action.type
      when 'FETCH_CLIPS_PENDING'
        return { ...state, loading: true }
      when 'FETCH_CLIPS_REJECTED'
        return { ...state, loading: false }
      when 'FETCH_CLIPS_FULLFILLED'
        return { collection: action.data, loading: false }
    return state

export default clips_store = new ClipsStore()
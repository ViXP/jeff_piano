# Dependencies
import React from 'react'
import PropTypes from 'prop-types'
import { Container } from 'flux/utils'
import RecordingsStore from 'stores/recordings_store'
import RecordingsActions from 'actions/recordings_actions'

# Subcomponents
import Recording from 'components/Recording'

class Recordings extends React.Component
  @propTypes =
    changeCurrentClip: PropTypes.func.isRequired

  # Stores methods
  @getStores = ->
    return [ RecordingsStore ]

  @calculateState = ->
    return { recordings: RecordingsStore.getState() }

  constructor: (p) ->
    super(p)
    @_playback = {}

  componentWillMount: ->
    RecordingsActions.fetchRecordings()

  render: ->
    <section id="recordings">
      {if @state.recordings.loading
        <div className="loading"></div>
      else if @state.recordings.collection.length > 0
        <article>
          <h3>All Recordings</h3>
          {for recording in @state.recordings.collection
            <Recording recording={recording} key={recording.id}
              playRecording={@playRecording} />}
        </article>}
    </section>

  # Plays the sequence of clips
  playRecording: (clips) =>
    clearInterval(@_playback.interval) if @_playback.interval
    clips.sort((a, b) -> 
      if (a.start_time < b.start_time) 
        return -1 
      else if (a.start_time > b.start_time)
        return 1
      else
        return 0
    )
    @_playback = {
      timer: 0
      currentIndex: 0
      interval: setInterval(@checkClip.bind(this, clips), 1)
    }

  checkClip: (clips) ->
    if @_playback.currentIndex >= clips.length
      clearInterval(@_playback.interval)
    else if clips[@_playback.currentIndex].start_time == @_playback.timer
      @props.changeCurrentClip(clips[@_playback.currentIndex].number)
      @_playback.currentIndex += 1
    @_playback.timer += 1

export default Container.create(Recordings)
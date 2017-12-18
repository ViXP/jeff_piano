# Dependencies
import React from 'react'
import Timer from 'lib/Timer'
import { Container } from 'flux/utils'
import ClipsStore from 'stores/clips_store'
import CurrentClipStore from 'stores/current_clip_store'

import CurrentRecordingStore from 'stores/current_recording_store'
import ClipsActions from 'actions/clips_actions'
import RecordingsActions from 'actions/recordings_actions'

# Subcomponents
import PageLoading from 'components/PageLoading'
import Video from 'components/Video'
import ClipsButtons from 'components/ClipsButtons'
import RecordingButton from 'components/RecordingButton'
import RecordingForm from 'components/RecordingForm'
import Recordings from 'containers/Recordings'

class Play extends React.Component
  # Stores methods
  @getStores = ->
    return [ ClipsStore, CurrentClipStore, CurrentRecordingStore ]

  @calculateState = ->
    return
      clips: ClipsStore.getState()
      currentClip: CurrentClipStore.getState()
      currentRecording: CurrentRecordingStore.getState()

  constructor: (p) ->
    super(p)
    @timer = new Timer()

  componentWillMount: =>
    ClipsActions.fetchClips()
    @resetCurrentClip()
    @resetCurrentRecording()

  render: ->
    <div>
      <div className="column left">
        <Video currentClip={@state.currentClip} />
        <ClipsButtons clips={@state.clips.collection}
          changeCurrentClip={@changeCurrentClip} keyPressed={@keyPressed} />
      </div>
      <div className="column">
        <RecordingButton recording={@state.currentRecording.recording}
          record={@record} />
        <RecordingForm recording={@state.currentRecording}
          saveRecording={@saveRecording} />
        <Recordings changeCurrentClip={@changeCurrentClip} />
      </div>
      <PageLoading loading={@state.clips.loading} />
    </div>

  # Changes current clip
  changeCurrentClip: (number) =>
    ClipsActions.changeCurrentClip({
      number: number, url: @state.clips.collection[number]
    })
    @appendClipToRecording(number)

  # Keyboard key press handler
  keyPressed: (event) =>
    number = parseInt(event.key)
    if !isNaN(number) && number < 10 && @state.clips.collection[number]
      @changeCurrentClip(number)

  resetCurrentClip: ->
    ClipsActions.resetCurrentClip()

  # Appends current clip with correct timing
  appendClipToRecording: (number) =>
    if @state.currentRecording.recording
      if (@state.currentRecording.clips.length == 0)
        time = 1
        @timer.start()
      else
        time = @timer.display()
      RecordingsActions.addClipToCurrentRecording({ 
        number: number, start_time: time
      })

  # Operates the recording process
  record: =>
    if @state.currentRecording.recording
      RecordingsActions.stopRecording()
      @timer.clear()
    else
      RecordingsActions.startRecording()
    @resetCurrentClip()

  # Saves the recording
  saveRecording: (title) =>
    RecordingsActions.saveRecording({title: title, ...@state.currentRecording})

  resetCurrentRecording: =>
    RecordingsActions.resetCurrentRecording()

export default Container.create(Play)

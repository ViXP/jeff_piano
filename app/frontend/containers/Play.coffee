# Dependencies
import React from 'react'
import Timer from 'lib/Timer'
import { Container } from 'flux/utils'
import ClipsStore from 'stores/clips_store'
import ClipsActions from 'actions/clips_actions'

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
    return [ ClipsStore ]

  @calculateState = ->
    return { clips: ClipsStore.getState() }

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
    @setState({
      currentClip: { number: number, url: @state.clips.collection[number] }
    })
    @appendClipToRecording(number)

  # Keyboard key press handler
  keyPressed: (event) =>
    number = parseInt(event.key)
    if !isNaN(number) && number < 10 && @state.clips.collection[number]
      @changeCurrentClip(number)

  # Appends current clip with correct timing
  appendClipToRecording: (number) =>
    if @state.currentRecording.recording
      if (@state.currentRecording.clips.length == 0)
        time = 0
        @timer.start()
      else
        time = @timer.display()
      @setState({
        currentRecording: {
          ...@state.currentRecording,
          clips: [
            ...@state.currentRecording.clips, 
            { 
              number: number, 
              start_time: time, 
              url: @state.clips.collection[number]
            }
          ]
        }
      })

  # Operates the recording process
  record: =>
    if @state.currentRecording.recording
      @setState({ 
        currentRecording: { ...@state.currentRecording, recording: false } 
      })
      @timer.clear()
      # AND SAVE TO THE LOCAL STORAGE!
    else
      @setState({ currentRecording: { recording: true, clips: [] } })
    @resetCurrentClip()

  # Saves the recording
  saveRecording: (title) =>
    @setState({
      recordings: {
        ...@state.recordings
        collection: [
          { ...@state.currentRecording, title: title, id: 0 }
          ...@state.recordings.collection
        ]
      }
    })
    @resetCurrentRecording()
    @resetCurrentClip()

  resetCurrentClip: =>
    @setState({ currentClip: null })

  resetCurrentRecording: =>
    @setState({ currentRecording: { id: 0, clips: [], recording: false } })

export default Container.create(Play)

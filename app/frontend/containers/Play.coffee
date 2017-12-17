# Dependencies
import React from 'react'
import Timer from 'lib/Timer'

# Subcomponents
import PageLoading from 'components/PageLoading'
import Video from 'components/Video'
import ClipsButtons from 'components/ClipsButtons'
import RecordingButton from 'components/RecordingButton'
import RecordingForm from 'components/RecordingForm'
import Recordings from 'components/Recordings'

export default class @Play extends React.Component
  constructor: (p) ->
    super(p)
    @timer = new Timer()
    @state = {
      clips: {
        collection: {
          1: 'https://d15t3vksqnhdeh.cloudfront.net/videos/1.mp4'
          2: 'https://d15t3vksqnhdeh.cloudfront.net/videos/2.mp4'
          3: 'https://d15t3vksqnhdeh.cloudfront.net/videos/3.mp4'
        }
        loading: false
      }
      recordings: {
        collection: []
        loading: false
      }
    }
    @_playback = {}

  componentWillMount: =>
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
        <Recordings recordings={@state.recordings} 
          playRecording={@playRecording} />
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
              startTime: time, 
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

  # Plays the sequence of clips
  playRecording: (clips) =>
    clearInterval(@_playback.interval) if @_playback.interval
    clips.sort((a, b) ->
      (a.startTime > b.startTime) ? 1 : (a.startTime == b.startTime) ? 0 : -1
    )
    window.clips = clips
    @_playback = {
      timer: 0
      currentIndex: 0
      interval: setInterval(@checkClip.bind(this, clips), 1)
    }

  checkClip: (clips) ->
    if @_playback.currentIndex >= clips.length
      clearInterval(@_playback.interval)
    else if clips[@_playback.currentIndex].startTime == @_playback.timer
      @setState({ currentClip: clips[@_playback.currentIndex] })
      @_playback.currentIndex += 1
    @_playback.timer += 1

  resetCurrentClip: =>
    @setState({ currentClip: null })

  resetCurrentRecording: =>
    @setState({ currentRecording: { id: 0, clips: [], recording: false } })
# Dependencies
import React from 'react'
import Timer from 'lib/Timer'

# Subcomponents
import PageLoading from 'components/PageLoading'
import Video from 'components/Video'
import ClipButton from 'components/ClipButton'
import RecordingButton from 'components/RecordingButton'
import RecordingForm from 'components/RecordingForm'

export default class @Layout extends React.Component
  constructor: (p) ->
    super(p)
    @timer = new Timer()
    @state = {
      currentClip: {
        number: 0
        url: ''
      }
      currentRecording: {
        clips: []
        recording: false
      }
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

  render: ->
    <div id="layout">
      <PageLoading loading={@state.clips.loading} />
      <div className="column left">
        <Video number={@state.currentClip.number}
          url={@state.currentClip.url} />
          {for number, url of @state.clips.collection
            <ClipButton number={parseInt(number)} key={number}
              changeCurrent={@changeCurrent} />}
      </div>
      <div className="column">
        <RecordingButton recording={@state.currentRecording.recording}
          record={@record} />
        <RecordingForm recording={@state.currentRecording}
          saveRecording={@saveRecording}/>
      </div>
    </div>

  # Changes current clip
  changeCurrent: (number) =>
    @setState({
      currentClip: { number: number, url: @state.clips.collection[number] }
    })
    @appendClipToRecording(number)

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
          clips: 
            [...@state.currentRecording.clips, 
            {number: number, startTime: time }]
        }
      })

  # Operates the recording process
  record: =>
    if @state.currentRecording.recording
      @setState({ currentRecording: 
        { ...@state.currentRecording, recording: false } 
      })
      @timer.clear()
      # AND SAVE TO THE LOCAL STORAGE!
    else
      @setState({ currentRecording: { recording: true, clips: [] } })

  # Saves the recording
  saveRecording: (title) =>
    @setState({
      recordings: {
        ...@state.recordings
        collection: [
          { ...@state.currentRecording, title: title }
          ...@state.recordings.collection
        ]
      }
      currentRecording: {
        recording: false
        clips: []
      }
    })
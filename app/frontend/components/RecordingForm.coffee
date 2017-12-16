# Dependencies
import React from "react"
import PropTypes from "prop-types"

export default class RecordingForm extends React.Component
  @propTypes =
    recording: PropTypes.shape(
      recording: PropTypes.bool.isRequired
      clips: PropTypes.array
    ).isRequired
    saveRecording: PropTypes.func.isRequired

  constructor: (p) ->
    super(p)
    @state = {title: ''}

  render: ->
    <section id="recording_form">
      {if (!@props.recording.recording && @props.recording.clips.length > 0)
        <div>
          <input type="text" onChange={@titleInput} />
          <button onClick={@saveRecordingWithTitle}>
            Save
          </button>
        </div>}
    </section>

  titleInput: (event) =>
    @setState({ title: event.target.value })

  saveRecordingWithTitle: =>
    if @state.title.length > 2
      @props.saveRecording(@state.title)
      @setState({ title: '' })
      @clearField()

  clearField: ->
    document.querySelector('#recording_form input[type="text"]').value = ''

# Dependencies
import React from 'react'
import PropTypes from "prop-types"

export default class Recording extends React.Component
  @propTypes = 
    recording: PropTypes.shape(
      id: PropTypes.number
      title: PropTypes.string.isRequired
      clips: PropTypes.array.isRequired
    ).isRequired
    playRecording: PropTypes.func.isRequired

  render: ->
    <div className="recording">
      <h4 className="title">
        {@props.recording.title}
      </h4>
      <button onClick={@sendClipsCollection}>
        PLAY
      </button>
    </div>

  sendClipsCollection: =>
    @props.playRecording(@props.recording.clips)
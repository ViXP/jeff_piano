# Dependencies
import React from 'react'
import PropTypes from 'prop-types'

export default class RecordButton extends React.Component
  @propTypes =
    recording: PropTypes.bool.isRequired

  render: ->
    <button onClick={@props.record}>
      {if @props.recording
        'STOP'
      else
        'RECORD'}
    </button>
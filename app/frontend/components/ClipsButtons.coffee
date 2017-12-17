# Dependencies
import React from 'react'
import PropTypes from 'prop-types'

# Subcomponents
import ClipButton from 'components/ClipButton'

export default class ClipsButtons extends React.Component
  @propTypes =
    clips: PropTypes.object.isRequired
    changeCurrentClip: PropTypes.func.isRequired
    keyPressed: PropTypes.func.isRequired

  render: ->
    <div>
      {for number, url of @props.clips
        <ClipButton number={parseInt(number)} key={number}
          changeCurrentClip={@props.changeCurrentClip} />}
    </div>

  componentDidMount: ->
    document.addEventListener('keypress', @props.keyPressed, false)

  componentWillUnmount: ->
    document.removeEventListener('keypress', @props.keyPressed)


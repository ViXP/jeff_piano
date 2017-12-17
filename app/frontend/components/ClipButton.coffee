# Dependencies
import React from 'react'
import PropTypes from 'prop-types'

export default class ClipButton extends React.Component
  @propTypes =
    number: PropTypes.number.isRequired
    changeCurrentClip: PropTypes.func.isRequired

  render: ->
    <button className="clip_button" onClick={@passCurrent}>
      {@props.number}
    </button>

  passCurrent: =>
    @props.changeCurrentClip(@props.number)
# Dependencies
import React from 'react'
import PropTypes from 'prop-types'
import uuidv4 from 'uuid/v4'

export default class Video extends React.Component
  @propTypes =
    number: PropTypes.number.isRequired
    url: PropTypes.string.isRequired

  constructor: (p) ->
    super(p)
    @state = @props

  render: ->
    <div id="video">
      <video autoPlay="true" key={uuidv4()}>
        <source src={@props.url} 
          type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"' />
      </video>
      <div id="number">
        {@props.number}
      </div>
    </div>

  componentWillReceiveProps: (props) ->
    @setState(@props)
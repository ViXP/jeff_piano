# Dependencies
import React from 'react'
import PropTypes from 'prop-types'
import uuidv4 from 'uuid/v4'

export default class Video extends React.Component
  @propTypes =
    currentClip: PropTypes.object

  constructor: (p) ->
    super(p)
    @state = { background: [] }

  render: ->
    <div id="video">
      {for i, clip of @state.background
        if clip
          <video autoPlay="true" key={clip.key} data-id={i}
            onEnded={@removeElement}>
            <source src={clip.url} 
              type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"' />
          </video>}

      {if @props.currentClip
        <div id="number">
          {@props.currentClip.number}
        </div>}
    </div>

  componentWillReceiveProps: (props) =>
    if props.currentClip
      @setState(
        background: [
          ...@state.background, {...props.currentClip, key: uuidv4()}
        ]
      )

  removeElement: (event) =>
    id = parseInt(event.target.dataset.id)
    @setState(background: 
      [...@state.background.slice(0, id), 
      null,
      ...@state.background.slice(id+1)])
    setTimeout(() =>
      if !@state.background.find((e) -> return (!!e == true))
        @setState(background: [])
      0)

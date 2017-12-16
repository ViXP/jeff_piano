# Dependencies
import React from 'react'

# Subcomponents
import Video from 'components/Video'
import ClipButton from 'components/ClipButton'

export default class @Layout extends React.Component
  constructor: (p) ->
    super(p)
    @state = {
      currentVideo: {
        number: 0,
        url: ''
      },
      clips: {
        1: 'https://d15t3vksqnhdeh.cloudfront.net/videos/1.mp4'
        2: 'https://d15t3vksqnhdeh.cloudfront.net/videos/2.mp4'
        3: 'https://d15t3vksqnhdeh.cloudfront.net/videos/3.mp4'
      }
    }

  render: ->
    <div>
      <div className="column left">
        <Video number={@state.currentVideo.number}
          url={@state.currentVideo.url} />
          {for number, url of @state.clips
            <ClipButton number={number} key={number}
              changeCurrent={@changeCurrent} />}
      </div>
      <div className="column">

      </div>
    </div>

  changeCurrent: (number) =>
    @setState({
      currentVideo: {
        number: number,
        url: @state.clips[number]
      }
    })
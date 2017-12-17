# Dependencies
import React from 'react'
import PropTypes from 'prop-types'

# Subcomponents
import Recording from 'components/Recording'

export default class Recordings extends React.Component
  @propTypes = 
    recordings: PropTypes.shape(
      loading: PropTypes.bool.isRequired
      collection: PropTypes.array.isRequired
    ).isRequired
    playRecording: PropTypes.func.isRequired

  render: ->
    <section id="recordings">
      {if @props.recordings.loading
        <div className="loading"></div>
      else if @props.recordings.collection.length > 0
        <article>
          <h3>All Recordings</h3>
          {for recording in @props.recordings.collection
            <Recording recording={recording} key={recording.id}
              playRecording={@props.playRecording} />}
        </article>}
    </section>
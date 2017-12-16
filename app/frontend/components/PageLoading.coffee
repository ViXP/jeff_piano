# Dependencies
import React from 'react'
import PropTypes from 'prop-types'

export default class PageLoading extends React.Component
  @propTypes = 
    loading: PropTypes.bool.isRequired

  render: ->
    <div className={
      "#{
        if @props.loading
          'loading'
        else
          ''
      }"}></div>

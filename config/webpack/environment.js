const { environment } = require('@rails/webpacker')
environment.loaders.append('coffee',
  {
    test: /\.coffee(\.erb)?$/,
    use: [    
      {loader: 'babel-loader'},
      {loader: 'coffee-loader'}
    ]
  }
)

module.exports = environment

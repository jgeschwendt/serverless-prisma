const config = require('../../webpack.config')

module.exports = Object.assign({}, config, {
  entry: {
    'src/graphql': './src/graphql.ts',
    'src/playground': './src/playground.ts'
  }
})

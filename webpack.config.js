const CircularDependencyPlugin = require('circular-dependency-plugin')
const path = require('path')
const slsw = require('serverless-webpack')
const webpack = require('webpack')
const nodeExternals = require('webpack-node-externals')

module.exports = {
  mode: process.env.NODE_ENV,
  devtool: 'source-map',
  target: 'node',
  entry: slsw.lib.entries,
  externals: [nodeExternals()],
  output: {
    filename: '[name].js',
    libraryTarget: 'commonjs',
    path: path.resolve(__dirname, '.webpack'),
  },
  module: {
    rules: [
      {
        exclude: /node_modules/,
        test: /\.(gql|graphql)$/,
        use: [
          {
            loader: 'graphql-import-loader',
          },
        ]
      },
      {
        exclude: /node_modules/,
        test: /\.(ts|tsx)$/,
        use: [
          { loader: 'imports-loader', options: { graphql: true } },
          { loader: 'babel-loader' },
        ],
      },
    ],
  },
  plugins: [
    new webpack.NamedModulesPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    new CircularDependencyPlugin({ exclude: /node_modules/, failOnError: false }),
  ],
  resolve: {
    extensions: ['.ts', '.js', '.gql', '.graphql']
  },
}

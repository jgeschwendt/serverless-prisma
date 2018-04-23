const CircularDependencyPlugin = require('circular-dependency-plugin')
const path = require('path')
const slsw = require('serverless-webpack')
const webpack = require('webpack')
const nodeExternals = require('webpack-node-externals')

module.exports = {
  mode: slsw.lib.webpack.isLocal ? 'development' : 'production',
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
        enforce: 'pre',
        exclude: /(node_modules|src\/generated)/,
        test: /\.ts$/,
        use: [
          { loader: 'tslint-loader' },
        ]
      },
      {
        exclude: /node_modules/,
        test: /\.ts$/,
        use: [
          { loader: 'imports-loader', options: { graphql: true } },
          { loader: 'babel-loader' },
        ],
      },
      {
        exclude: /node_modules/,
        test: /\.graphql$/,
        use: [
          {
            loader: 'graphql-import-loader',
          },
        ]
      },
    ],
  },
  plugins: [
    new webpack.NamedModulesPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    new CircularDependencyPlugin({ exclude: /node_modules/, failOnError: false }),
  ],
  resolve: {
    extensions: [
      '.graphql',
      '.js',
      '.ts',
    ]
  },
}

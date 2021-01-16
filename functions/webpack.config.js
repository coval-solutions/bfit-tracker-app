const path = require('path');
const nodeExternals = require('webpack-node-externals');

require('dotenv').config();

// eslint-disable-next-line no-console
console.log(`Building for ${process.env.NODE_ENV}`);

module.exports = {
  target: 'node',
  mode: process.env.NODE_ENV,
  entry: './src/index.ts',
  output: {
    path: path.resolve(__dirname, 'lib'),
    filename: 'bundle.js',
  },
  module: {
    rules: [{
      test: /\.(ts|tsx)$/,
      loader: 'ts-loader',
      include: [path.resolve(__dirname, 'src')],
    }],
  },
  externals: [
    nodeExternals(),
  ],
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
};

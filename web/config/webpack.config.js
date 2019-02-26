const webpack = require("webpack");
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const isProd = process.env.NODE_ENV === "production";

const base = {
  entry: ["react-hot-loader/patch", "./src/index.bs.js"],
  mode: isProd ? "production" : "development",
  devServer: {
    hot: true,
    contentBase: path.join(__dirname, "..", "public"),
    host: "0.0.0.0",
    port: 3000,
    historyApiFallback: true,
  },
  output: {
    filename: '[name].js',
    path: path.join(__dirname, '..', 'build'),
    publicPath: '/',
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: path.join(__dirname, "../public/index.html"),
    }),
  ],
};

if (!isProd) {
  base.plugins = [...base.plugins, new webpack.HotModuleReplacementPlugin()];
}

module.exports = base;

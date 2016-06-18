var path = require('path'),
    assets_path = path.join('app', 'assets', 'javascripts'),
    bundle_path = path.join('public', 'js'),
    LiveReloadPlugin = require('webpack-livereload-plugin'),
    webpack = require('webpack');

var ExtractTextPlugin = require('extract-text-webpack-plugin');

var config = {
    context: path.resolve(assets_path),
    entry: {
        sign_up: 'entry-points/sign_up.jsx',
        setup: 'entry-points/setup.jsx'
    },
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(bundle_path),
        publicPath: "/public/"
    },
    resolve: {
        extensions: ['', '.js', '.jsx'],
        root: [
            path.resolve('app/assets/javascripts'),
            path.resolve('app/assets/styles')
        ]
    },
    module: {
        loaders: [
            { test: /\.js$/, exclude: /node_modules/, loader: '6to5-loader' },
            { test: /\.jsx$/, exclude: /node_modules/, loader: 'babel' },
            { test: /\.scss$/, loaders: ['style', 'css', 'sass']},
            { test: /\.scss$/, loader: ExtractTextPlugin.extract('css!sass')}
            //{ test: /\.js$/, exclude: /node_modules/, loader: "eslint-loader"},
        ]
        //preLoaders: [
        //    {
        //        test: /\.jsx?$/,
        //        loaders: ['eslint'],
        //        include: [
        //            path.resolve(__dirname, 'app/assets/javascripts')
        //        ]
        //    }
        //]
    },
    eslint: {
        failOnError: false,
        emitError: false
    },
    plugins: [
        new ExtractTextPlugin('../css/[name].css', {
            allChunks: true
        }),
        new LiveReloadPlugin(),
        new webpack.ProvidePlugin({
            $: "jquery",
            React: 'react',
            _: 'underscore'
        })
    ]
};

module.exports = config;
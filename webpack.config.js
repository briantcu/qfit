var path = require('path'),
    assets_path = path.join('app', 'assets', 'javascripts');

//var ExtractTextPlugin = require('extract-text-webpack-plugin');

var config = {
    context: path.resolve(assets_path),
    entry: {
        totes: './totes.js'
    },
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(assets_path)
    },
    externals: {
        jquery: 'var jQuery'
    },
    resolve: {
        extensions: ['', '.js', '.jsx'],
        root: path.resolve('app/assets/webpack')
    },
    module: {
        loaders: [
            { test: /\.js$/, exclude: /node_modules/, loader: '6to5-loader' },
            { test: /\.jsx$/, exclude: /node_modules/, loader: '6to5-loader' },
            { test: /\.js$/, exclude: /node_modules/, loader: "eslint-loader"},
            { test: /\.scss$/, loaders: ['style', 'css', 'sass']}
            //{ test: /\.scss$/, loader: ExtractTextPlugin.extract('css!sass')}
        ],
        preLoaders: [
            {
                test: /\.jsx?$/,
                loaders: ['eslint'],
                include: [
                    path.resolve(__dirname, 'app/assets/webpack')
                ]
            }
        ]
    },
    eslint: {
        failOnError: false,
        emitError: false
    }/*,
    plugins: [
        new ExtractTextPlugin('public/style.css', {
            allChunks: true
        })
    ]*/
};

module.exports = config;
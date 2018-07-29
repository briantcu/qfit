var webpackConfig = require('./webpack.config.js');
webpackConfig.entry = {};

module.exports = function (config) {
    config.set({
        browsers: [ 'PhantomJS' ],
        files: [
            './app/assets/webpack/tests.webpack.js'
        ],
        frameworks: [ 'mocha' ],
        preprocessors: {
            '**/tests.webpack.js': [ 'webpack' ]
        },
        reporters: [ 'dots' ],
        singleRun: true,
        // webpack config object
        webpack: webpackConfig,
        webpackMiddleware: {
            noInfo: true
        }
    });
};

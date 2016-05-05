var util = {
    timeAgo: function(timeString, diffOnly){
        var time = new Date(timeString);
        var units = [
            { name: 'second', limit: 60, in_seconds: 1 },
            { name: 'minute', limit: 3600, in_seconds: 60 },
            { name: 'hour', limit: 86400, in_seconds: 3600  },
            { name: 'day', limit: 604800, in_seconds: 86400 },
            { name: 'week', limit: 2629743, in_seconds: 604800  },
            { name: 'month', limit: 31556926, in_seconds: 2629743 },
            { name: 'year', limit: null, in_seconds: 31556926 }
        ];

        var diff = (new Date() - time) / 1000;
        if (diffOnly){
            return diff;
        }
        if (diff < 5) return 'a few seconds';

        var i = 0, unit;

        while ((unit = units[i++])) {
            if (diff < unit.limit || !unit.limit){
                diff =  Math.floor(diff / unit.in_seconds);
                return diff + ' ' + unit.name + (diff>1 ? 's' : '');
            }
        }
    },
    getParameterByName: function(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)'),
            results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    },
    isString: function(obj){
        return typeof obj === 'string';
    },
    empty: function(str){
        return !(str && util.isString(str) && str.length > 0);
    },
    notEmpty: function(str){
        return !util.empty(str);
    },
    isXss: function(str){
        return /j\s*?a\s*?v\s*?a\s*?s\s*?c\s*?r\s*?i\s*?p\s*?t\s*?\:|<script/ig.test(str);
    },
    setCookie: function(name, value, days) {
        var expires;
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = '; expires=' + date.toGMTString();
        }
        else {
            expires = '';
        }
        document.cookie = name + '=' + value + expires + '; path=/';
    },
    getCookie: function(c_name) {
        if (document.cookie.length > 0) {
            var c_start = document.cookie.indexOf(c_name + '=');
            if (c_start != -1) {
                c_start = c_start + c_name.length + 1;
                var c_end = document.cookie.indexOf(';', c_start);
                if (c_end == -1) {
                    c_end = document.cookie.length;
                }
                return window.unescape(document.cookie.substring(c_start, c_end));
            }
        }
        return '';
    },
    // TODO: add browser support check
    historyPushState: function(url, state){
        window.history.pushState(state, document.title, url);
    },
    historyReplaceState: function(url, state){
        window.history.replaceState(state, document.title, url);
    }
};

module.exports = util;
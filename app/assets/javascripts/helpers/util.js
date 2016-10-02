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
    isString: function(obj){
        return typeof obj === 'string';
    },
    empty: function(str){
        return !(str && util.isString(str) && str.length > 0);
    },

    getPasswordStrength: function (pwd) {
        var score   = 0;

        if (pwd.length > 6) score++;

        if ( ( pwd.match(/[a-z]/) ) && ( pwd.match(/[A-Z]/) ) ) score++;

        if (pwd.match(/\d+/)) score++;

        if ( pwd.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) score++;

        if (pwd.length > 12) score++;

        return score;
    },

    formatDate: function(fullDateString) {
        var date = new Date(fullDateString);
        return (date.getMonth() + 1) + '/' + date.getDate() + '/' + date.getFullYear().toString().substr(2,2);
    }
};

export default util;
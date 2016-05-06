var keyMirror = function(obj){
    for (var k in obj){
        if (!obj.hasOwnProperty(k))
            continue;

        if(obj[k] === null)
            obj[k] = k;
        else if (typeof obj[k] === 'object')
            obj[k] = keyMirror(obj[k]);
    }
    return obj;
};
module.exports = keyMirror;
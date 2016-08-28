var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/user_constants.js');

var QuadPodStore = new Store({
    feed: [],
    pod: [],

    setPod: function(data){
        this.pod = data;
    },

    setFeed: function(data){
        this.feed = data;
    },

    getData: function(){
        return {
            feed: this.feed,
            pod: this.pod
        };
    }
});

dispatcher.register(C.POD_LOADED, function(data) {
    if(data){
        QuadPodStore.setPod(data);
        QuadPodStore.change();
    }
});

dispatcher.register(C.FEED_LOADED, function(data) {
    if(data){
        QuadPodStore.setFeed(data);
        QuadPodStore.change();
    }
});


export default QuadPodStore;
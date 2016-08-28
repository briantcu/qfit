var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/user_constants.js');

var QuadPodStore = new Store({
    feed: {},
    pod: [],
    invites: [],

    setPod: function(data){
        this.pod = data;
    },

    setFeed: function(data){
        this.feed = data;
    },

    setInvites: function(data) {
        this.invites = data;
    },

    getData: function(){
        return {
            feed: this.feed,
            pod: this.pod,
            invites: this.invites
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

dispatcher.register(C.INVITES_SENT, function(data) {
    if(data){
        QuadPodStore.setInvites(data);
        QuadPodStore.change();
    }
});


export default QuadPodStore;
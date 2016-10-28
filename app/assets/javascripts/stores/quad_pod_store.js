var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/user_constants.js');

var QuadPodStore = new Store({
    feed: {},
    pod: [],
    invites: [],
    conversation: {},
    loading: true,
    invites_received: [],

    setPod: function(data){
        this.pod = data;
    },

    setFeed: function(data){
        this.feed = data;
        this.loading = false;
    },

    setInvites: function(data) {
        //Invites sent
        this.invites = data;
    },

    setInvitesReceived: function(data) {
        this.invites_received = data;
    },

    setConversation: function(data) {
        this.conversation = data;
    },

    getData: function(){
        return {
            feed: this.feed,
            pod: this.pod,
            invites: this.invites,
            conversation: this.conversation,
            loading: this.loading,
            invites_received: this.invites_received
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
dispatcher.register(C.CONVO_LOADED, function(data) {
    if(data){
        QuadPodStore.setConversation(data);
        QuadPodStore.change();
    }
});

dispatcher.register(C.INVITES_LOADED, function(data) {
    if(data){
        QuadPodStore.setInvitesReceived(data);
        QuadPodStore.change();
    }
});


export default QuadPodStore;
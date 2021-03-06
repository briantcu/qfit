var dispatcher = require('global_dispatcher.js');
var C = require('constants/user_constants.js');
import request from 'superagent';

var UserActions = {

    getUser: function(user_id, is_logged_in_user, suppress_current_user_load) {
        $.ajax({
            type: 'get',
            url: '/users/'+user_id+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(user) {
                // @TODO holy hack batman
                if (is_logged_in_user) {
                    dispatcher.dispatch(C.LOADED_LOGGED_IN, user);
                    if (gon.current_user_id == gon.user_id && !suppress_current_user_load) {
                        dispatcher.dispatch(C.LOADED, user);
                    }
                } else {
                    dispatcher.dispatch(C.LOADED, user);
                }
                if (user.user_schedule) {
                    this.getSchedule(user.user_schedule.id);
                }
            }.bind(this),
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    getSchedule: function(schedule_id) {
        $.ajax({
            type: 'get',
            url: '/user_schedules/'+schedule_id+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(schedule) {
                dispatcher.dispatch(C.SCHEDULE_LOADED, schedule);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    setSchedule: function(schedule) {
        var schedule = JSON.parse(JSON.stringify( schedule ));
        schedule.weekly_schedule_days_attributes = schedule.schedule_days;
        delete schedule.schedule_days;

        var user_schedule = {user_schedule: schedule};
        var data = JSON.stringify(user_schedule);
        if (schedule.id) {
            $.ajax({
                type: 'put',
                data: data,
                url: '/user_schedules/'+ schedule.id +'.json',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function(results, status, xhr) {
                    location.href = xhr.getResponseHeader('Location');
                },
                error: function(results) {
                    if(results.status==401) {
                        location.reload();
                    } else {
                        console.log(results);
                    }
                }
            });
        } else {
            $.ajax({
                type: 'post',
                data: data,
                url: '/user_schedules.json',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function(results, status, xhr) {
                    location.href = xhr.getResponseHeader('Location');
                },
                error: function(results) {
                    if(results.status==401) {
                        location.reload();
                    } else {
                        console.log(results);
                    }
                }
            });
        }
    },

    getPod: function() {
        $.ajax({
            type: 'get',
            url: '/friends.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(pod) {
                dispatcher.dispatch(C.POD_LOADED, pod);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    getInvites: function() {
        $.ajax({
            type: 'get',
            url: '/invites.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(pod) {
                dispatcher.dispatch(C.INVITES_LOADED, pod);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    ignoreInvite: function(id) {
        $.ajax({
            type: 'put',
            url: '/pod_invites/'+id +'/deny.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(pod) {
                dispatcher.dispatch(C.INVITES_LOADED, pod);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    acceptInvite: function(id) {
        $.ajax({
            type: 'put',
            url: '/pod_invites/'+id +'/accept.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(pod) {
                dispatcher.dispatch(C.INVITES_LOADED, pod);
                this.getPod();
            }.bind(this),
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    getFeed: function() {
        $.ajax({
            type: 'get',
            url: '/messages.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(feed) {
                dispatcher.dispatch(C.FEED_LOADED, feed);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    getConversation: function(userId) {
        $.ajax({
            type: 'get',
            url: '/messages/user_id/'+userId+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(feed) {
                dispatcher.dispatch(C.CONVO_LOADED, feed);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    sendInvitations: function(invites) {
        if (invites && invites.length > 0) {
            var payload = {pod_invite: {sent_to: invites}};
            var data = JSON.stringify(payload);
            $.ajax({
                type: 'post',
                data: data,
                url: '/pod_invites.json',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (results) {
                    dispatcher.dispatch(C.INVITES_SENT, results);
                },
                error: function (results) {
                    if(results.status==401) {
                        location.reload();
                    } else {
                        console.log(results);
                    }
                }
            });
        }
    },

    inviteUser: function(user_id) {
        $.ajax({
            type: 'post',
            url: '/pod_invites/user/'+user_id+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (results) {
                dispatcher.dispatch(C.INVITES_SENT, results);
            },
            error: function (results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    sendDM: function(receiver, message) {
        var payload = {message: {to_id: receiver, message_type: 2, message: message}};
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'post',
            data: data,
            url: '/messages.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (results) {
                UserActions.getConversation(receiver);
            },
            error: function (results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    postToFeed: function(message) {
        var payload = {message: {message_type: 1, message: message}};
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'post',
            data: data,
            url: '/messages.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (results) {
                UserActions.getFeed();
            },
            error: function (results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    getProgress: function(userId, chartType, period, exerciseId) {
        var url = '/users/'+ userId +'/progress/'+ chartType + '/' +period+'.json';
        if (exerciseId) {
            url = url + '?exercise_id=' + exerciseId;
        }
        $.ajax({
            type: 'get',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.CHART_LOADED, data);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    getMaxes: function() {
        $.ajax({
            type: 'get',
            url: '/user_maxes.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.MAXES_LOADED, data);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    uploadAvatar: function(files) {
        var req = request.post('/avatar.json');
        req.attach('file', files[0]);
        req.end(function(err, resp) {
            dispatcher.dispatch(C.LOADED, resp.body);
        });
    },

    unfriend: function(id) {
        $.ajax({
            type: 'delete',
            url: '/friends/'+ id +'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(pod) {
                dispatcher.dispatch(C.POD_LOADED, pod);
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    signOut: function() {
        $.ajax({
            type: 'get',
            url: '/sign_out.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results, status, xhr) {
                location.href = '/';
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    }

};

export default UserActions;
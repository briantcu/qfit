require 'test_helper'

class PodInvitesControllerTest < ActionController::TestCase
  setup do
    @pod_invite = pod_invites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pod_invites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pod_invite" do
    assert_difference('PodInvite.count') do
      post :create, pod_invite: { invitee: @pod_invite.invitee, inviter: @pod_invite.inviter, sent_to: @pod_invite.sent_to, status: @pod_invite.status }
    end

    assert_redirected_to pod_invite_path(assigns(:pod_invite))
  end

  test "should show pod_invite" do
    get :show, id: @pod_invite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pod_invite
    assert_response :success
  end

  test "should update pod_invite" do
    patch :update, id: @pod_invite, pod_invite: { invitee: @pod_invite.invitee, inviter: @pod_invite.inviter, sent_to: @pod_invite.sent_to, status: @pod_invite.status }
    assert_redirected_to pod_invite_path(assigns(:pod_invite))
  end

  test "should destroy pod_invite" do
    assert_difference('PodInvite.count', -1) do
      delete :destroy, id: @pod_invite
    end

    assert_redirected_to pod_invites_path
  end
end

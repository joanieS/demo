require 'test_helper'

class AudioClipsControllerTest < ActionController::TestCase
  setup do
    @audio_clip = audio_clips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:audio_clips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create audio_clip" do
    assert_difference('AudioClip.count') do
      post :create, audio_clip: { beacon_id: @audio_clip.beacon_id, caption: @audio_clip.caption }
    end

    assert_redirected_to audio_clip_path(assigns(:audio_clip))
  end

  test "should show audio_clip" do
    get :show, id: @audio_clip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @audio_clip
    assert_response :success
  end

  test "should update audio_clip" do
    patch :update, id: @audio_clip, audio_clip: { beacon_id: @audio_clip.beacon_id, caption: @audio_clip.caption }
    assert_redirected_to audio_clip_path(assigns(:audio_clip))
  end

  test "should destroy audio_clip" do
    assert_difference('AudioClip.count', -1) do
      delete :destroy, id: @audio_clip
    end

    assert_redirected_to audio_clips_path
  end
end

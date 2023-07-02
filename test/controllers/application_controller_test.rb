require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should set current player' do
    player = Player.create(name: 'John')
    @request.session[:current_player_id] = player.id
    get players_url
    assert_response :success
    assert_equal player, assigns(:current_player)
  end
end

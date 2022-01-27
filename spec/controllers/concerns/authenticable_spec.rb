require 'spec_helper'
require './app/controllers/concerns/authenticable.rb'

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end

RSpec.describe Authenticable do
  let(:user) { create(:user) }
  let(:authentication) { MockController.new }

  it 'ahould get user from Authorization token' do
    authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: user.id)
    expect(authentication.current_user).to_not be_nil
    expect(user.id).to eq(authentication.current_user.id)
  end

  it 'should not get user from empty Authorization token' do
    authentication.request.headers['Authorization'] = nil
    expect(authentication.current_user).to be_nil
  end
end
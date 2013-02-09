require 'spec_helper'

describe "Position Model" do
  let(:position) { Position.new }
  it 'can be created' do
    position.should_not be_nil
  end
end

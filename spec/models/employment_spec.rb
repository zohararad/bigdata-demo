require 'spec_helper'

describe "Employment Model" do
  let(:employment) { Employment.new }
  it 'can be created' do
    employment.should_not be_nil
  end
end

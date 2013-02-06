require 'spec_helper'

describe "Skill Model" do
  let(:skill) { Skill.new }
  it 'can be created' do
    skill.should_not be_nil
  end
end

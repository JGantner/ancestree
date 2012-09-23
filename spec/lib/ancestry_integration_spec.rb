require 'spec_helper'

# Feature: Tree modeling
#   As a developper using ancestree
#   I want to be able to model a family tree
#   In order to query it afterward
describe 'Ancestry usage: tree modeling' do
  context 'given there are Mark and Kathy (married) with their two childs Chris and Zoe' do
    context "when i ask the system for Marks' childs" do
      it 'returns an array with Chris and Zoe'
    end

    context "when i ask the system for Mary's childs" do
      it 'returns an array with Chris and Zoe'
    end
  end

end

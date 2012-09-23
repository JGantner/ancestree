require 'spec_helper'

# Feature: Tree modeling
#   As a developper using ancestree
#   I want to be able to model a family tree
#   In order to query it afterward
describe 'Ancestree usage: tree modeling' do
  context 'given there are Mark and Kathy with their two childs Chris and Zoe' do
    let(:mark)  { Ancestree::Person.new('mark')  }
    let(:kathy) { Ancestree::Person.new('kathy') }
    let(:chris) { Ancestree::Person.new('chris') }
    let(:zoe)   { Ancestree::Person.new('zoe')   }

    context "when i ask the system for Marks' children" do
      before :each do
        @answer = mark.children
      end

      it 'returns an array with Chris and Zoe' do
        @answer.should eq([@chris, @zoe])
      end
    end

    context "when i ask the system for Mary's children" do
      it 'returns an array with Chris and Zoe'
    end
  end

end

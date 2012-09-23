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

    before :each do
      mark.children << chris << zoe
      kathy.children << chris << zoe
    end

    context "when i ask the system for Marks' children" do
      it 'returns an array with Chris and Zoe' do
        mark.children.should eq([chris, zoe])
      end
    end

    context "when i ask the system for Mary's children" do
      it 'returns an array with Chris and Zoe' do
        kathy.children.should eq([chris, zoe])
      end
    end
  end
end

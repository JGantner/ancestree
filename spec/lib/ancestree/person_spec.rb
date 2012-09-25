require 'spec_helper'

describe Ancestree::Person do
  let(:mark) { Ancestree::Person.new("mark") }
  let(:chris) { Ancestree::Person.new("chris") }
  let(:zoe) { Ancestree::Person.new("zoe") }

  describe '#new' do
    it 'takes the name of the person as argument' do
      expect { Ancestree::Person.new("mark") }.not_to raise_error ArgumentError
    end

    it 'stores the name' do
      mark.name.should eq("mark") 
    end
  end

  describe '#children' do
    context 'given mark has no children' do
      it 'returns an empty array' do
        mark.children.should eq([])
      end
    end

    context 'given mark has a child, chris' do
      before :each do
        mark.children << chris
      end

      it "returns an array containing chris" do
        mark.children.should eq([chris])
      end
    end

    context 'given mark has two children, zoe and chris' do
      before :each do
        mark.children << zoe
        mark.children << chris
      end

      it 'returns an array containing zoe and chris sorted by their name' do
        mark.children.should eq([chris, zoe])
      end
    end
  end

  describe '#parents' do
    context 'given mark has a child, chris' do
      before :each do
        mark.children << chris
      end

      context 'when i ask chris for his parents' do
        it 'returns an array containing mark' do
          chris.parents.should include mark
        end
      end
    end
  end

  describe '#parent=(object)' do
    it 'adds the given object to the parents collection' do
      chris.parent = mark

      chris.parents.should include mark
    end
  end
end

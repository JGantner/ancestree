require 'spec_helper'
require 'ostruct'

describe Ancestree::ChildrenCollection do
  let(:parent) { "parent" }
  let(:collection) { Ancestree::ChildrenCollection.new_with_parent(parent) }

  it 'should be a subclass of Array' do
    Ancestree::ChildrenCollection.superclass.should eq(::Array)
  end

  describe '.new_with_parent' do
    it 'accepts a parent object as paramter' do
      expect { Ancestree::ChildrenCollection.new_with_parent('parent') }.to_not raise_error 
    end
  end

  describe '#parent' do
    it 'returns the associated parent object' do
      collection.parent.should eq(parent)
    end
  end

  describe '<<(other)' do
    let(:other) { OpenStruct.new }

    it 'adds the element to the collection' do
      collection << other
      collection.should include other
    end

    it 'associates the other object with the collections parent' do
      other.stub(:parent=)
      other.should_receive(:parent=).with(parent)
      collection << other
    end
  end
end

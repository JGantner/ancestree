require 'spec_helper'

describe Ancestree::Store do
  let(:store) { Ancestree::Store.new }

  describe '#get' do
    context "given the requested object doesn't exist" do
      before :each do
        store.clear
      end

      it 'creates the object' do
        Ancestree::Person.should_receive(:new).with('Bregor')
        store.get('Bregor')
      end

      it 'adds the object to the internal collection' do
        bregor = store.get('Bregor')
        store.all.should include(bregor)
      end
    end

    context 'given the requested object exists' do
      it 'returns the object' do
        bregor = Ancestree::Person.new("Bregor")
        store << bregor
        store.get('Bregor').should eq(bregor)
      end
    end
  end

  describe '#all' do
    it 'returns all elements in the collection' do
      bregor = store.get('Bregor')
      idril = store.get('Idril')
      store.all.should include(bregor, idril)
    end
  end

  describe '#clear' do
    it 'removes all elements from the collection' do
      store.get('Bregor')
      store.get('Idril')
      store.clear
      store.all.should be_empty
    end
  end
end

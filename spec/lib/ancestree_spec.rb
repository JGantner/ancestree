require 'spec_helper'

describe Ancestree do
  it 'defines a person class' do
    Ancestree::Person.class.should eq(Class)
  end

  it 'defines a store class' do
    Ancestree::Store.class.should eq(Class)
  end

  it 'defines a parser class' do
    Ancestree::Parser.class.should eq(Class)
  end
end

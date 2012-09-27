require 'spec_helper'
require 'ostruct'

describe Ancestree::Parser do
  let(:store) { Ancestree::Store.new }
  let(:parser) { Ancestree::Parser.new(store) }
 
  describe '#new' do
    it 'associates with the given store' do
      parser.store.should eq(store)
    end
  end

  describe '#parse(file)' do
    it 'calls readlines on the file object expecting an array' do
      file = double('file')
      file.should_receive(:readlines).and_return([])
      parser.parse(file)
    end

    it 'calls the process_tree_statement for each element returned by readlines' do
      file = OpenStruct.new( :readlines => %w( first_line second_line third_line ) )
      parser.should_receive(:process_tree_statement).exactly(3).times
      parser.parse(file)
    end
  end

  describe '#process_tree_statement' do
    let(:statement) { "<Gilwen> married_to <Alatar>." }
    let(:gilwen) { store.get('Gilwen') }
    let(:alatar) { store.get('Alatar') }

    before :each do
      statement.stub(:split => %w[<Gilwen> married_to <Alatar>.])
    end
    
    it 'splits the statement into parts separatend by spaces' do
      statement.should_receive(:split)
      parser.process_tree_statement(statement)
    end

    it 'converts the part 1 and 3 to n to identifiers' do
      parser.should_receive(:identifier).twice
      parser.process_tree_statement(statement)
    end

    it 'queries the store with all identifers' do
      gilwen; alatar
      store.should_receive(:get).twice.and_return(gilwen, alatar)
      parser.process_tree_statement(statement)
    end

    it 'sends the first person the message defined in part two with an array of people identified by the statements arguments' do
      gilwen.should_receive(:married_to).with([alatar])
      parser.process_tree_statement(statement)
    end
  end

  describe '#identifier' do
    it 'strips out all < characters' do
      parser.identifier("<asd<asd<").should eq("asdasd")
    end

    it 'strips out all > characters' do
      parser.identifier('>asd>asd>').should eq("asdasd")
    end

    it 'strips out all . characters' do
      parser.identifier('.asd.asd.').should eq('asdasd')
    end

    it 'strips out all , characters' do
      parser.identifier(',asd,asd,').should eq('asdasd')
    end
  end
end

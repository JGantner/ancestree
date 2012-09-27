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
    let(:bregor) { store.get('Bregor') }
    let(:hirwen) { store.get('Hirwen') }
    let(:bregil) { store.get('Bregil') }
    let(:bregolas) { store.get('Bregolas') }
    let(:barahir) { store.get('Barahir') }
    let(:gwindor) { store.get('Gwindor') }

    before :each do
      statement.stub(:split => %w[<Gilwen> married_to <Alatar>.])
    end
    
    it 'splits the statement into parts separatend by spaces' do
      statement.should_receive(:split)
      parser.process_tree_statement(statement)
    end

    context 'given a married_to statement' do
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

    context 'given a parent_of statement' do
      let(:statement) { '<Bregor> parent_of <Hirwen>, <Gilwen>, <Bregil>, <Bregolas>, <Barahir>, <Gwindor>.' }
 
      before :each do
        statement.stub(:split => %w(<Bregor> parent_of <Hirwen>, <Gilwen>, <Bregil>, <Bregolas>, <Barahir>, <Gwindor>.))
      end

      it 'converts the part 1 and 3 to n to identifiers' do
        parser.should_receive(:identifier).exactly(7).times
        parser.process_tree_statement(statement)
      end

      it 'queries the store with all identifers' do
        bregor; hirwen; gilwen; bregil; bregolas; barahir; gwindor
        store.should_receive(:get).exactly(7).times.and_return(bregor,hirwen, gilwen, bregil, bregolas, barahir, gwindor)
        parser.process_tree_statement(statement)
      end

      it 'sends the first person the message defined in part two with an array of people identified by the statements arguments' do
        bregor.should_receive(:parent_of).with([hirwen, gilwen, bregil, bregolas, barahir, gwindor])
        parser.process_tree_statement(statement)
      end

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

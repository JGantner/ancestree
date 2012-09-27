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

    context "when i ask the system for Kathy's children" do
      it 'returns an array with Chris and Zoe' do
        kathy.children.should eq([chris, zoe])
      end
    end

    context 'when i ask zoe for her parents' do
      it 'returns an array with mark and kathy' do
        zoe.parents.should include(mark,kathy)
      end
    end

    context 'when i ask chris for his parents' do
      it 'returns an array with mark and kathy' do
        chris.parents.should include(mark,kathy)
      end
    end

    context 'given chris has two childs: clara and jessy' do
      let(:clara) { Ancestree::Person.new 'clara' }
      let(:jessy) { Ancestree::Person.new 'jessy' }

      before :each do
        chris.children << clara << jessy
      end

      context 'when i ask clara for her grandparents' do
        it 'returns an array with mark and kathy' do
          clara.grandparents.should include(mark, kathy)
        end
      end

      context 'when i ask kathy for her grandchildren' do
        it 'returns an array with clara and jessy' do
          kathy.grandchildren.should include(clara,jessy)
        end
      end

      context 'when i ask clara for her aunts and auncles' do
        it 'returns an array with zoe' do
          clara.aunts_and_uncles.should eq([zoe])
        end
      end

      context 'zoe has two childs: liam and connor' do
        let(:liam) { Ancestree::Person.new('liam') }
        let(:connor) { Ancestree::Person.new('connor') }

        before :each do
          zoe.children << liam << connor
        end

        context 'when i ask jessy for her cousins' do
          it 'returns an array with liam and connor' do
            jessy.cousins.should eq([connor, liam])
          end
        end
      end
    end
  end
end

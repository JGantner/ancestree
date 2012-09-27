module Ancestree
  class Person
    attr_reader :name, :spouse

    def initialize(name)
      @name = name
      @children = ChildrenCollection.new_with_parent(self)
      @parents = []
    end

    def children
      @children.size > 1 ? @children.sort : @children
    end

    def <=>(other)
      self.name <=> other.name
    end

    def parent=(other)
      @parents << other
    end
    
    def parents
      @parents.sort
    end

    def married_to(others)
      @spouse = others.first
    end

    def parent_of(others)
      others.each {|o| @children << o }
    end

    def grandparents
      parents.map(&:parents).flatten
    end

    def grandchildren
      children.map(&:children).flatten
    end

    def aunts_and_uncles
      grandparents.map(&:children).flatten.uniq - parents
    end

    def cousins
      aunts_and_uncles.map(&:children).flatten.uniq - siblings
    end

    def siblings 
      parents.map(&:children).flatten.uniq - [self]
    end

    def to_s
      name
    end
  end
end

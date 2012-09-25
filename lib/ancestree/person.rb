module Ancestree
  class Person
    attr_reader :name, :parents

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
      parents << other
    end
  end
end

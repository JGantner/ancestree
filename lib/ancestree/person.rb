module Ancestree
  class Person
    attr_reader :name, :parents

    def initialize(name)
      @name = name
      @children = []
      @parents = []
    end

    def children
      @children.size > 1 ? @children.sort : @children
    end

    def <=>(other)
      self.name <=> other.name
    end
  end
end

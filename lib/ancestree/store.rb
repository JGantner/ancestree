module Ancestree
  class Store
    def initialize
      @collection = {}
    end

    def get(identifier)
      @collection[identifier] or @collection[identifier] = Ancestree::Person.new(identifier)
    end

    def all
      @collection.values
    end

    def clear
      @collection = {}
    end
    
    def <<(other)
      @collection[other.name] = other
    end
  end
end

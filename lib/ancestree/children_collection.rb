module Ancestree
  class ChildrenCollection < ::Array
    attr_accessor :parent

    def self.new_with_parent(parent)
      obj = self.new
      obj.parent = parent
      obj
    end
  end
end

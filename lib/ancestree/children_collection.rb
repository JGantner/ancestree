module Ancestree
  class ChildrenCollection < ::Array
    attr_accessor :parent

    def self.new_with_parent(parent)
      obj = self.new
      obj.parent = parent if obj.respond_to?(:parent=)
      obj
    end

    def <<(other)
      other.parent = parent
      super
    end
  end
end

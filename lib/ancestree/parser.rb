module Ancestree
  class Parser
    attr_reader :store

    def initialize(store)
      @store = store
    end

    def parse(file)
      @tree_statements = file.readlines
      @tree_statements.each do |statement|
        self.process_tree_statement(statement)
      end
    end

    def process_tree_statement(statement)
      obj, rel, other_objs = statement.split(" ")
      objects = [obj] + [other_objs]
      people = objects.map(){|o| store.get( identifier(o) ) }

      people.first.send(rel.to_sym, people[1..-1])
    end

    def identifier(obj_string)
      obj_string.gsub(/<|>|\.|,/,"")
    end
  end
end

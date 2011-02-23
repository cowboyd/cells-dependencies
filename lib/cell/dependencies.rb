require 'cells'
require 'cell/dependencies/version'
require 'active_support/core_ext/class/subclasses'
    
module Cell
  module Dependencies

    def inherited(cls)
      super
      cls.extend(Cell::Dependencies)
    end
    
    def uses(*names)
      @dependencies ||= [] 
      @dependencies += names
    end

    def dependencies(seen = Set.new([self]))
      @dependencies ||= []
      resolved = @dependencies.map {|n| Cell::Base.class_from_cell_name(n)}
      resolved.inject(resolved) do |all, dep|
        if seen.include?(dep)
          all
        else
          seen << dep
          dep.dependencies(seen) - [self] + all
        end
      end
    end
    
    module TotalOrder
      def total_order
        seen = Set.new
        order = []
        cells = Cell::Base.descendants.sort_by {|cell| cell.cell_name}
        cells.each do |cell|
          next if seen.include?(cell)
          order += cell.dependencies.select {|dep| !seen.include?(dep)} + [cell]
          seen += order
        end
        return order.uniq
      end
    end

    Cell::Rails.extend(self)
    Cell::Rails.extend(TotalOrder)
  end

end

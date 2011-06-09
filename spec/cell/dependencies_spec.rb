require 'spec_helper'

describe Cell::Dependencies do

    before do
      @cells = {}
      Cell::Base.stub(:class_from_cell_name) do |name|
        @cells[name.to_s] or raise "no such cell #{name}"
      end
      Cell::Base.subclasses.clear
    end

    it "starts out empty" do
      mock_cell(:A).dependencies.should == []
    end

    it "can enumerate dependencies" do
      a = mock_cell(:A)
      b = mock_cell(:B) do
        uses :A
      end
      c = mock_cell(:C) do
        uses :B
      end
      c.dependencies.should == [a,b]
    end

    it "can order all cells in order of dependencies" do
        a = mock_cell(:A) do
          uses :B, :G
        end
        b = mock_cell(:B) do
          uses :C
        end
        c = mock_cell(:C)
        d = mock_cell(:D)
        f = mock_cell(:F)
        g = mock_cell(:G)
        h = mock_cell(:H) do
          uses :A,:D
        end
        i = mock_cell(:I) do
          uses :H
        end
      Cell::Base.stub(:descendants).and_return(@cells.values)
        Cell::Rails.total_order.should == [c,b,g,a,d,f,h,i]
    end
  
  def mock_cell(name, &body)
    Class.new(Cell::Rails).tap do |cell|
      mc = class << cell;self;end
      mc.send(:define_method, :to_s) do
        "#{name}"
      end
      mc.send(:define_method, :cell_name) do
        "#{name}"
      end
      @cells[name.to_s] = cell
      def cell.view_paths
        ["/mock/cells"]
      end
      cell.class_eval(&body) if block_given?
    end
  end
end

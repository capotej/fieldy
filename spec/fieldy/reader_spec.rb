require_relative '../spec_helper'

class ExampleFile
  include Fieldy::Reader

  field :first_name, 12
  field :last_name, 12 
  skip 5
  field :grade, 2
end

describe Fieldy::Reader do

  describe "getting data from the example" do

    let(:example) do
      ExampleFile.read("TESTY       MCTESTER         11")
    end

    it "should be able to parse the first name" do
      example[:first_name].must_equal 'TESTY'
    end

  end

  describe "to_sql" do
    it "should return the expected sql string" do
      ExampleFile.to_sql.must_equal "create table READER (first_name varchar(12),last_name varchar(12),grade varchar(2))"
    end
  end

end

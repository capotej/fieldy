require 'test/helper'

class ExampleFile
  include Fieldy::Reader

  field :first_name, 12
  field :last_name, 12 
  skip 5
  field :grade, 2

end


class TestReader < Test::Unit::TestCase

  def test_reader
    a = ExampleFile.read("TESTY       MCTESTER         11")
    assert_equal a[:first_name], "TESTY"
  end

  def test_sql_output
    assert_equal ExampleFile.to_sql, "create table READER (first_name varchar(12),last_name varchar(12),grade varchar(2))"
  end



end

require 'test/helper'

class AnotherFile 
  include Fieldy::Writer

  field :first_name, 5
  field :last_name, 5

end

class TestWriter < Test::Unit::TestCase
  def test_writer
    a = AnotherFile.write(:first_name => "jimmy", :last_name => "fall")
    assert_equal 10, a.length
  end

  
  
end

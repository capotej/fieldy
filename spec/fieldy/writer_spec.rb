require_relative '../spec_helper'

class AnotherFile 
  include Fieldy::Writer

  field :first_name, 5
  field :last_name, 5
end

describe Fieldy::Writer do

  describe "writing a file" do

    it "should have the proper length" do
      a = AnotherFile.write(:first_name => "jimmy", :last_name => "fall")
      a.length.must_equal 10
    end

  end

  describe "writing an instance of a file" do

    it "should return the full line" do

      file = AnotherFile.new.tap do |f|
               f.first_name = 'test1'
               f.last_name  = 'test2'
             end
      file.write.must_equal('test1 test2 ') 
    end

  end

end

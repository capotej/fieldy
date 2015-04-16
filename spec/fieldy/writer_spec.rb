require_relative '../spec_helper'

class AnotherFile 
  include Fieldy::Writer

  field :first_name, 5
  field :last_name, 5
end

class AWriterWithASkip
  include Fieldy::Writer

  field :first_name, 5
  skip 20
  field :last_name, 5
end

class AWriterWithAHardcodedValue
  include Fieldy::Writer
  field :first_name, 5
  hardcode "abcdefg"
  field :last_name, 5
end

class AWriterWithAFillValue
  include Fieldy::Writer
  field :first_name, 5
  skip 5, fill_with: '*'
  field :last_name, 5
end

class AWriterWithRightJustification
  include Fieldy::Writer
  field :first_name, 10, justify: :right
  field :last_name,  10, justify: :right
end

class AWriterWithRightJustificationAndFill
  include Fieldy::Writer
  field :first_name, 10, { justify: :right, fill_with: '-' }
  field :last_name,  10, { justify: :right, fill_with: '-' }
end

class AWriterWithASpecialWrite
  include Fieldy::Writer
  field :name, 10, { write: ->(x) { x * 2 } }
end

describe Fieldy::Writer do

  it "should create attr_accessors for each field" do
    file = AnotherFile.new

    name = SecureRandom.uuid
    file.first_name = name
    file.first_name.must_equal name

    name = SecureRandom.uuid
    file.last_name = name
    file.last_name.must_equal name
  end

  describe "registered methods" do
    it "should include the basic methods supported out-of-the-box" do
      Fieldy::Writer.registered_methods.tap do |methods|
        methods.count.must_equal 3
        methods.keys.include?(:hardcode).must_equal true
        methods.keys.include?(:skip).must_equal true
        methods.keys.include?(:field).must_equal true
      end
    end
  end

  describe "writing a file" do

    it "should have the proper length" do
      a = AnotherFile.write(:first_name => "jimmy", :last_name => "fall")
      a.length.must_equal 10
    end

  end

  describe "converting values to strings" do
    it "should convert the value to strings" do
      a = AnotherFile.write(:first_name => 1)
      a.must_equal '1         '
    end
  end

  describe "to_s" do

    it "should return the full line" do

      file = AnotherFile.new.tap do |f|
               f.first_name = 'test'
               f.last_name  = 'test2'
             end
      file.to_s.must_equal('test test2') 
    end

  end

  describe "justification" do
    it "should allow right justification" do
      file = AWriterWithRightJustification.new.tap do |f|
               f.first_name = 'John'
               f.last_name  = 'Galt'
             end
      file.to_s.must_equal '      John      Galt'
    end

    it "should allow right justification with a fill" do
      file = AWriterWithRightJustificationAndFill.new.tap do |f|
               f.first_name = 'John'
               f.last_name  = 'Galt'
             end
      file.to_s.must_equal '------John------Galt'
    end
  end

  describe "skipping" do
    it "should return the appropriate number of spaces" do
      writer = AWriterWithASkip.new
      writer.to_s.must_equal "                              "
    end

    it "should allow for a different fill value" do
      writer = AWriterWithAFillValue.new
      writer.to_s.must_equal '     *****     '
    end
  end

  describe "hardcoded values" do
    it "should hardcode the value" do
      AWriterWithAHardcodedValue.new.to_s.must_equal "     abcdefg     "
    end
  end

  describe "providing a way to write the string" do
    it "should use the method provided" do
      writer = AWriterWithASpecialWrite.new
      writer.name = 'x'
      writer.to_s.must_equal 'xx        '
        
    end
  end

  describe "fields" do

    it "should contain a record for each field" do
      AnotherFile.fields.tap do |fields|
        fields.count.must_equal 2
        fields[0][:key].must_equal :first_name
        fields[0][:length].must_equal 5
        fields[1][:key].must_equal :last_name
        fields[1][:length].must_equal 5
        fields.each { |f| f[:type].nil?.must_equal true }
      end

      AWriterWithASkip.fields.tap do |fields|
        fields.count.must_equal 3
        fields[0][:key].must_equal :first_name
        fields[1][:key].must_equal nil
        fields[1][:length].must_equal 20
        fields[2][:key].must_equal :last_name
        fields[2][:length].must_equal 5
        fields.each { |f| f[:type].nil?.must_equal true }
      end
        
    end

    describe "incrementing the start_at for each field" do

      it "should use start_at to record the starting point of each field" do

        AnotherFile.fields.tap do |fields|
          fields[0][:starts_at].must_equal 0
          fields[1][:starts_at].must_equal 5
        end

        AWriterWithASkip.fields.tap do |fields|
          fields[0][:starts_at].must_equal 0
          fields[1][:starts_at].must_equal 5
          fields[2][:starts_at].must_equal 25
        end

      end

    end

  end

end

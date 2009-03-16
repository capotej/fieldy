# Fieldy

Fieldy is a ruby library for reading and writing fixed width records

## Example:

### Writing Records
    class AnotherFile 
      include Fieldy::Writer

      field :first_name, 5
      field :last_name, 5

    end
    
    AnotherFile.write(:first_name => "jimmy", :last_name => "fall")
    #=> "jimmyfall "

### Reading Records

    class ExampleFile
      include Fieldy::Reader

      field :first_name, 12
      field :last_name, 12 
      skip 5
      field :grade, 2
      
    end
    a = ExampleFile.read("TESTY       MCTESTER         11")

    a[:first_name] => "TESTY"

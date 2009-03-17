# Fieldy

Fieldy is a ruby library for reading and writing fixed width records


## Installation

Add the github gem source if you haven't already:
    
    gem sources -a http://gems.github.com
    
Install the gem:

    gem install jcapote-fieldy



## Examples

### Writing Records

    require 'fieldy'

    class AnotherFile 
      include Fieldy::Writer

      field :first_name, 5
      field :last_name, 5

    end
    
    AnotherFile.write(:first_name => "jimmy", :last_name => "fall")
    #=> "jimmyfall "

### Reading Records

    require 'fieldy'

    class ExampleFile
      include Fieldy::Reader

      field :first_name, 12
      field :last_name, 12 
      skip 5
      field :grade, 2
      
    end
    a = ExampleFile.read("TESTY       MCTESTER         11")

    a[:first_name] => "TESTY"


## License and Author

Copyright 2009 Julio Capote (jcapote@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Fieldy

  module Writer

    def self.included(base)
      base.extend(WriterMethods)
    end
      

    module WriterMethods
      
      def write(hash)
        res = []
        pack_str = ""
        @fields.each do |h|
          h.each do |k,v|
            hash.each do |x,y|
              unless k == :null
                res << y
              end
            end
          pack_str << "#{v[:type]}#{v[:length]}"
          end
        end
        res.pack(pack_str)
      end
      
      def field(sym, length, type = "A")
        @fields ||= []
        @fields << { sym => { :length => length, :type => type }}
      end
      
      def skip(length)
        self.field(:null, length, "x" )
      end
    end
    
  end
    
end

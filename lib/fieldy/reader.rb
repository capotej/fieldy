module Fieldy

  module Reader

    def self.included(base)
      base.extend(ReaderMethods)    
    end

    module ReaderMethods

      def read(str)
        res = {}
        unpack_str = ""
        @fields.each do |h|
          h.each do |k,v|
            unpack_str << "#{v[:type]}#{v[:length]}"
          end
        end
        arr = str.unpack(unpack_str)
        count = 0
        @fields.each do |h|
          h.each do |k,v|
            unless k == :null
              res.store(k, arr[count])
              count = count + 1
            end
          end
        end
        res
      end
      
      def field(sym, length, type = "A")
        @fields ||= []
        @fields << { sym => { :length => length, :type => type }}
      end


      def to_sql
        sql = "create table READER ("
        fields = []
        @fields.each do |f|
          f.each do |k,v|
            unless k == :null
              fields << "#{k} varchar(#{v[:length]})"
            end
          end
        end
        sql + fields.join(",") + ")"
      end





      def skip(length)
        self.field(:null, length, "x" )
      end
      
    end
  end


end


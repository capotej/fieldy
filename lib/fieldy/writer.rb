module Fieldy

  module Writer

    def self.included(base)
      base.extend(WriterMethods)
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def write
        fields = self.class.instance_eval { @fields }
        data = fields.reduce({}) do |t, i|
                 key = i.keys.first
                 t.merge!(key => self.send(key))
               end
        self.class.write data
      end
    end

    module WriterMethods

      def write(hash)
        res = []
        @fields.each do |h|
          h.each do |k,v|
            hash.each { |x, y| res << (k == :null ? ' ' : y) }
          end
        end
        pack_str = @fields.map do |h|
                     h.map { |k,v| "#{v[:type]}#{v[:length]}" }
                   end.join ('')
        res.pack(pack_str)
      end

      def field(sym, length, type = "A")
        @fields ||= []
        @fields << { sym => { :length => length, :type => type }}
        self.send(:attr_accessor, sym)
      end

      def skip(length)
        self.field(:null, length, "A" )
      end
    end

  end

end


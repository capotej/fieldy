module Fieldy

  module Writer

    def self.included(base)
      base.extend(WriterMethods)
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def write
        fields = self.class.instance_eval { @fields }
        data = fields.map        { |x| x[:key] }
                     .select     { |x| x }
                     .reduce({}) { |x, key| x.merge! key => self.send(key) }
        self.class.write data
      end
    end

    module WriterMethods

      def write(hash)
        values  = @fields.map { |x| x[:key] }.map { |x| hash[x] || '' }
        pack    = @fields.map { |x| "#{x[:type]}#{x[:length]}" }.join ''

        values.pack pack
      end

      def field(sym, length, type = "A")
        @fields ||= []
        @fields << { key: sym, :length => length, :type => type }
        self.send(:attr_accessor, sym) if sym
      end

      def skip(length)
        self.field(nil, length, "A" )
      end
    end

  end

end


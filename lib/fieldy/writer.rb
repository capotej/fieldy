module Fieldy

  module Writer

    def self.included(base)
      base.extend(WriterMethods)
      base.send :include, InstanceMethods
    end

    module InstanceMethods

      def to_s
        data = self.class.fields
                         .map        { |x| x[:key] }
                         .select     { |x| x }
                         .reduce({}) { |x, k| x.merge! k => self.send(k) }
        self.class.write data
      end

    end

    module WriterMethods

      def write hash
        values  = fields.map { |x| (x[:value] || hash[x[:key]] || '') + ((x[:fill_with] || '') * x[:length]) }
        pack    = fields.map { |x| "A#{x[:length]}" }.join ''

        values.pack pack
      end

      def fields
        @fields ||= []
      end

      def field(sym, length, options = {})
        starts_at = fields.reduce(0) { |t, i| t + i[:length] }
        fields << { key: sym, length: length, starts_at: starts_at }.merge(options)
        self.send(:attr_accessor, sym) if sym
      end

      def skip(length, options = {})
        self.field(nil, length, options)
      end

      def hardcode(value)
        self.field(nil, value.length, { value: value } )
      end

    end

  end

end

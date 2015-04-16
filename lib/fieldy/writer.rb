module Fieldy

  module Writer

    def self.included(base)
      base.extend(WriterMethods)
      base.send :include, InstanceMethods
    end

    def self.registered_methods
      @registered_methods ||= {}
    end

    def self.register_method meth, *_, &blk
      registered_methods[meth] = blk
      WriterMethods.send(:define_method, meth, &blk)
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
        values  = fields.map  { |x| { field: x, computed_value: (x[:value] || hash[x[:key]].to_s || '') } }
                        .each do |x|
                                if x[:field][:write]
                                  x[:computed_value] = x[:field][:write].call x[:computed_value]
                                end
                              end
                        .each do |x|
                                if x[:field][:justify] != :right
                                  x[:computed_value] += ((x[:field][:fill_with] || '') * x[:field][:length])
                                end
                              end
                        .each do |x|
                                if x[:field][:justify] == :right
                                  length = x[:field][:length] - x[:computed_value].length
                                  if length > 0
                                    x[:computed_value] = "#{(x[:field][:fill_with] || ' ') * length}#{x[:computed_value]}"
                                  end
                                end
                              end
                       .map { |x| x[:computed_value] }
        pack    = fields.map  { |x| "A#{x[:length]}" }.join ''

        values.pack pack
      end

      def fields
        @fields ||= []
      end

    end

  end

  Writer.register_method(:hardcode) do |value|
    self.field(nil, value.length, { value: value } )
  end

  Writer.register_method(:skip) do |length, options={}|
    self.field(nil, length, options)
  end

  Writer.register_method(:field) do |sym, length, options={}|
    starts_at = fields.reduce(0) { |t, i| t + i[:length] }
    fields << { key: sym, length: length, starts_at: starts_at }.merge(options)
    self.send(:attr_accessor, sym) if sym
  end

end

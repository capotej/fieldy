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
        res = @fields.reduce([]) do |res, f|
                res.tap do |res|
                  f.map  { |f| f[0] }
                   .each { |k| hash.map  { |x| x[1] }
                                   .map  { |v| (k == :null ? ' ' : v) }
                                   .each { |v| res << v }
                         }
                end
              end
        pack = @fields.map { |f| f.values[0] }
                      .map { |v| "#{v[:type]}#{v[:length]}" }
                      .join('')
        res.pack pack
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


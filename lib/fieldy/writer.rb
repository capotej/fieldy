module Fieldy

  module Writer

    def self.included(base)
      base.extend(WriterMethods)
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def write
        fields = self.class.instance_eval { @fields }
        data = fields.map        { |x| x.keys.first }
                     .select     { |x| x }
                     .reduce({}) { |x, key| x.merge! key => self.send(key) }
        self.class.write data
      end
    end

    module WriterMethods

      def write(hash)
        res = @fields.reduce([]) do |res, f|
                res + f.map  { |f| f[0] }
                       .flat_map { |k| hash.values
                                           .map  { |x| (k.nil? ? '' : x) }
                                 }
              end
        pack = @fields.map { |f| f.values[0] }
                      .map { |v| "#{v[:type]}#{v[:length]}" }
                      .join('')
        res.pack pack
      end

      def field(sym, length, type = "A")
        @fields ||= []
        @fields << { sym => { :length => length, :type => type }}
        self.send(:attr_accessor, sym) if sym
      end

      def skip(length)
        self.field(nil, length, "A" )
      end
    end

  end

end


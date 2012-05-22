require 'dm-core'
require 'debugger'
module DataMapper
  class Property
    class HStore < Object

      def load(value)
        return nil unless value
        rv = value.split(",").map{|i| i.split("=>").map{|x| x.gsub('"','').strip}}
        Hash[*(rv.map{|k,v| [k, v == "NULL" ? nil : v]}.flatten)]
      end

      def dump(value)
        return "" unless value
        
        value.map { |idx, val| 
          iv = [idx,val].map { |_| 
            e = _.to_s.gsub(/"/, '\"')
            if _.nil?
              'NULL'
            elsif e =~ /[,\s=>]/ || e.empty?
              '"%s"' % e
            else
              e
            end
          }
          
          "%s => %s" % iv
        } * ","      
      end
      
    end # class HStore
  end # class Property
end # module DataMapper

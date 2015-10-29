class Factory
  def self.new(*args, &block)
    Class.new(self) do
      include Enumerable
      @@members = Hash.new
      
      raise ArgumentError, "wrong number of arguments (#{args.size} for 1+)" if args.size < 1
      class_name = args.shift.capitalize if args[0].is_a? String
      args.map!(&:to_sym)

      def self.new(*args)
        inst = allocate
        inst.send :initialize, *args
        inst
      end
   
      args.each do |arg|
        define_method arg do
          @values[arg]
        end
        define_method "#{arg}=" do |val|
          @values[arg] = val
        end
        @@members[arg] = nil
      end

      def self.[](*args)
        @@members.keys.each_with_index{|item, index| @@members[item] = args[index]}
        self.inspect
      end
      
      def self.members
        @@members.keys
      end

      def initialize(*args)
        raise ArgumentError, "" if args.size > @@members.size
        @values = Hash.new
        @@members.keys.each_with_index{|item, index| @values[item] = args[index]}
      end
      
      def ==(other)
        # TODO
      end

      def [](element)
        if element.is_a? Numeric
          @values[@@members.keys[element.to_i]]
        elsif element.is_a? Symbol
          @values[element]
        elsif element.is_a? String
          @values[element.to_sym]
        else
          raise TypeError, "no implicit conversion of #{element.class} into Integer"
        end
      end
      
      def []=(index, value)
        @values[@@members.keys[index]] = value
      end

      def each
        # TODO
      end

      def each_pair
        # TODO
      end

      def eql?
        # TODO
      end

      def hash
        # TODO
      end

      def inspect
        "#<factory #{self.class.name} #{@values.map{|k,v| "#{k}=#{v.inspect}"}.join(', ')}>"
      end
      alias_method :to_s, :inspect
      
      def members
        @@members.keys
      end

      def select
        # TODO
      end

      def size
        @@members.size
      end
      alias_method :length, :size

      def to_h
        @values
      end

      def values
        @values.values
      end
      alias_method :to_a, :values

      def values_at(*args)
        values.values_at(args)
      end

    end
  end 
end



puts '-----------------------------------------------'
Customer = Factory.new(:name, :address, :zip)
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
# p joe
puts '-----------------------------------------------'
Customer_struct = Struct.new(:name, :address, :zip)
joe_struct = Customer_struct.new("Joe Smith", "123 Maple, Anytown NC", 12345)
# p joe_struct
(joe_struct.methods - joe.methods)
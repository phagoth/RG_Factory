require 'rspec'
require './factory.rb'

describe Factory do
  fields = [:name, :address, :zip]
  name_value = "Alex"
  address_value = "Dnepr"
  zip_value = "49000"

  Test_struct = Struct.new(:name, :address, :zip)
  Test_factory = Factory.new(:name, :address, :zip)

  test_items =[Test_struct, Test_factory]
  

  test_items.each do |test_item|
    it "respond to :new" do
      expect(test_item.respond_to?(:new)).to be true
    end
    
    it "respond to :[]" do
      expect(test_item.respond_to?(:[])).to be true
    end
    
    it "respond to :members" do
      expect(test_item.respond_to?(:members)).to be true
    end
    
    it "has 3 singleton metods" do
      expect(test_item.singleton_methods.size).to eq 3
    end
    
    it "has :new, :[], :members as singleton metods" do
      expect(test_item.singleton_methods).to eq [:new, :[], :members]
    end
    
    it "has specified members" do
      expect(test_item.members).to eq fields
    end
    
    it "has class Class" do
      expect(test_item.class).to eq Class
    end


    it "takes values when creates instance" do
      something = test_item.new(name_value, address_value, zip_value)
      something.class == test_item.class
      expect(something[0]).to eq name_value
      expect(something[1]).to eq address_value
      expect(something[2]).to eq zip_value
    end

    it "set nil for unspecified variable" do
      something = test_item.new(name_value, address_value)
      something.class == test_item.class
      expect(something[0]).to eq name_value
      expect(something[1]).to eq address_value
      expect(something[2]).to be nil
    end
    
    it "raises exception if count of values more than count of members" do
      expect { test_item.new(name_value, address_value, zip_value, zip_value) }.to raise_error(ArgumentError)
    end

    it "returns field value by getter" do
      something = test_item.new(name_value)
      expect(something.send(fields[0])).to eq name_value
    end

    it "returns field value by index" do
      something = test_item.new(name_value)
      expect(something[0]).to eq name_value
    end

    it "returns field value by symbol" do
      something = test_item.new(name_value)
      expect(something[fields[0]]).to eq name_value
    end

    it "returns field value by field name" do
      something = test_item.new(name_value)
      expect(something[fields[0].to_s]).to eq name_value
    end
  end
  
  it "raise error when initialize with no arguments" do
      expect { a = Factory.new() }.to raise_error(ArgumentError)
  end

end

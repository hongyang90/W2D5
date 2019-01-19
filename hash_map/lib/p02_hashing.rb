class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return nil.hash if self.empty?
    result = 0
    self.each_with_index do |n, i|
      result += (n+i).hash 
    end 
    result
  end
end

class String
  def hash
    result = 0
    self.each_char.with_index do |ch, i|
      result += (ch.ord + i).hash
    end 
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted = self.sort 
    result = 0 
    sorted.each do |subarr|
      subarr.each do |ele|
        result += ele.hash
      end 
    end
    result
  end
end

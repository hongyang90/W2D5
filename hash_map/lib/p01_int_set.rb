class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    store[num] = true
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  def is_valid?(num)
    return false if num < 0 || num > store.length - 1
    true
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    value = num % num_buckets
    store[value] << num
  end

  def remove(num)
    value = num % num_buckets
    store[value].delete(num)
  end

  def include?(num)
    value = num % num_buckets
    store[value].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @count += 1
      if @count == num_buckets
        resize!
      end
      value = num % num_buckets
      store[value] << num
    end
  end

  def remove(num)
    if include?(num)
      @count -= 1
      value = num % num_buckets
      store[value].delete(num)
    end
  end

  def include?(num)
    value = num % num_buckets
    store[value].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(2 * num_buckets) { Array.new }

    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_store.length] << el
      end
    end

    @store = new_store
  end
end

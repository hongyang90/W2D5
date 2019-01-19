require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count, :store 

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    unless include?(key)
      @count += 1
      if @count == num_buckets
        resize!
      end
      bucket(key).append(key, val)
    
    end 
    # unless include?(key)
    #   @count += 1
    #   if @count == num_buckets
    #     resize!
    #   end
    #   self[key] << key
    # end
  end

  def get(key)

  end

  def delete(key)
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end 
    end 
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(2 * num_buckets) { LinkedList.new}

    @store.each do |list|
      list.each do |node|
        new_store[node.key.hash % new_store.length].append(node.key, node.val) 
      end
    end

    @store = new_store

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end

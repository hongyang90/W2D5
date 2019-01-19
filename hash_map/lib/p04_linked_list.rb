class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail, :list
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
    @list =[]
  end

  def [](i)
    list.each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
    curr_node = head.next
    until curr_node == tail
      return curr_node.val if curr_node.key == key
      curr_node = curr_node.next
    end
    nil
  end

  def include?(key)
    curr_node = head.next
    until curr_node == tail
      if curr_node.key == key
        return true
      end 
      curr_node = curr_node.next
    end
    false 
  end

  def append(key, val)
    new_node = Node.new(key, val)
    next_node = tail.prev

    next_node.next = new_node
    new_node.prev = next_node
    new_node.next = tail
    tail.prev = new_node
    list.push(new_node)
  end

  def update(key, val)
    curr_node = head.next
    until curr_node == tail
      if curr_node.key == key
        curr_node.val = val
        break
      end 
      curr_node = curr_node.next
    end
  end

  def remove(key)
    curr_node = head.next
    until curr_node == tail
      if curr_node.key == key
        prev_node = curr_node.prev
        next_node = curr_node.next

        prev_node.next = next_node
        next_node.prev = prev_node 

        list.delete(curr_node)
        break
      end 
      curr_node = curr_node.next
    end

  end

  def each
    list.each do |node|
      yield(node)
    end 
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

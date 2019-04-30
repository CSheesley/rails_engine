class LinkedList
  attr_reader :head, :count

  def initialize
    @head = nil
    @count = 0
  end

  def prepend(data)
    previous_head = @head
    @head = Node.new(data)
    @head.next_node = previous_head
    @count += 1
  end

  def append(data)
    if @head.nil?
      @head = Node.new(data)
    else
      add_node(data)
    end
    @count += 1
  end

  def add_node(data)
    if @head.next_node.nil?
      @head.next_node = Node.new(data)
    else
      last_node.next_node = Node.new(data)
    end
  end

  def last_node
    node = @head.next_node
    until node.next_node.nil?
      node = node.next_node
    end
    node
  end

  def to_string
    string = ""
    head = self.head
    node = @head.next_node

    string << ("#{head.data.to_s} ") unless head.nil?

    each_node_to_string(node, string)
    string.rstrip
  end

  def each_node_to_string(node, string)
    unless node.nil?
      until node.next_node.nil?
        string << ("#{node.data.to_s} ")
        node = node.next_node
      end
      string << ("#{node.data.to_s} ")
    end
    string
  end

  def insert(index, data)
    current_node = node_at_index(index)
    prior_node = node_at_index(index - 1)

    prior_node.next_node = Node.new(data)
    prior_node.next_node.next_node = current_node
  end

  def node_at_index(index)
    node = @head
    counter = 0

    until counter == index
      node = node.next_node
      counter += 1
    end
    node
  end

  def find(index, return_count)
    node = node_at_index(index)
    counter = 0
    string = ""

    until counter == return_count
      string << ("#{node.data.to_s} ")
      node = node.next_node
      counter += 1
    end
    string.rstrip
  end

  def includes?(data)
    check = false
    node = @head
    until node.next_node.nil?
      check = true if node.data == data
      node = node.next_node
    end
    check
  end

  def pop
    node = @head
    until node.next_node.next_node.nil?
      node = node.next_node
    end
    popped_data = node.next_node.data
    node.next_node = nil
    popped_data
  end

end

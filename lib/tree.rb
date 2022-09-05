# frozen_string_literal: true

require_relative 'node'

# In this class is the balanced tree building logic and methods
class Tree
  attr_accessor :data, :root

  def initialize(array)
    @data = array.uniq.sort
    p data
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = (array.size - 1) / 2
    node = Node.new(array[middle])

    node.left = build_tree(array[0...middle])
    node.right = build_tree(array[(middle + 1)..])

    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)

    elsif value > node.data
      node.right = delete(value, node.right)

    else
      # if node has one or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # if node has two children
      leftmost_node = left_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    node
  end

  def left_leaf(node = root)
    node = node.left until node.left.nil?
    node
  end

  def find(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left = find(value, node.left)

    elsif value > node.data
      node.right = find(value, node.right)
    else 
      node
    end
  end

  def level_order(node = root, queue = [])
    return node if node.nil?
    queue.push(node)
    while !queue.empty?
      node = queue[0]
      if !node.left.nil? 
        queue.push(node.left)
      end
      if !node.right.nil? 
        queue.push(node.right)
      end
        puts "Node data is #{node.data}"
      queue.shift
    end
  end

  def preorder(node = root)
    # <root><left><right>
    return nil if node.nil?
    puts "#{node.data}"
    preorder(node.left)
    preorder(node.right)
  end

  def inorder (node = root)
    # <left><root><right>
    return nil if node.nil?

    inorder(node.left)
    puts "#{node.data}"
    inorder(node.right)
  end

  def postorder(node = root)
    # <left><right><root>
    return nil if node.nil?

    postorder(node.left)
    postorder(node.right)
    puts "#{node.data}"
  end

end

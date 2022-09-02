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
end

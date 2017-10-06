class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent)
    return if @parent == parent
    if @parent
      @parent.children.delete(self)
    end
      @parent = parent
      @parent.children << self unless @parent.nil?
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    if self.children.include?(child_node)
      child_node.parent=(nil)
    else
      raise "No child"
    end
  end
=begin
  def dfs(target_value)
    if @value == target_value
      return self
    end
    children = @children
    children.each do |child|
      val = child.dfs(target_value)
      return val if val
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end

    nil
  end
=end
end

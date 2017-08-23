class DynamicProgramming

  def initialize
    @blair_cache = {}
    @blair_cache[1] = 1
    @blair_cache[2] = 2

    @frog_cache = {}
    @frog_cache[1] = [[1]]
    @frog_cache[2] = [[2],[1,1]]
    @frog_cache[3] = [[1,1,1],[1,2],[2,1],[3]]

  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?
    ans = blair_nums(n-1)+blair_nums(n-2)+(2*n)-3
    @blair_cache[n] = ans
    return ans
  end

  def frog_hops_bottom_up(n)
    arr = frog_cache_builder(n)
    arr[n].sort
  end

  def frog_cache_builder(n)
    cache = {}
    cache[1] = [[1]]
    cache[2] = [[1,1],[2]]
    cache[3] = [[1,1,1],[1,2],[2,1],[3]]
    return cache if n < 4
    int = 4
    until int > n
      set = []
      cache[int-1].each do |array|
        set.push(array+[1])
        newArr = array
        newArr[-1] = array[-1]+1
        if newArr.all?{|el| el <= 3}
          set.push(newArr)
        end
      end
      cache[int] = set.uniq.sort
      int+=1
    end
    return cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    set = []
    third_last_arr = frog_hops_top_down_helper(n-3)
    second_last_arr = frog_hops_top_down_helper(n-2)
    last_arr = frog_hops_top_down_helper(n-1)
    last_arr.each do |array|
      set.push(array+[1])
      newArr = array
      newArr[-1] = array[-1]+1
      if newArr.all?{|el| el <= 3}
        set.push(newArr)
      end
    end
    @frog_cache[n] = set.uniq.sort
    return @frog_cache[n]
  end

  def super_frog_hops(n, k)
    super_cache = {}
    super_cache[1] = [[1]]
    int = 2
    until int > n
      set = []
      super_cache[int-1].each do |array|
        set.push(array+[1])
        newArr = array
        newArr[-1] = array[-1]+1
        if newArr.all?{|el| el <= k}
          set.push(newArr)
        end
      end
      super_cache[int] = set.uniq.sort
      int+=1
    end
    return super_cache[n]

  end

  def knapsack(weights, values, capacity)
    return 0 if weights.length == 0 || capacity == 0
    cache = knapsack_table(weights,values,capacity)
    cache[capacity][weights.length-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    cache = {}
    (0..capacity).each do |cap|
      cache[cap] = []
      (0..weights.length-1).each do |weight|
        if cap == 0
          cache[cap][weight] = 0
        elsif weight == 0
          cache[cap][weight] = weights[0] > cap ? 0 : values[0]
        else
          one = cache[cap][weight-1]
          two = cap < weights[weight] ? 0 : cache[cap-weights[weight]][weight-1] + values[weight]
          max = [one,two].max
          cache[cap][weight] = max
        end
      end
    end
    cache
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

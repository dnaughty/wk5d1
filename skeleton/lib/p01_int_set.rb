require 'byebug'

class MaxIntSet

  attr_reader :store
  
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    if validate!(num)
      @store[num]=false 
      # @store[num]
    else
       @store[num]=true
    end
  end

  def remove(num)
    @store[num]= false
  end

  def include?(num)
    @store[num]
    
  end



  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)
     raise "Out of bounds" if !is_valid?(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store << num 
  end

  def remove(num)
   idx = @store.index(num)
   @store.delete_at(idx)
  end

  def include?(num)
     @store.include?(num)
    
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count >= num_buckets

    #call resize when count >= buckets
    if !include?(num)
      bucket = num % (num_buckets)
      @store[bucket] << num

      @count +=1
    end
  end

  def remove(num)
    if include?(num)
      
     bucket = num % (num_buckets)
      idx = @store[bucket].index(num)
      @store[bucket].delete_at(idx)
      @count-=1
    end

  end

  def include?(num)
    #debugger
    
    bucket = num % (num_buckets)
    # @store.each  { |x| return false if x.include?(num) }
      @store[bucket].include?(num)
    # @store.flatten.include?(num)
  
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!

    #double amount of bucket, or make a new set of buckets and move all the bucketrs to the new set

  #  res =  @store.length 
  #   res.times {|x|  @store<<[]}

     @store2 = @store.clone
    # num_buckets*=2
    @store2 =Array.new(num_buckets*2) { Array.new }

    @store2.each do |sub|
      sub.each do |ele|
        insert(ele)
      end

    end


    


end
end

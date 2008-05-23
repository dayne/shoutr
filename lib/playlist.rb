require 'thread'
####### Queue methods
# <<    clear   deq   empty?   
# enq   length  new   num_waiting   
# pop   push    shift size   
class Queue
  attr_reader :que
end

class Playlist < Queue

  def insert(index,obj)
    @que.insert(index,obj) # TODO
  end

  def shuffle
    @que.shuffle!  # TODO
  end

  def clear
    @que = []
  end

  def move(cur_pos,new_pos)
    cur_pos=cur_pos.to_i
    new_pos=new_pos.to_i
    if (@que.size<= cur_pos) || (@que.size<= new_pos) || (cur_pos<0) || (new_pos<0)
      raise "Out of Bounds"
    end
    insert(new_pos,delete_at(cur_pos))
  end

  def copy(cur_pos,new_pos)
    cur_pos=cur_pos.to_i
    new_pos=new_pos.to_i
    if (@que.size<= cur_pos) || (cur_pos<0) || (new_pos<0)
      raise "Out of Bounds"
    end
    if (@que.size<= new_pos)
      enq(@que.at(cur_pos))
      return @que.size
    else
      insert(new_pos,@que.at(cur_pos))
      return new_pos
    end
  end

  def delete_at(index)
    @que.delete_at(index.to_i) # TODO
  end

  def [](index)
    @que[index]
  end

  def pull(index)
    # TODO
  end
end

if __FILE__ == $0
# perhaps add some testing stuff here
end

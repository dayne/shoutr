$: << File.join( File.dirname( __FILE__ ), '../lib' )

require 'rubygems'
require 'spec'
require 'playlist'
require 'pp'

context "Testing shoutr playlist" do
  setup do
    @p = Playlist.new
    @p.enq "a"; @p.enq "b"; @p.enq "c"
  end

  specify "begins test with 3 elements and can be cleared" do
    @p.size.should == 3
    @p.clear
    @p.size.should == 0
  end

  specify "adding element should increase playlist size" do
    @p.enq "d"
    @p.size.should == 4
    @p.deq.should == "a"
    @p.size.should == 3 
  end

  specify "copying an element should move it" do
    @p[0].should == "a"
    @p[2].should == "c"
    lambda {@p.move(2,0)}.should_not raise_error("Out of Bounds")
    @p[0].should == "c"
    @p[2].should == "b"
  end

  specify "copying out of range should cause an error" do
    lambda {@p.move(0,4)}.should raise_error("Out of Bounds")
  end

  specify "removing an element" do
    @p.delete_at(1)
    @p[0].should == "a"
    @p[1].should == "c"
    @p.size.should == 2
  end

  specify "copying an element" do
    @p.copy(0,3) # a b c a
    @p[3].should == "a"
    @p.copy(1,0) # b a b c a
    @p[0].should == "b"
    lambda {@p.copy(13,0)}.should raise_error("Out of Bounds")
  end

# no shuffle yet
#  specify "shuffling test" do
#    @p.shuffle
#    pp @p
#    @p[0].should != "a"
#  end
end

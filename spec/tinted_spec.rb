describe "bit twiddling" do

  # used to understand how to set and clear bits
  describe "OR and XOR" do
    it "should do maths" do
      120.should == 0b01111000
      x = 0b01111000 | 0b01110000 ^ 0b01110000
      x.should == 0b00001000

      x = 0b01110111 | 0b00000111 ^ 0b00000111
      x.should == 0b01110000
      x = 0b01110101 | 0b00000111 ^ 0b00000111
      x.should == 0b01110000

      x = 0b10001000 | 0b10000000 ^ 0b10000000
      x.should == 0b00001000
    end
  end

end
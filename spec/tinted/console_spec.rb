describe "Tinted::Console" do

  before do
    @console = Tinted::Console.new
  end

  describe "#attribute" do 

    before do
      @a = @console.attribute
    end

    it "should not be nil" do
      @a.should_not be_nil
    end

    it "should be an integer" do
      @a.should be_an Integer
    end

  end

  describe "#foreground" do

    it "should set the foreground bits to the right color" do
      a = @console.instance_variable_get("@attribute")
      a.should == 0b11110000
      @console.foreground(:blue)
      a = @console.instance_variable_get("@attribute")
      a.should == 0b11110001
    end

  end

  describe "#background" do

    it "should set the background bits to the right color" do
      a = @console.instance_variable_get("@attribute")
      a.should == 0b11110000
      @console.background(:blue)
      a = @console.instance_variable_get("@attribute")
      a.should == 0b10010000
    end

  end

  describe "#reset" do

    it "should set the attribute back to the initial value" do
      init = @console.instance_variable_get("@attribute")
      @console.background(:blue)
      @console.foreground(:blue)
      a = @console.instance_variable_get("@attribute")
      a.should == 0b10010001

      @console.reset
      a = @console.instance_variable_get("@attribute")
      a.should == init
    end

  end

  describe "#text" do

    it "should print text" do
      str = 'Hello World!'
      out = @console.text(str)
      # out.should == str.length

      str = ''
      out = @console.text(str)
      # out.should == str.length
    end
  
  end

end

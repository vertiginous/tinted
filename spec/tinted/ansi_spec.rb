describe "ASNIParser" do

  before do
    @parser = Tinted::ANSIParser.new
    @text =<<-END
      \e[0mclear\e[0m\e[0mreset\e[0m\e[1mbold\e[0m\e[2mdark\e[0m\e[4m
      underscore\e[0m\e[5mblink\e[0m\e[7mnegative\e[0m\e[8mconcealed\e[0m
      |\e[30mblack\e[0m\e[31mred\e[0m\e[32mgreen\e[0m\e[33myellow\e[0m\e[34m
      blue\e[0m\e[35mmagenta\e[0m\e[36mcyan\e[0m\e[37mwhite\e[0m|\e[40m
      on_black\e[0m\e[41mon_red\e[0m\e[42mon_green\e[0m\e[43mon_yellow\e[0m
      \e[44mon_blue\e[0m\e[45mon_magenta\e[0m\e[46mon_cyan\e[0m\e[47mon_white
      \e[0m|\e[0;1;24;40;37mwhite_on_black\e[0m|
      END
  end

  describe "#parse" do
    it "should return a treetop object" do
      parsed = @parser.parse(@text)
      parsed.should_not be_nil
      parsed.should be_a Treetop::Runtime::SyntaxNode
    end
  end

  describe "#output" do
    it "should return an array of commands" do
      output = @parser.parse("\e[0m").output
      output.should be_an Array

      output.should == [:reset]
    end

    it "should return text" do
      output = @parser.parse("Hello World!").output
      output.first.should == {:text=>"Hello World!"}
    end

    it "should parse foreground codes" do
      output = @parser.parse("\e[30m").output
      output.should == [{:foreground => :black}]
    end

    it "should parse background codes" do
      output = @parser.parse("\e[41m").output
      output.should == [{:background => :red}]
    end
        
    it "should parse a reset" do 
      output = @parser.parse("\e[0mreset\e[0m").output
      output.should == [:reset, {:text=>"reset"}, :reset]
    end

    it "should parse a bold" do 
      output = @parser.parse("\e[1mbold\e[0m").output
      output.should == [:bold, {:text=>"bold"}, :reset]
    end

    it "should parse a dark" do 
      output = @parser.parse("\e[2mdark\e[0m").output
      output.should == [:faint, {:text=>"dark"}, :reset]
    end

    it "should parse an underscore" do 
      output = @parser.parse("\e[4munderscore\e[0m").output
      output.should == [:underline, {:text=>"underscore"}, :reset]
    end

    it "should parse a blink" do 
      output = @parser.parse("\e[5mblink\e[0m").output
      output.should == [:blink, {:text=>"blink"}, :reset]
    end

    it "should parse a negative" do 
      output = @parser.parse("\e[7mnegative\e[0m").output
      output.should == [:negative, {:text=>"negative"}, :reset]
    end

    it "should parse a concealed" do 
      output = @parser.parse("\e[8mconcealed\e[0m").output
      output.should == [:conceal, {:text=>"concealed"}, :reset]
    end

    it "should parse a black foreground" do 
      output = @parser.parse("\e[30mblack\e[0m").output
      output.should == [{:foreground=>:black}, {:text=>"black"}, :reset]
    end

    it "should parse a red foreground" do 
      output = @parser.parse("\e[31mred\e[0m").output
      output.should == [{:foreground=>:red}, {:text=>"red"}, :reset]
    end

    it "should parse a green foreground" do 
      output = @parser.parse("\e[32mgreen\e[0m").output
      output.should == [{:foreground=>:green}, {:text=>"green"}, :reset]
    end

    it "should parse a yellow foreground" do 
      output = @parser.parse("\e[33myellow\e[0m").output
      output.should == [{:foreground=>:yellow}, {:text=>"yellow"}, :reset]
    end

    it "should parse a blue foreground" do 
      output = @parser.parse("\e[34mblue\e[0m").output
      output.should == [{:foreground=>:blue}, {:text=>"blue"}, :reset]
    end

    it "should parse a magenta foreground" do 
      output = @parser.parse("\e[35mmagenta\e[0m").output
      output.should == [{:foreground=>:magenta}, {:text=>"magenta"}, :reset]
    end

    it "should parse a cyan foreground" do 
      output = @parser.parse("\e[36mcyan\e[0m").output
      output.should == [{:foreground=>:cyan}, {:text=>"cyan"}, :reset]
    end

    it "should parse a white foreground" do 
      output = @parser.parse("\e[37mwhite\e[0m").output
      output.should == [{:foreground=>:white}, {:text=>"white"}, :reset]
    end

    it "should parse a black background" do 
      output = @parser.parse("\e[40mon_black\e[0m").output
      output.should == [{:background=>:black}, {:text=>"on_black"}, :reset]
    end

    it "should parse a red background" do 
      output = @parser.parse("\e[41mon_red\e[0m").output
      output.should == [{:background=>:red}, {:text=>"on_red"}, :reset]
    end

    it "should parse a green background" do 
      output = @parser.parse("\e[42mon_green\e[0m").output
      output.should == [{:background=>:green}, {:text=>"on_green"}, :reset]
    end

    it "should parse a yellow background" do 
      output = @parser.parse("\e[43mon_yellow\e[0m").output
      output.should == [{:background=>:yellow}, {:text=>"on_yellow"}, :reset]
    end

    it "should parse a blue background" do 
      output = @parser.parse("\e[44mon_blue\e[0m").output
      output.should == [{:background=>:blue}, {:text=>"on_blue"}, :reset]
    end

    it "should parse a magenta background" do 
      output = @parser.parse("\e[45mon_magenta\e[0m").output
      output.should == [{:background=>:magenta}, {:text=>"on_magenta"}, :reset]
    end

    it "should parse a cyan background" do 
      output = @parser.parse("\e[46mon_cyan\e[0m").output
      output.should == [{:background=>:cyan}, {:text=>"on_cyan"}, :reset]
    end

    it "should parse a white background" do 
      output = @parser.parse("\e[47mon_white\e[0m").output
      output.should == [{:background=>:white}, {:text=>"on_white"}, :reset]
    end

  end

end

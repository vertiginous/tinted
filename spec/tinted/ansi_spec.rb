describe "ASNIParser" do

  before do
    @parser = ANSIParser.new
    @text =<<-END
    \e[0mclear\e[0m\e[0mreset\e[0m\e[1mbold\e[0m\e[2mdark\e[0m\e[4munderscore\e[0m\e[5mblink\e[0m\e[7mnegative\e[0m\e[8mconcealed\e[0m|
    \e[30mblack\e[0m\e[31mred\e[0m\e[32mgreen\e[0m\e[33myellow\e[0m\e[34mblue\e[0m\e[35mmagenta\e[0m\e[36mcyan\e[0m\e[37mwhite\e[0m|
    \e[40mon_black\e[0m\e[41mon_red\e[0m\e[42mon_green\e[0m\e[43mon_yellow\e[0m\e[44mon_blue\e[0m\e[45mon_magenta\e[0m\e[46mon_cyan\e[0m\e[47mon_white\e[0m|
      \e[0;1;24;40;37mwhite_on_black\e[0m|
    END
  end

  describe "#parse" do
    it "should return a treetop object" do
      @parser.parse(@text).should_not be_nil
    end
  end

end
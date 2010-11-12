describe "Tinted::API" do

  it "should do something" do
    desired_access     = Tinted::Constants::DESIRED_ACCESS
    share_mode         = Tinted::Constants::SHARE_MODE
    screen_buffer_data = Tinted::Constants::SCREEN_BUFFER_DATA
    h = Tinted::API.create_console_screen_buffer(
      desired_access,share_mode,nil,screen_buffer_data,nil
    )
    bi = Tinted::ConsoleScreenBufferInfo.new
    Tinted::API.get_console_screen_buffer_info(h,bi)
    bi[:wAttributes][:char].should == 240
  end

end
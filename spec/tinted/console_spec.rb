describe "Tinted::Console" do

  it "should do something" do
    desired_access     = Tinted::GENERIC_READ    | Tinted::GENERIC_WRITE
    share_mode         = Tinted::FILE_SHARE_READ | Tinted::FILE_SHARE_WRITE
    screen_buffer_data = Tinted::CONSOLE_TEXTMODE_BUFFER
    h = Tinted::Console.create_console_screen_buffer(
      desired_access,share_mode,nil,screen_buffer_data,nil
    )
    bi = Tinted::ConsoleScreenBufferInfo.new
    Tinted::Console.get_console_screen_buffer_info(h,bi)
    bi[:wAttributes][:u][:asciiChar].should == 
      Tinted::BACKGROUND_BLUE | Tinted::BACKGROUND_GREEN | 
      Tinted::BACKGROUND_RED |   Tinted::FOREGROUND_INTENSITY
  end

end
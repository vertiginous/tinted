module Tinted

  class Console
    include Constants

    def initialize
      @initial_attribute = attribute
      @attribute = @initial_attribute
    end

    def handle
      @handle ||= API.create_console_screen_buffer(
        DESIRED_ACCESS,SHARE_MODE,nil,SCREEN_BUFFER_DATA,nil
      )
    end

    def attribute
      buffer_info = Tinted::ConsoleScreenBufferInfo.new
      API.get_console_screen_buffer_info(handle,buffer_info)
      buffer_info[:wAttributes][:u][:asciiChar]
    end

    def foreground(color)
      @attribute = @attribute | 
                   0b00000111 ^ 
                   0b00000111 | 
                   FOREGROUND_COLORS[color]
    end

    def background(color)
      @attribute = @attribute | 
                   0b01110000 ^ 
                   0b01110000 |
                   BACKGROUND_COLORS[color]
    end

    def reset
      @attribute = @initial_attribute
    end
    
    def bold
      @attribute = @attribute | 0b00001000
    end

    def faint
    end

    def underline
      @attribute = @attribute | 0b10000000 
    end

    def text(str)
      ptr = FFI::MemoryPointer.new(4)
      result = API.write_console(handle,str,str.length,ptr,nil)
      raise unless result
      ptr.read_int
    end
  
  end

end
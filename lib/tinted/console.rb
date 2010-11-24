module Tinted

  class Console
    include Constants

    def initialize(std_handle=nil)
      case std_handle
      when STD_INPUT_HANDLE, STD_OUTPUT_HANDLE, STD_ERROR_HANDLE
        @handle = API.get_std_handle(std_handle)
      when nil
        @handle = handle
      else
        raise InvalidHandleError
      end
      @initial_attribute = attribute
      @attribute = @initial_attribute
      @ptr = FFI::MemoryPointer.new(4)
    end

    def handle
      @handle ||= API.create_console_screen_buffer(
        DESIRED_ACCESS,SHARE_MODE,nil,SCREEN_BUFFER_DATA,nil
      )
    end

    def attribute
      buffer_info = Tinted::ConsoleScreenBufferInfo.new
      API.get_console_screen_buffer_info(handle,buffer_info)
      buffer_info[:wAttributes][:char]
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

    def clear(x)
    end

    def reset
      @attribute = @initial_attribute
    end

    def negative
    end

    def positive
    end

    def conceal
    end

    def reveal
    end
    
    def bold
      @attribute = @attribute | 0b00001000
    end

    def faint
      @attribute = @attribute | 
                   0b00001000 ^ 
                   0b00001000
    end

    def underline
      @attribute = @attribute | 0b10000000
    end

    def no_underline
      @attribute = @attribute |
                   0b10000000 ^ 
                   0b10000000
    end

    def text(str)
      result = API.set_console_text_attribute( @handle, @attribute )
      # raise unless result
      result = API.write_console(@handle,str,str.length,@ptr,nil)
      # raise unless result
      # ptr.read_int
    end
  
  end

end
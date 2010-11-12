module Tinted

  module Constants
    GENERIC_READ              = 0x80000000
    GENERIC_WRITE             = 0x40000000
    FILE_SHARE_READ           = 0x00000001
    FILE_SHARE_WRITE          = 0x00000002
    CONSOLE_TEXTMODE_BUFFER   = 0x00000001

    FOREGROUND_BLUE           = 0x0001
    FOREGROUND_GREEN          = 0x0002
    FOREGROUND_RED            = 0x0004
    FOREGROUND_INTENSITY      = 0x0008
    BACKGROUND_BLUE           = 0x0010
    BACKGROUND_GREEN          = 0x0020
    BACKGROUND_RED            = 0x0040
    BACKGROUND_INTENSITY      = 0x0080

    DESIRED_ACCESS     = GENERIC_READ    | GENERIC_WRITE
    SHARE_MODE         = FILE_SHARE_READ | FILE_SHARE_WRITE
    SCREEN_BUFFER_DATA = CONSOLE_TEXTMODE_BUFFER

    FOREGROUND_COLORS = {
      :fg_black        => 0,
      :fg_blue         => FOREGROUND_BLUE,
      :fg_red          => FOREGROUND_RED,
      :fg_green        => FOREGROUND_GREEN,
      :fg_magenta      => FOREGROUND_RED | FOREGROUND_BLUE,
      :fg_cyan         => FOREGROUND_GREEN | FOREGROUND_BLUE,
      :fg_brown        => FOREGROUND_RED | FOREGROUND_GREEN,
      :fg_gray         => FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE
    }

    BACKGROUND_COLORS = {
      :bg_black        => 0,
      :bg_blue         => BACKGROUND_BLUE,
      :bg_red          => BACKGROUND_RED,
      :bg_green        => BACKGROUND_GREEN,
      :bg_magenta      => BACKGROUND_RED | BACKGROUND_BLUE,
      :bg_cyan         => BACKGROUND_GREEN | BACKGROUND_BLUE,
      :bg_brown        => BACKGROUND_RED | BACKGROUND_GREEN,
      :bg_gray         => BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE
    }
  end

  class Coordinates < FFI::Struct
    layout :x, :long,
           :y, :long
  end

  class SmallRectangle < FFI::Struct
    layout   :left, :short,
             :top, :short,
             :right, :short,
             :bottom, :short
  end

  class Char < FFI::Struct
    layout :unicodeChar, :short, # WCHAR
           :asciiChar,   :char # CHAR
  end
 
  class CharInfo < FFI::Struct
    layout :u, Char
  end

  class ConsoleScreenBufferInfo < FFI::Struct
    layout :dwSize, Coordinates,
           :dwCursorPosition, Coordinates,
           :wAttributes, CharInfo,
           :srWindow, SmallRectangle,
           :dwMaximumWindowSize, Coordinates

  end

  module API
    extend FFI::Library

    ffi_lib 'kernel32'
    ffi_convention :stdcall
    
    attach_function :set_console_text_attribute, 
                    :SetConsoleTextAttribute,
                    [:pointer, :int],
                    :bool

    attach_function :create_console_screen_buffer,
                    :CreateConsoleScreenBuffer,
                    [:uint, :int, :pointer, :int, :pointer],
                    :pointer

    attach_function :get_console_screen_buffer_info, 
                    :GetConsoleScreenBufferInfo,
                    [:pointer, :pointer], 
                    :bool

  end

  class Console
    include Constants

    def initialize
      @initial_attribute = attribute
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
                   0b01110000 
                   BACKGROUND_COLORS[color]
    end

    def reset
      @attribute = @initial_attribute
    end
    
    def bold
    end

    def faint
    end

    def underline
    end

    def text(str)
    end

  
  end

end
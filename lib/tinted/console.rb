module Tinted

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

  module Console
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
end
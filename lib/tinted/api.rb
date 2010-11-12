module Tinted
  
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

    attach_function :write_console, 
                    :WriteConsoleA,
                    [:pointer, :pointer, :int, :pointer, :pointer], 
                    :bool

  end

end
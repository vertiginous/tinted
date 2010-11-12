module Tinted
  
  class Coordinates < FFI::Struct
    layout :x, :ushort,
           :y, :ushort 
  end

  class SmallRectangle < FFI::Struct
    layout   :left,   :short,
             :top,    :short,
             :right,  :short,
             :bottom, :short
  end
 
  class CharInfo < FFI::Struct
    layout :char, :ushort
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

    attach_function :get_std_handle,
                    :GetStdHandle,
                    [:uint],
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
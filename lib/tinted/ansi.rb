module Tinted
  class ANSIParser

    SGR_CODES = {
               0  => :reset,
               1  => :bold,
               2  => :faint,
               4  => :underline,
               5  => :blink,
               7  => :negative,
               8  => :conceal,
               24 => :no_underline,
               27 => :positive,
               28 => :reveal,
               30 => [:foreground, :black],
               31 => [:foreground, :red],
               32 => [:foreground, :green],
               33 => [:foreground, :yellow],
               34 => [:foreground, :blue],
               35 => [:foreground, :magenta],
               36 => [:foreground, :cyan],
               37 => [:foreground, :white],
               40 => [:background, :black],
               41 => [:background, :red],
               42 => [:background, :green],
               43 => [:background, :yellow],
               44 => [:background, :blue],
               45 => [:background, :magenta],
               46 => [:background, :cyan],
               47 => [:background, :white]  
             }

      ED_CODES = {
                0 => [:clear, :end ],
                1 => [:clear, :beginning ],
                2 => [:clear, :all ],
              }

    attr_accessor :output

    def parse(str, console)
      @output = str.scan(/\e\[(\d*)([mJ])|([^\e]*)/).each do |(code, type, text)|
        escape = case type
        when 'm'
          SGR_CODES[code.to_i]
        when 'J'
          ED_CODES[code.to_i]
        end
        m = text ? [:text, text] : escape
        console.send(*m)
      end
      self
    end

  end
end
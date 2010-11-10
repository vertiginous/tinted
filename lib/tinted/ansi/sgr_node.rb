module Tinted

  module ANSI
    class SGRNode < Treetop::Runtime::SyntaxNode

      CODES = {
             0 => :reset,
             1 => :bold,
             2 => :faint,
             4 => :underline,
             5 => :blink,
             7 => :negative,
             8 => :conceal,
             24 => :underline,
             30 => { :foreground => :black   },
             31 => { :foreground => :red     },
             32 => { :foreground => :green   },
             33 => { :foreground => :yellow  },
             34 => { :foreground => :blue    },
             35 => { :foreground => :magenta },
             36 => { :foreground => :cyan    },
             37 => { :foreground => :white   },
             40 => { :background => :black   },
             41 => { :background => :red     },
             42 => { :background => :green   },
             43 => { :background => :yellow  },
             44 => { :background => :blue    },
             45 => { :background => :magenta },
             46 => { :background => :cyan    },
             47 => { :background => :white   }
           }


       def output
         numbers.elements.map{|e| CODES[e.number.text_value.to_i] }
       end
       
    end
  end

end
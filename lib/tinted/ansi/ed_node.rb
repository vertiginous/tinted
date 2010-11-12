module Tinted  
  module ANSI
    class EDNode < Treetop::Runtime::SyntaxNode

      CODES = {
                0 => { :clear => :end },
                1 => { :clear => :beginning },
                2 => { :clear => :all },
              }

      def output
        CODES[code.text_value]
      end
      
    end
  end
end
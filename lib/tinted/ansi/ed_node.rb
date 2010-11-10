module Tinted  
  module ANSI
    class EDNode < Treetop::Runtime::SyntaxNode

      def output
        code.text_value
      end
      
    end
  end
end
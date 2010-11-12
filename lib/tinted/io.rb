module Tinted

  class IO < IO

    def initialize(fd_std = :stdout)
      fd, handle = Constants::FD_STD_MAP[fd_std]
      super(fd, 'w')

      @console = Console.new(handle)
      @parser  = ANSIParser.new
    end

    def write(*objs)
      objs.each{ |obj| _print_string(obj) }
    end

    def _print_string(obj)
      str = obj.dup.to_s
      @parser.parse(str).output.each do |i| 
        case i
        when Symbol
          @console.send(i)
        when Hash
          @console.send(*i.to_a.flatten)
        end
      end
      @console.text('')
    end

  end


end
module Tinted
  VERSION = '0.0.1'
end

require 'treetop'
require 'ffi'
require 'tinted/ansi'
require 'tinted/ansi/sgr_node'
require 'tinted/ansi/ed_node'
require 'tinted/constants'
require 'tinted/console'
require 'tinted/api'
require 'tinted/io'

$stdout = Tinted::IO.new(:stdout)
require "./checker.cr"
require "./norvig.cr"
require "./utils.cr"

# `Speller` is a system wide spell check program
module Speller
  VERSION = "0.1.0"
  LANG = "data/en.txt"
end

include Speller
include Checker
include Norvig

puts spell_checker(LANG)
test = corrector("mik")
puts known(test)

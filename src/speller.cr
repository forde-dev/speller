require "./checker.cr"
require "./norvig.cr"
require "./utils.cr"

# `Speller` is a system wide spell check program
module Speller
  VERSION = "0.1.0"
  LANG = "data/en.txt"

  include Checker
  include Norvig

  def spell
    errors = spell_checker(LANG)
    if errors
      puts "Errors with the following words:"
      errors.each do |w|
        puts w + ":"
        words = corrector_one(w)
        fixes = known(words)
        fixes.each do |f|
          puts f
        end
      end
    end
  end

end

include Speller

spell

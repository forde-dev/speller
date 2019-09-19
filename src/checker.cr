require "./utils.cr"

# `CheckerTools` are a collection of tools used to check of spelling errors
module CheckerTools

    include WordTools

    # `xsel` converts what ever is highlighted on the computer
    # and converts it into a String
    def xsel
        output = IO::Memory.new
            Process.run("xsel", output: output)
            output.close
        output.to_s
    end

end

# `Checker` is a tool used to find spelling mistakes in a highlighted section
module Checker
    include CheckerTools

    # `spell_checker` takes in a file of all the words in a pedicular langauge
    # and cross-references the words highlighted on a screen with a dictionary.
    # Returns either a Hash map containting an array of spelling errors, or a String
    # that says theres no spelling error
    def spell_checker(lang : String)
        arry = formatter(xsel)
        File.each_line(lang) do |line|
          if arry.includes? line
              arry.delete(line)
          end
        end
        if arry.empty?
          puts "There is no spelling errors"
        else
          puts "spelling_error", arry
          return arry
        end
    end
end

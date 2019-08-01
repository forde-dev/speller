# xsel is a linux package that outputs a string of what is highlighted
def xsel
  output = IO::Memory.new
   Process.run("xsel", output: output)
   output.close
  output.to_s
end

# this formats the string so that its only words made up of letters
def format_string(string : String)
  string = string.downcase.gsub(/[^a-z ]/i, " ")
  return string
end

# this splits every word into an array
def word_arr(string : String)
  string = format_string(string)
  output = string.split(" ")
  output.delete("")
  return output
end

# this cross referrences the array of words with a txt file of all words
def is_spellError(lang : String)
  arry = word_arr(xsel)
  # TODO: research and think of more effiecient ways to compare
  File.each_line(lang) do |line|
    if arry.includes? line
        arry.delete(line)
    end
  end
  if arry.empty?
    return "There is no spelling errors"
  else
    return "Spelling Error", arry
  end
end

en = "dictionary/some_en_words.txt"
puts is_spellError(en)

# def dictionary(words)
#   model = Hash(String, Int32).new
#   words.each do |f|
#     model[f] += 1
#   end
#   return model
# end


# lotsofwords = File.read("../dictionary/holmes.txt")


# puts dictionary(word_arr(lotsofwords))
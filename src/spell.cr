
def xsel
  output = IO::Memory.new
   Process.run("xsel", output: output)
   output.close
  output.to_s
end

def format_string(string)
  string = string.downcase
  string = string.gsub(/[^a-z ]/i, " ")
  return string
end

def word_arr
  string = format_string(xsel)
  output = string.split(" ")
  output.delete("")
  return output
end

def is_spellError
  arry = word_arr
  File.each_line("../dictionary/some_en_words.txt") do |line|
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

puts is_spellError

def words(text)
  text.downcase.scan(/[a-z]+/)
end

def train(features)
  model = Hash.new(1)
  features.each {|f| model[f] += 1 }
  return model
end

NWORDS = train(words(File.read("../dictionary/holmes.txt")))
LETTERS = ("a".."z").to_a.join

def edits1(word)
  n = word.length
  deletion = (0...n).collect {|i| word[0...i]+word[i+1..-1] }
  transposition = (0...n-1).collect {|i| word[0...i]+word[i+1,1]+word[i,1]+word[i+2..-1] }
  alteration = array.new
  n.times {|i| LETTERS.each_byte {|l| alteration << word[0...i]+l.chr+word[i+1..-1] } }
  insertion = array.new
  (n+1).times {|i| LETTERS.each_byte {|l| insertion << word[0...i]+l.chr+word[i..-1] } }
  result = deletion + transposition + alteration + insertion
  result.empty? ? nil : result
end

def known_edits2(word)
  result = array.new
  edits1(word).each {|e1| edits1(e1).each {|e2| result << e2 if NWORDS.has_key?(e2) }}
  result.empty? ? nil : result
end

def known(words)
  result = words.select {|w| NWORDS.has_key?(w) }
  result.empty? ? nil : result
end

def candidates(word)
  return known([word]) || known(edits1(word)) || known_edits2(word) || [word]
end

def correct(word)
  candidates(word)
end

test = gets

puts correct(test)
require "./utils.cr"

module Hasher

    # `hasher` takes in an array of words and appends them to
    # a hash map as keys, the keys values is a count of that key in the 
    # given array
    def hasher(words : Array)
        dict_of_words = {} of String => Float64
        words.each do |word|
            if dict_of_words.keys.includes? word
                dict_of_words[word] += 1.0
            else
                dict_of_words[word] = 1.0
            end

        end
        return dict_of_words
    end

end

# `Norvig` is an algorithm designed by Peter Norvig
# to demonstrate how a spell corrector works
module Norvig
    include Hasher
    include WordTools
    include NumberTools

    # `LETTERS` are all the letters in the english language
    LETTERS = [
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z",
    ]

    # TODO: convert alot of this into pre processing

    # `BIG_BOOK` is a book with alot of english words in it
    BIG_BOOK = "data/big_en_book.txt"
    # `NORVIG_WORDS` is a hash map of all the words in the big book as keys and 
    # how often they have appeared as values
    NORVIG_WORDS = hasher(file_formatter(BIG_BOOK))

    # `probaility` takes in a known word as a string and returns
    # the probility of that word to be used in any piece of text 
    def probability(word : String)
        n = sum_f64(NORVIG_WORDS.values)
        w = NORVIG_WORDS[word]
        output = w / n
        return output
    end

    # `corrector` takes in a miss spelt word as a string and
    # corrects the spelling error of one letter 
    def corrector_one(word : String)
        splits = [] of Tuple(String, String)
        range = (0...word.size).to_a
        range.each do |i|
            tup = {word[..i], word[i..]}
            splits << tup
        end

        deletes = [] of String
        splits.each do |l, r|
            deletes << l + r[1..]
        end

        transposes = [] of String
        splits.each do |l, r|
            if r.size > 1
                transposes << l + r[1] + r[0] + r[2..]
            end
        end

        replaces = [] of String
        splits.each do |l, r|
            LETTERS.each do |c|
                replaces << l + c + r[1..]
            end
        end

        inserts = [] of String
        splits.each do |l, r|
            LETTERS.each do |c|
                inserts << l + c + r
            end
        end
        
        set = deletes + transposes + replaces + inserts
        return set

    end

    def corrector_two(word : String)
        set = [] of String
        corrector = corrector_one(word)
        corrector.each do |w|
            corrector_again = corrector_one(w)
            corrector_again.each do |q|
               set << q 
            end
        end
        return set
    end

    def known(words : Array)
        knowns = [] of String
        words.each do |w|
            if NORVIG_WORDS.keys.includes? w
               knowns << w 
            end
        end
        return knowns
    end
end

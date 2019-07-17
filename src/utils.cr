# `WordTools` is a set of tools for formatting and cleaning strings of words
module WordTools

    # `formatter` is used to format a string of text
    # into an array of words made up of only letters from a-z
    def formatter(s : String)
        s = s.downcase.gsub(/[^a-z ]/i, " ")
        output = s.split(" ")
        output.delete("")
        return output
    end

    # `file_formatter` takes in a file and converts all its text to a string
    # then uses the formatter funtion to convert that string into clean numbers
    def file_formatter(filename : String)
        file_handler = File.read(filename)
        output = formatter(file_handler)
        return output
    end
end

# `NumberTools` is a set of tools for working with numbers such as Ints and Floats
module NumberTools

    # `sum_f64` takes in a list of Floats and adds them all together
    def sum_f64(elements)
        total = 0.0
        elements.each do |value|
          total += value
        end
        total
    end

    # `sum` takes in a list of Ints and adds them all together
    def sum(elements)
        total = 0
        elements.each do |value|
          total += value
        end
        total
    end
end

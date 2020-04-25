class StringCalculator 

    def self.add(input)

        string_parsed = input.tr('^0-9','')

        string_parsed_size = string_parsed.size

        if string_parsed.size == 0
            string_parsed_size = string_parsed.size
            string_parsed = nil
        end
    

     return  {size:string_parsed_size, value:string_parsed }
 
     

    end
end

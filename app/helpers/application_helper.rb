# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def sanitize_fu(html, okTags = 'a href, b, br, p, i, em')
    # no closing tag necessary for these
    soloTags = ["br","hr"]

    # Build hash of allowed tags with allowed attributes
    tags = okTags.downcase().split(',').collect!{ |s| s.split(' ') }
    allowed = Hash.new
    tags.each do |s|
      key = s.shift
      allowed[key] = s
    end

    # Analyze all <> elements
    stack = Array.new
    result = html.gsub( /(<.*?>)/m ) do | element |
      if element =~ /\A<\/(\w+)/ then
        # </tag>
        tag = $1.downcase
        if allowed.include?(tag) && stack.include?(tag) then
          # If allowed and on the stack
          # Then pop down the stack
          top = stack.pop
          out = "</#{top}>"
          until top == tag do
              top = stack.pop
              out << "</#{top}>"
            end
            out
          end
        elsif element =~ /\A<(\w+)\s*\/>/
          # <tag />
          tag = $1.downcase
          if allowed.include?(tag) then
            "<#{tag} />"
          end
        elsif element =~ /\A<(\w+)/ then
          # <tag ...>
          tag = $1.downcase
          if allowed.include?(tag) then
            if ! soloTags.include?(tag) then
              stack.push(tag)
            end
            if allowed[tag].length == 0 then
              # no allowed attributes
              "<#{tag}>"
            else
              # allowed attributes?
              out = "<#{tag}"
              while ( $' =~ /(\w+)=("[^"]+")/ )
                attr = $1.downcase
                valu = $2
                if allowed[tag].include?(attr) then
                  out << " #{attr}=#{valu}"
                end
              end
              out << ">"
            end
          end
        end
      end

      # eat up unmatched leading >
      while result.sub!(/\A([^<]*)>/m) { $1 } do end

      # eat up unmatched trailing <
      while result.sub!(/<([^>]*)\Z/m) { $1 } do end

      # clean up the stack
      if stack.length > 0 then
        result << "</#{stack.reverse.join('></')}>"
      end

      result
    end


    # word_wrap(recept.body, :line_width => 50).split("\n").[0..3].join("\n").to_s
		def truncate_lines(text, lines = 5, end_string = "\n ...")
			txt_lines = text.split("\n")
			txt_lines[0..(lines-1)].join("\n") + (txt_lines.size > lines ? end_string : '')
		end

end

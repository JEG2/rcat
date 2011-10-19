module RCat
  class Display
    def initialize(params)
      @line_numbering_style   = params[:line_numbering_style]
      @squeeze_extra_newlines = params[:squeeze_extra_newlines]
    end
    
    def squeeze_extra_newlines?
      @squeeze_extra_newlines
    end
    
    def number_all_lines?
      @line_numbering_style == :all_lines
    end
    
    def number_significant_lines?
      @line_numbering_style == :significant_lines
    end

    def render(data)
      data.each_with_object(PrinterStatus.new) do |line, status|
        next if squeeze_extra_newlines? and status.squeezable? line
        status.update(line)

        if number_all_lines? or ( number_significant_lines? and
                                  status.significant? )
          print_numbered_line(status.lineno, line)
        else
          print line
        end
        
        status.increment unless number_significant_lines? and
                                status.insignificant?
      end
    end
    
    private
    
    def print_numbered_line(number, line)
      print "%6d\t%s" % [number, line]
    end
  end
end

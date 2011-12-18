module RCat
  class Renderer
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
      data.each_with_object(RendererStatus.new) do |line, status|
        status.update( line, squeeze_extra_newlines?,
                             number_significant_lines? )
        next if squeeze_extra_newlines? and status.extra_newline?

        if number_all_lines? or ( number_significant_lines? and
                                  status.significant? )
          print_labeled_line(status.lineno, line)
        else
          print_unlabeled_line(line)
        end
      end
    end

    private

    def print_labeled_line(label, line)
      print "%6d\t%s" % [label, line]
    end

    def print_unlabeled_line(line)
      print line
    end
  end
end

module RCat
  class RendererStatus
    def initialize
      @lineno       = 0
      @in_blank_run = false
      @significant  = true
    end
      
    attr_reader :lineno
      
    def in_blank_run?
      @in_blank_run
    end
      
    def significant?
      @significant
    end
      
    def insignificant?
      not significant?
    end
      
    def extra_newline?
      in_blank_run? and insignificant?
    end
      
    def update(line, squeeze, only_count_significant)
      @in_blank_run = !significant?
      @significant  = !line.chomp.empty?
      @lineno      += 1 unless (squeeze and extra_newline?) or
                               (only_count_significant and insignificant?)
    end
  end
end

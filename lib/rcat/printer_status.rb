class PrinterStatus
  def initialize(lineno = 1, in_blank_line_run = false)
    @lineno            = lineno
    @in_blank_line_run = in_blank_line_run
  end
      
  attr_reader :lineno
      
  def squeezable?(line)
    insignificant? and blank? line
  end
      
  def update(line)
    @in_blank_line_run = blank? line
  end
      
  def insignificant?
    @in_blank_line_run
  end
      
  def significant?
    not insignificant?
  end
      
  def increment
    @lineno += 1
  end
      
  private
      
  def blank?(line)
    line.chomp.empty?
  end
end

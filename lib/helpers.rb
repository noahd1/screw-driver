helpers do
  def padded(spaces=1)
    spaces.times { puts "" }
    yield
    spaces.times { puts "" }
    :ok
  end
  
  def report(str, params=nil)
    params ? SUITE.failed!(params) : SUITE.passed!
    $stdout.print(str)
    $stdout.flush
    sleep 0.1
    :ok
  end
  
  def before_suite
    SUITE.reset!
    padded do
      puts "Staring to run test suite..."
    end
  end
  
  def after_suite
    padded do
      SUITE.failures.each do |failure|
        padded do
          puts "FAILURE".red
          puts "- #{failure[:name]}: #{failure[:reason]}"
        end
      end
      print "Finished. #{SUITE.test_count} tests. "
      print "#{SUITE.failures.length} failures." unless SUITE.failures.empty?
    end
  end
  
  def exit_suite
    padded do
      $stdout.print "== Spec Server "
      $stdout.flush
      `kill #{$$}`
    end
  end
end
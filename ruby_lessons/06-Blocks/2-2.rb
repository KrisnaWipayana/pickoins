def report_time
  puts "Starting time measurement"
  start_time = Time.now

  result = yield

  puts "Stopping time measurement."
  end_time = Time.now

  elapsed = end_time - start_time
  puts "Elapsed time: #{elapsed}s."

  result 
end

report_time do
  puts "This is a fast block."
  "Return value"
end
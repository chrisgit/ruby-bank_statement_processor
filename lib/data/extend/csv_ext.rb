# Strip spaces in header
CSV::HeaderConverters[:trim_header] = lambda do |header|
  header.strip
end

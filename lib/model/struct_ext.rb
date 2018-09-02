# Hack - add as extension/include on specific structures 
# http://stackoverflow.com/questions/28313102/ruby-serialize-struct-with-json
# https://ruhe.tumblr.com/post/565540643/generate-json-from-ruby-struct
class Struct
  def to_map
    members.each_with_object({}) { |m,h| h[m] = self[m] }
  end

  def to_json(*a)
    to_map.to_json(*a)
  end
end

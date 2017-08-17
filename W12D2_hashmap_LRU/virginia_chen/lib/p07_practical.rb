require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  map = HashMap.new((string.length/2).ceil)
  string.chars.each do |char|
    if map.include?(char)
      map.delete(char)
    else
      map.set(char,true)
    end
  end
  return true if map.count <= 1
  false
end

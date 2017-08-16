class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    arrHash = 0
    self.each_with_index do |el,idx|
      arrHash += el^idx
    end
    arrHash.hash
  end
end

class String
  def hash
    chars = self.chars
    arrHash = 0
    chars.each_with_index do |el,idx|
      arrHash += (el.ord)^idx
    end
    arrHash.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arrHash = 0
    self.each do |key,val|
      arrHash += (key.to_s.ord+2)^(val.ord)
    end
    arrHash.hash
  end
end

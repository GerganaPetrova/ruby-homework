class Integer
  def prime?
    (1...self.abs).inject { |a,b| a*b } % self.abs == self.abs-1
  end

  def prime_divisors
    (2..self.abs).select { |i| self.abs % i == 0 and i.prime? }.sort
  end
end

class Range
  def fizzbuzz
    self.to_a.map do |n|
      if n % 15 == 0
       :fizzbuzz
      elsif n % 3 == 0
       :fizz
      elsif n % 5 == 0
       :buzz
      else
       n
      end
    end
  end
end

class Hash
  def keys_for(value)
    self.to_a.select { |k,v| v == value }.map { |k, v| k }
  end

  def group_values
    Hash[self.values.uniq.map { |value| [value, keys_for(value)] }]
  end 
end

class Array
  def densities
    self.map { |element| count(element) }
  end
end




























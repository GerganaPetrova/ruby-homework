describe "Integer#prime_divisors" do
  it "can partition a simple number" do
    10.prime_divisors.should eq [2, 5]
  end
end

describe "Range#fizzbuzz" do
  it "works with the example in assignment" do
    (1..6).fizzbuzz.should eq [1, 2, :fizz, 4, :buzz, :fizz]
  end
end

describe "Hash#group_values" do
  it "maps each value to an array of keys" do
    {a: 1}.group_values.should eq 1 => [:a]
  end

  it "works with no recurring values" do
    h = {a: 1, b: 2, c: 3, d: 8}
    h.group_values.should eq 1 => [:a], 2 => [:b], 3 => [:c], 8 => [:d]
  end

  it "does something useful" do
    {a: 1, b: 3, c: 2, d: 2, e: 1}.group_values.should eq 1 => [:a, :e], 3 => [:b], 2 => [:c, :d]
  end
end

describe "Array#densities" do
  it "maps each element to the number of occurences in the original array" do
    [:a, :b, :a].densities.should eq [2, 1, 2]
  end

  it "when the array is empty" do
    [].densities.should eq []
  end

  it "when the array is inhomogeneous" do
    [:a, 1, 'a', 1, 'a'].densities.should eq [1,2,2,2,2]
  end
end

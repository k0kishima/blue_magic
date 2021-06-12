class Array
  def same?
    uniq.size == 1
  end

  def mean
    self.sum/self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    sum/(self.length - 1).to_f
  end

  # standard_deviation
  def sd
    Math.sqrt(self.sample_variance)
  end
end

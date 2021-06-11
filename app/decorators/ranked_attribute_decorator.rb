class RankedAttributeDecorator
  ATTRIBUTE_SUFFIX = 'rank'

  def self.bulk_decorate!(objects:, need_to_rank_attribute_name:, evaluation_policy: :smaller_is_better)
    raise ArgumentError, "All objects must be a same class" unless objects.map(&:class).same?

    samples = objects.map { |object| object.try!(need_to_rank_attribute_name) }
    objects.each do |object|
      raise DataNotFound,
            "#{need_to_rank_attribute_name} cannot rank because of data not found." if samples.any?(&:nil?)

      ranked_attribute_name = [need_to_rank_attribute_name, ATTRIBUTE_SUFFIX].join('_')
      object.class.__send__(:attr_accessor, ranked_attribute_name)

      sorted_samples = samples.sort
      sorted_samples = sorted_samples.reverse if evaluation_policy.to_sym == :bigger_is_better
      object.try("#{ranked_attribute_name}=", sorted_samples.index(object.try(need_to_rank_attribute_name)).next)
    end

    objects
  end
end

class Branch
  include ActiveModel::Model
  include ActiveModel::Attributes

  class << self
    def all_stadium_prefecture_ids
      Stadium.pluck(:prefecture_id).uniq
    end

    def all
      all_stadium_prefecture_ids.map { |prefecture_id| new(prefecture_id: prefecture_id) }
    end
  end

  attribute :prefecture_id, :integer
  validates :prefecture_id, presence: true, inclusion: { in: all_stadium_prefecture_ids }

  def prefecture
    Prefecture.find(prefecture_id)
  end

  def name
    prefecture.name.gsub(/(県|府|都)$/, '') + '支部'
  end

  alias_method :id, :prefecture_id
end
class Prefecture < JpPrefecture::Prefecture
  def id
    code
  end
end
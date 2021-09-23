FactoryBot.define do
  factory :article do
    # sequence generate unique identifiers
    sequence(:title) {  |n| "Sample Article #{n} "  }
    content { "Sample Content" }
    sequence(:slug) { |n| "sample-article #{n} " }
  end
end

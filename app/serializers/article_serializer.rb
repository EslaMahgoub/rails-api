class ArticleSerializer
  include JSONAPI::Serializer
  # set_type :articles #change value of default mapping
  attributes :title, :content, :slug
end

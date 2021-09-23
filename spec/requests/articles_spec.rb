require 'rails_helper'

RSpec.describe ArticlesController do
  describe "#index" do
    it "returns a successful response" do
      get '/articles'
      # expect(response.status).to eq(200)
      expect(response).to have_http_status(:ok)
    end

    it "returns a proper json data" do
      article = create(:article)
      get '/articles'
      expect(json_data.length).to eq(1)
      expected = json_data.first
      aggregate_failures do
      expect(expected[:id]).to eq(article.id.to_s)
      expect(expected[:type]).to eq("article")
      expect(expected[:attributes]).to eq(
        title: article.title,
        content: article.content,
        slug: article.slug,
      )

      end
    end

    it "return articles in the proper order" do
      older_article = create(
        :article, created_at: 1.hour.ago)
      recent_article = create(:article)
      get '/articles'
      ids = json_data.map{ |item| item[:id].to_i }
      expect(ids).
      to eq([recent_article.id, older_article.id])
    end

    it "pagination results" do 
      article1, article2, article3 = create_list(:article, 3)
      get '/articles', params: {page: {number:2, size:1} }
      expect(json_data.length).to eq(1) # check that each page is returning only 1 element
      expect(json_data.first[:id]).to eq(article2.id.to_s) # check for the item in the second page to be the second article2
    end

    it "page contains pagination links in the response" do
      article1, article2, article3 = create_list(:article, 3)
      get '/articles', params: {page: {number:2, size:1}}
      expect(json[:links].length).to eq(5)
      expect(json[:links].keys)
      .to contain_exactly(:first, :prev, :next, :last, :self)

    end
  end
end

# article = create(:article)
#       get '/articles'
#       body = JSON.parse(response.body)
#       expect(body).to eq(
#       data: [
#         {
#         id: article.id,
#         type: 'article',
#         attributes: {
#           title: article.title,
#           content: article.content,
#           slug: article.slug,
#           }
#         }
#       ]

#     )
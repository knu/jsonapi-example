require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:article1) { Article.create(title: "title1", content: "content1") }

  describe "GET /api/v1/articles" do
    it "works" do
      get api_v1_articles_path
      expect(response).to have_http_status(200)
      expect(
        JSON.parse(response.body, symbolize_names: true)
      ).to match hash_including(data: [
        { id: Integer, type: "article", attributes: { title: "title1", content: "content1" } }
      ])
    end
  end

  describe "POST /api/v1/articles" do
    it "works" do
      post api_v1_articles_path, params: { title: "titleX", content: "contentX" }, as: :json
      expect(response).to have_http_status(201)
      expect(
        JSON.parse(response.body, symbolize_names: true)
      ).to match hash_including(data: {
        id: Integer, type: "article", attributes: { title: "titleX", content: "contentX" }
      })
    end
  end

  describe "GET /api/v1/articles/:id" do
    it "works" do
      get api_v1_article_path(article1.id)
      expect(response).to have_http_status(200)
      expect(
        JSON.parse(response.body, symbolize_names: true)
      ).to match hash_including(data: {
        id: Integer, type: "article", attributes: { title: "title1", content: "content1" }
      })
    end
  end
end

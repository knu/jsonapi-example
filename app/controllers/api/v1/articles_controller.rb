class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  layout 'api/v1/application'

  def index
    @articles = Article.all.limit(10)
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.create!(article_params)
    render :show, status: :created
  end

  private def article_params
    params[:article].permit(:title, :content)
  end
end

class ArticlesController < ApplicationController
  before_filter :set_article, except: [:new, :create]

  def new
    @organisation = Organisation.find(params[:organisation_id])
    @article = Article.new
    2.times do
      @article.attachments.build
    end
  end

  def create
    @organisation = Organisation.find(params[:organisation_id])
    @article = @organisation.articles.build(article_params)
    @article.user_id = current_user.id
    if @article.save
      create_attachments_tracker(@article, @article.attachments.map(&:id))
      redirect_to organisation_article_path(@organisation,@article), :notice => "Successfully created article"
    else
      render 'new'
    end
  end

  def show
    @article.revert_to(params[:version].to_i) if params[:version]
    @attachments = @article.attachments.find(article_version)
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      create_attachments_tracker(@article, params[:preserved_attachments])
      redirect_to organisation_article_path(@organisation,@article), :notice => "Successfully updated article"
    else
      render 'edit'
    end
  end


  private

  def create_attachments_tracker(article, attachment_ids)
    tracker =  @article.attachment_trackers.find_by version_id: article.version
    if tracker.nil?
      article.attachment_trackers.create(version_id: article.version, attachments: attachment_ids)
    else
     tracker.update_attribute(:attachments, attachment_ids)
    end
  end

  def set_article
    @organisation = Organisation.find(params[:organisation_id])
    @article = @organisation.articles.find(params[:id])
  end

  def article_version
    @article.attachment_trackers.find_by(version_id: @article.version).attachments.map{|x| x.to_i }
  end

  def article_params
    params.require(:article).permit(:title, :body, attachments_attributes: [:image,:_destroy, :id])
  end
end

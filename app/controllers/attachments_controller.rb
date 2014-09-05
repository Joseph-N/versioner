class AttachmentsController < ApplicationController
  def show
    @organisation = Organisation.find(params[:organisation_id])
    @article = @organisation.articles.find(params[:article_id])
    @attachment = @article.attachments.find(params[:id])
    @attachment.revert_to(params[:version].to_i) if params[:version]
  end

  def edit
    @organisation = Organisation.find(params[:organisation_id])
    @article = @organisation.articles.find(params[:article_id])
    @attachment = @article.attachments.find(params[:id])
  end

  def update
    @organisation = Organisation.find(params[:organisation_id])
    @article = @organisation.articles.find(params[:article_id])
    @attachment = @article.attachments.find(params[:id])
    if @attachment.update_attributes(attachment_params)
      redirect_to [@organisation,@article,@attachement]
    else
      render 'edit'
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:image)
  end
end

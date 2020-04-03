class PagesController < InheritedResources::Base
  def permalink
    @page = Page.find_by(permalink: params[:permalink])

    redirect_to root_path if @page.nil?
  end

  private

    def page_params
      params.require(:page).permit(:title, :content, :permalink)
    end

end

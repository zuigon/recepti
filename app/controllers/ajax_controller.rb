class AjaxController < ApplicationController


  def ajax_update
    @recept = Recept.find(params[:id])
    respond_to do |format|
      format.js {
        if @recept.update_attributes(params[:recept])
          flash[:notice] = 'Recept was successfully updated.'
          render :update do |page|
            ## page.replace_html :flash_notice, flash[:notice]
            page.insert_html :after, '#container h1', flash[:notice]
            page.replace_html 'edit_recept_'+@recept.id.to_s, :partial => "recept", :layout => ""
            flash.discard
            page << "alert('Poruka iz _update_ ! !')"
          end
        else
          render :update do |page|
            page << "alert('Poruka iz _update_ ! !')"
          end
        end
      }
    end
  end



end

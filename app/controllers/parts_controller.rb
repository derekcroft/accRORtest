class PartsController < ApplicationController
  def create
    @gadget = Gadget.find(params[:gadget_id])
    @gadget.parts.create({ :name => params[:part_name] })
    flash[:notice] = "The part was successfully added."

    respond_to do |format|
      format.html { redirect_to detail_gadget_path(@gadget) }
    end
  end

  def destroy
    @gadget = Gadget.find(params[:gadget_id])
    @gadget.parts.find(params[:id]).destroy
    flash[:notice] = "The part was successfully deleted."
  
    respond_to do |format|
      format.html { redirect_to detail_gadget_path(@gadget) }
    end
  end
end

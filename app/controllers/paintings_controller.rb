class PaintingsController < ApplicationController

  def new #new_gallery_painting GET    /galleries/:gallery_id/paintings/new
    @gallery = Gallery.find_by(id: params[:gallery_id])
    if @gallery
      @painting = @gallery.paintings.build
    else
      flash[:error] = "Gallery is not found"
      redirect_to galleries_path
    end
  end

  def create # gallery_paintings_path POST   /galleries/:gallery_id/paintings
    @gallery = Gallery.find_by(id: params[:gallery_id])
      @painting = @gallery.paintings.build(painting_params)
      if @painting.save
        redirect_to gallery_path(@gallery), :flash => { :notice => "Painting was successfully added!" }
      else
        render :new
      end
  end

private
  def painting_params
    params.require(:painting).permit(:title, :year, :style, :artist_id)
  end

end
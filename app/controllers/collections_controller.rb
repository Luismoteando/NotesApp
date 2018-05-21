class CollectionsController < ApplicationController
  before_action :find_collection, only: [:show, :edit, :update, :destroy]
  before_action :find_note, only: [:show]

  def index
    @collections = Collection.where(user_id: current_user)
  end

  def show
  end

  def new
    @collection = current_user.collections.build
    @notes = Note.where(user_id: current_user)
  end

  def create
      @collection = current_user.collections.build(collection_params)
      if @collection.save
        redirect_to @collection
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection
    else
      render 'edit'
    end
  end

  def destroy
    @collection.destroy
    redirect_to collections_path
  end

  private

  def find_collection
    @collection = Collection.find(params[:id])

  end

  def find_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :image)
  end

  def collection_params
    params.require(:collection).permit(:title)
  end
end

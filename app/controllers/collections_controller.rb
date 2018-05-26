class CollectionsController < ApplicationController
  before_action :set_collection, except: [:index, :new, :create]
  before_action :set_user, only: :share

  def index
    @notes = Note.where(id: (UserNote.select(:note_id).where(user_id: current_user)))
    @collections = Collection.where(id: (UserCollection.select(:collection_id).where(user_id: current_user)))
  end

  def show
    @notes = Note.where(id: (NoteCollection.select(:note_id).where(collection_id: @collection.id)))
  end

  def new
    @collection = current_user.collections.build
  end

  def create
      @collection = current_user.collections.build(collection_params)
      @collection.users << current_user
      if @collection.save
        redirect_to edit_collection_path(collection_id: @collection.id)
      else
        render 'new'
      end
  end

  def edit
      @notes = Note.where(id: (UserNote.select(:note_id).where(user_id: current_user)))
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection
    else
      render 'edit'
    end
  end

  def fill
    @note = Note.find(params[:note_id])
    @note.collections << @collection
    if @note.save
      redirect_to request.referrer
    end
  end

  def unfill
    @note = Note.find(params[:note_id])
    @note.collections.delete(@collection)
    if @note.save
      redirect_to request.referrer
    end
  end

  def destroy
    @collection.destroy
    redirect_to notes_path
  end

  def index_share
    @users = User.all
    @friends = current_user.friends
  end

  def share
    @collection.users << @user
    @collection.notes.each do |note|
      @user.notes << note
    end
    redirect_to request.referrer
  end

  private

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:title)
  end
end

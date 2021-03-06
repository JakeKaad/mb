class NotesController < ApplicationController
  before_action :require_sign_in
  before_action :ensure_event, only: [:create]
  before_action :set_note, only: [:edit, :update, :destroy]

  def new
    @notable = set_notable
    @note = Note.new
    @event = Event.find params[:event_id]
    authorize! :update, @notable
    respond_to do |format|
      format.js { }
      format.html { not_supported }
    end
  end

  def create
    note = Note.new(note_params)
    @notable = set_notable
    authorize! :update, @notable
    if note.save
      @notable.notes << note
      flash[:notice] = "Note saved."
    else
      flash[:alert] = "Something went wrong, note not saved."
    end
    respond_to do |format|
      format.js { }
      format.html { redirect_to company_event_path(note.event.company, note.event) }
    end
  end

  def edit
    @notable = set_notable
    @event = @note.event
    authorize! :update, @event
    respond_to do |format|
      format.js { }
      format.html { not_supported }
    end
  end

  def update
    @notable = set_notable
    authorize! :update, @note.event
    @note.update(note_params)

    respond_to do |format|
      format.js { }
      format.html { not_supported }
    end
  end

  def destroy
    @note.destroy
    redirect_back(fallback_location: root_path, alert: "Note successfully deleted.")
  end


  private

  def set_note
    @note = Note.find params[:id]
  end

  def note_params
    params.require(:note).permit(:event_id, :message)
  end

  def set_notable
    if params.keys.include? "info_id"
      Info.find params[:info_id]
    elsif params.keys.include? "customer_id"
      Customer.find params[:customer_id]
    end
  end

  def ensure_event
    if params[:note][:event_id].nil?
      flash[:alert] = "No event known. Please report this to Admin."
      redirect_to root_path
    end
  end
end

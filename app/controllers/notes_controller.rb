class NotesController < ApplicationController
  before_action :require_sign_in
  before_action :ensure_event, only: [:create]

  def create

    note = Note.new(note_params)
    notable = set_notable
    authorize! :update, notable.event
    if note.save
      notable.notes << note
      flash[:notice] = "Note saved."
    else
      flash[:alert] = "Something went wrong, note not saved."
    end
    redirect_to company_event_path(note.event.company, note.event)
  end

  def edit

    @notable = set_notable
    @note = Note.find params[:id]
    authorize! :update, @note.event
    respond_to do |format|
      format.js { }
      format.html { redirect_to company_event_path(@notable.event.company, @notable.event), alert: "URL not supported" }
    end
  end

  def update

    @notable = set_notable
    @note = Note.find params[:id]
    authorize! :update, @note.notable.event
    @note.update(note_params)

    respond_to do |format|
      format.js { }
      format.html { redirect_to company_event_path(@notable.event.company, @notable.event), alert: "URL not supported" }
    end
  end


  private

  def note_params
    params.require(:note).permit(:event_id, :message)
  end

  def set_notable
    if params.keys.include? "info_id"
      Info.find params[:info_id]
    end
  end

  def ensure_event
    if params[:note][:event_id].nil?
      flash[:alert] = "No event known. Please report this to Admin."
      redirect_to root_path
    end
  end
end

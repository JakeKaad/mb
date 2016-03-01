class Note < ActiveRecord::Base


    ####################################
    ### Relations
    ####################################

    belongs_to :notable, polymorphic: true
    belongs_to :event

    ####################################
    ### Validations
    ####################################

    validates_presence_of :event_id
    validates_presence_of :message
end

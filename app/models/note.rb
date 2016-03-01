class Note < ActiveRecord::Base


    ####################################
    ### Relations
    ####################################

    belongs_to :notable, polymorphic: true
    belongs_to :event

    ####################################
    ### Validations
    ####################################

end

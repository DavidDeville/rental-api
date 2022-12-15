class Reservation < ApplicationRecord
  belongs_to :listing

  # Cette méthode est appelée après la création d'une réservation
  after_create_commit :create_checkout_checking

  private

  def create_checkout_checking
    # On ajoute une mission "checkout_checkin" uniquement si aucune autre
    # mission de type "last_checkout" n'existe pas à la même date
    if !Mission.find_by(mission_type: :last_checkout, date: end_date)
      @mission = Mission.new
      @mission.listing_id = listing_id
      @mission.mission_type = "checkout_checkin"
      @mission.date = end_date
      @mission.price = 10 * listing.num_rooms
      @mission.save
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :listing

  # Ces méthodes sont appelées après la création d'un booking
  after_create_commit :create_first_checkin, :create_last_checkin


  private

  def create_first_checkin
    # Il faut créer une mission à la date d'arrivée
    @mission = Mission.new
    @booking = Booking.last
    @mission.listing_id = listing_id
    @mission.mission_type = "first_checkin"
    @mission.date = start_date
    @mission.price = 10 * listing.num_rooms
    @mission.save


  end

  def create_last_checkin
    # Et il faut en créer une autre pour la date de fin
    @mission = Mission.new
    @mission.listing_id = listing_id
    @mission.mission_type = "last_checkout"
    @mission.date = end_date
    @mission.price = 5 * listing.num_rooms
    @mission.save
  end
end

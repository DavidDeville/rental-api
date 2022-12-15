class Api::V1::MissionsController < Api::V1::BaseController
  def index
    @missions = Mission.all.order('listing_id ASC, date ASC')

    if @missions
      render json: @missions.to_json({only: [:id, :listing_id, :mission_type, :date, :price]})
    else
      render json: @missions.errors, status: :bad_request
    end
  end
end

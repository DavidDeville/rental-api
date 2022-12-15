class Api::V1::ListingsController < Api::V1::BaseController
  before_action :set_listing, only: [:show, :update, :destroy]

  def index
    @listings = Listing.all

    if @listings
      render json: {status: "SUCCESS", message: "Tous les listings ont bien été récupérés !", data: @listings}, status: 200
    else
      render json: @listings.errors, status: :bad_request
    end
  end

  def create
    @listing = Listing.new(set_listing_params)

    if @listing.save
      render json: @listing
    else
      render json: { error: 'Impossible de créer le listing.' }, status: 400
    end
  end

  def update
    if @listing.update(set_listing_params)
      render json: @listing, status: 200
    else
      render json: { error: 'Impossible de mettre à jour le listing.'}, status: 400
    end
  end

  def destroy
    if @listing.destroy
      render json: { message: "Listing supprimé avec succès !"}, status: 200
    else
      render json: { message: 'Impossible de supprimer le listing' }, status: 400
    end
  end

  def show
    if @listing
      render json: {status: "SUCCESS", message: "Listing bien récupéré !", data: @listing}, status: :ok
    else
      render json: @listing.errors, status: :bad_request
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def set_listing_params
    params.require(:listing).permit(:num_rooms, :listing_id)
  end
end

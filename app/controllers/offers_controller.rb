class OffersController < InheritedResources::Base

  private

    def offer_params
      params.require(:offer).permit(:name, :description, :picture)
    end
end


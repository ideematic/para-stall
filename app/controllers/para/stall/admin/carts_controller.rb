module Para
  module Stall
    module Admin
      class CartsController < ::Para::Admin::CrudResourcesController
        def index
          # Default to only showing paid carts
          params[:q] ||= {}
          params[:q][:payment_paid_at_null] ||= 0

          super

          # Only show filled carts, forget empty ones that just wait to be
          # cleaned up by the rake task
          @resources = @resources.filled
        end

        def shipment_modal
          @shipment = resource.shipment
          render layout: false
        end

        def shipment_email
          @shipment = resource.shipment

          if @shipment.update(shipment_params)
            CustomerMailer.order_shipped_email(resource).deliver
            @shipment.update(shipment_notification_email_sent_at: Time.now)

            render 'shipment_email_sent', layout: false
          else
            flash_message(:error)
            render 'shipment_modal', layout: false
          end
        end

        private

        def shipment_params
          params.require(:shipment).permit(
            :carrier, :tracking_code, :point_of_sale_id
          )
        end
      end
    end
  end
end

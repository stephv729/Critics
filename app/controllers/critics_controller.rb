class CriticsController < ApplicationController
  def create
    critic = Critic.new
    critic.user_id = current_user.id
    critic.title = params[:title]
    critic.body = params[:body]
    critic.criticable_id = params[:id]
    critic.criticable_type = params[:type]
    critic.save
    type = critic.criticable

    if type.is_a?(Game)
      redirect_to game_critics_path(id: type.id, errors: critic.errors.full_messages)
    else
      redirect_to details_company_path(query: "c", id: type.id, errors: critic.errors.full_messages)
    end
  end

  def aprove
    critic = Critic.find(params[:critic_id])
    type = critic.criticable
    title = critic.title
    critic.update(title: "Aproved")
    critic.update(title:)
    if type.is_a?(Game)
      redirect_to game_critics_path(id: type.id)
    else
      redirect_to details_company_path(query: "c", id: type.id)
    end
  end

  def destroy
    @critic = Critic.find(params[:id])
    type = @critic.criticable
    @critic.destroy
    if type.is_a?(Game)
      redirect_to game_critics_path(id: type.id), status: :see_other
    else
      redirect_to details_company_path(query: "c", id: type.id), status: :see_other
    end
  end
end

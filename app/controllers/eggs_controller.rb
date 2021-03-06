class EggsController < ApplicationController
  def show
    @egg = Egg.where(id: 1).first
    inventory = { total: @egg.total }
    render json: inventory
  end

  def update
    @egg = Egg.where(id: 1).first
    @egg.total = @egg.total + params[:input].to_i
    @egg.save
    render json: @egg
  end

  def weather
    forecast = get_json('http://api.wunderground.com/api/ea5d08a7d6566e2b/forecast/q/27701.json')['forecast']['simpleforecast']['forecastday'][0]

    conditions = forecast['conditions']

    sun_times = get_json('http://api.wunderground.com/api/ea5d08a7d6566e2b/astronomy/q/27701.json')['sun_phase']

    sunrise = "#{sun_times['sunrise']['hour']}:#{sun_times['sunrise']['minute']}"
    sunset = "#{sun_times['sunset']['hour']}:#{sun_times['sunset']['minute']}"

    temp = get_json('http://api.wunderground.com/api/ea5d08a7d6566e2b/conditions/q/27701.json')['current_observation']['temperature_string']

    @conditions = {
      'temperature' => temp,
      'conditions' => conditions,
      'sunrise' => sunrise,
      'sunset' => sunset
    }
    render json: @conditions
  end

  def get_json(url)
    HTTParty.get(url).parsed_response
  end

  private

  def egg_params
    params.require(:egg).permit(:total)
  end
end

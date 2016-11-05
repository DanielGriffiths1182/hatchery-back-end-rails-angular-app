class EggsController < ApplicationController
  def create
    @egg = Egg.new(total: params[:input].to_i)
    if @egg.save
      result = { total: @egg.total }
      render json: result
    else
      render json: {}
    end
  end

  def show
    @egg = Egg.where(id: 1).first
    inventory = {}
    inventory[:total] = @egg.total
    render json: inventory
  end

  def update
    if current_user.admin true
      @egg = Egg.where(id: 1).first
      @egg.total = @egg.total + params[:input].to_i
      @egg.save
      edited = {
        total: @egg.total,
        user_eggs: 0
      }
      render json: edited
    else
      @egg.total = @egg.total - params[:input].to_i
      if @egg.user_eggs != Integer
        @egg.user_eggs = params[:input].to_i
        @egg.save
      elsif
        @egg.user_eggs + params[:input].to_i
        @egg.save
      end
      edited = {
        total: @egg.total,
        user_eggs: 0
      }
      render json: edited
    end
  end

  def weather
    conditions = get_conditions
    sunrise = get_sunrise
    sunset = get_sunset
    temp = get_current_temp

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

  def get_conditions
    forecast = get_json('http://api.wunderground.com/api/ea5d08a7d6566e2b/forecast/q/27701.json')['forecast']['simpleforecast']['forecastday'][0]

    conditions = forecast['conditions']
  end

  def get_sunrise
    sun_times = get_json('http://api.wunderground.com/api/ea5d08a7d6566e2b/astronomy/q/27701.json')['sun_phase']

    sunrise_hour = sun_times['sunrise']['hour']
    sunrise_minute = sun_times['sunrise']['minute']
    sunrise = "#{sunrise_hour}:#{sunrise_minute}"
  end

  def get_sunset
    sun_times = get_json('http://api.wunderground.com/api/ea5d08a7d6566e2b/astronomy/q/27701.json')['sun_phase']

    sunset_hour = sun_times['sunset']['hour']
    sunset_minute = sun_times['sunset']['minute']
    sunset = "#{sunset_hour}:#{sunset_minute}"
  end

  def get_current_temp
    temp = get_json('http://api.wunderground.com/api/ea5d08a7d6566e2b/conditions/q/27701.json')['current_observation']['temperature_string']
  end

  private

  def egg_params
    params.require(:egg).permit(:total)
  end
end

class WeatherController < ApplicationController
  def index; end

  def get_weather
    @current_weather = WeatherService.new.by_lat_long(params[:lat], params[:long], "/weather")
    @weather_forcats = WeatherService.new.forecast_report(params[:lat], params[:long], "/forecast")
    respond_to do |format|
      format.js { 
        render json: { 
          content: (render_to_string partial: 'weather_detail', layout: false )  
        } 
      }
    end
  end

  def get_current_weather
    @current_weather = WeatherService.new.by_lat_long(params[:lat], params[:long], "/weather")
    respond_to do |format|
      format.js { 
        render json: { 
          content: (render_to_string partial: 'current_weather_detail', layout: false )  
        } 
      }
    end
  end
end

class CitiesController < ApplicationController
    def search
        redirect_to city_path(name: params[:name])
    end

    def show
        require 'net/http'
        require 'json'

        @city = params[:name.to_s]

        # Current Weather
        @url = "https://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=b3de74108cc43d86835f3312a5074990"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)

        # Current Weather Outputs
        @temp = @output[:main.to_s][:temp.to_s]

        # Forecast Weather
        @forecast_url = "https://api.openweathermap.org/data/2.5/forecast?q=#{@city}&appid=b3de74108cc43d86835f3312a5074990"
        @forecast_uri = URI(@forecast_url)
        @forecast_response = Net::HTTP.get(@forecast_uri)
        @forecast_output = JSON.parse(@forecast_response)

        # Forecast Weather Outputs
        @total = @forecast_output["list"]

        add

        @search = Search.order(id: :desc).limit(3)
    end



    def add
        Search.create(search: params[:name.to_s])
    end

end

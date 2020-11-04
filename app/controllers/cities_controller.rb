class CitiesController < ApplicationController

    before_action :dad_joke

    def search
        redirect_to city_path(name: params[:name])
    end

    def show
        require 'net/http'
        require 'json'

        @city = params[:name.to_s]
        @color = ""

        # Current Weather
        @url = "https://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=b3de74108cc43d86835f3312a5074990"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)

        # Current Weather Outputs
        
        @temp = nil

        if @output["main"] && @output["main"]["temp"]
            @temp = @output["main"]["temp"]
    
            # Forecast Weather
            @forecast_url = "https://api.openweathermap.org/data/2.5/forecast?q=#{@city}&appid=b3de74108cc43d86835f3312a5074990"
            @forecast_uri = URI(@forecast_url)
            @forecast_response = Net::HTTP.get(@forecast_uri)
            @forecast_output = JSON.parse(@forecast_response)

            # Forecast Weather Outputs
            @total = @forecast_output["list"]

            add

        end

        @search = Search.order(id: :desc).limit(3)
    end

    def dad_joke
        # Random Dad Joke Generator
        @dad_joke_url = "https://us-central1-dadsofunny.cloudfunctions.net/DadJokes/random/jokes"
        @dad_joke_uri = URI(@dad_joke_url)
        @dad_joke_response = Net::HTTP.get(@dad_joke_uri)
        @dad_joke_output = JSON.parse(@dad_joke_response)
    end

    def add
        Search.create(search: params[:name.to_s])
    end

end

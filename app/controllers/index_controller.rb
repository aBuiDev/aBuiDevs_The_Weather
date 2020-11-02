class IndexController < ApplicationController

    before_action :show

    def index
        @temp
    end

    def show
        require 'net/http'
        require 'json'

        @city = params[:city.to_s]

        @url = "https://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=b3de74108cc43d86835f3312a5074990"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
        @temp = @output[:main.to_s][:temp.to_s]
    end
end

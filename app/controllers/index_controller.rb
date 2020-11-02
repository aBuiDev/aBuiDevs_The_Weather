class IndexController < ApplicationController
    def index
        require 'net/http'
        require 'json'

        @url = "https://api.openweathermap.org/data/2.5/weather?q=sydney&appid=b3de74108cc43d86835f3312a5074990"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
    end
end

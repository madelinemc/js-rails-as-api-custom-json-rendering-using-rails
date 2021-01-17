class BirdsController < ApplicationController
  def index
    @birds = Bird.all
    render json: @birds
  end

  def show
    bird = Bird.find_by(id: params[:id])
     # RENDER ENTIRE THING: render json: bird
     # sometimes when sending JSON data (such as with an entire model) you do not want or need to send the entire thing
     # use below 3 methods to pick and choose what data to send

     #1. create a hash assigning the keys manually: render json: {id: bird.id, name: bird.name, species: bird.species } 
     
     #2. use built in slice method to return a new hash with only the keys that were passed into the slice: render json: bird.slice(:id, :name, :species) 
     #since slice will only work for a single hash and not an array of hashes, 
     
     #3. use only directly after listing an object that you want to render: render json: birds, only: [:id, :name]
     #alternatively, you can also exclude the keys you do not want to render: render json: birds, except: [:created_at, :updated_at] 
    
    # The only and except keywords are actually parameters of the to_json method, obscured by that magic. 
    # this can be rewritten in full to show what is actually happening: render json: birds.to_json(except: [:created_at, :updated_at])
    if bird
      render json: { id: bird.id, name: bird.name, species: bird.species }
    else
      render json: { message: 'Bird not found' }
    end

  end

ends
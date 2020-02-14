class RootController < ApplicationController
  def index
    @gossips = Gossip.all
    
  end
end

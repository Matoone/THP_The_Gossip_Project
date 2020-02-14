class GossipsController < ApplicationController
  before_action :autolog_user
  before_action :authenticate_user, only: [:create, :show, :edit, :update, :destroy]
  def index
    @gossips = Gossip.all
    
  end
  def show
    @id = params["id"]
    @gossip = Gossip.find(@id)
  end

  def new
    
    @tags = Tag.all.to_a
  end

  def create
  
    title = params["title"]
    content = params["content"]
    tagID = params["tag"]
    user= current_user
    @gossip = Gossip.new(title: title, content: content, user: user)
    if tagID != nil && tagID != ""
      @gossip.tags.push(Tag.find(tagID))
    end
    if @gossip.save
      flash[:notice] = "Votre gossip a bien été sauvegardé."
      redirect_to gossips_path
    else
      @errors = @gossip.errors
      render :new
    end
  end

  def edit
  
    @id = params["id"]
    @tags = Tag.all.to_a
    @gossip = Gossip.find(@id)
  end

  def update
    
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)
    tagID = params["tag"]
    if tagID != nil && tagID != ""
      @gossip.tags.push(Tag.find(tagID))
    end
    if @gossip.update(gossip_params)
      flash[:notice] = "Votre gossip a bien été mis à jour."
      redirect_to gossips_path
    else
      @errors = @gossip.errors
      render :edit
    end
    
  end

  def destroy
    
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:notice] = "Votre gossip a bien été supprimé."
      redirect_to gossips_path
  end


  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Vous devez vous connecter pour avoir accès à cette section."
      redirect_to new_session_path
    end
  end

  def autolog_user
    current_user
  end
end

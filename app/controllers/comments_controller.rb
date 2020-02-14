class CommentsController < ApplicationController
  def new
    if !current_user
      flash[:alert] = "Vous devez vous connecter avant de poster un potin."
      redirect_to new_session_path
    end
    @gossip = Gossip.find(params["gossip_id"])
  end

  def create
    if !current_user
      flash[:alert] = "Vous devez vous connecter avant de poster un potin."
      redirect_to new_session_path
    end
    content = params["content"]
    gossip_id = params["gossip"]["id"]
    user= current_user
    @comment = Comment.new(content: content, author: user, gossip_id: gossip_id)
    
    if @comment.save
      flash[:notice] = "Votre commentaire a bien été sauvegardé."
      redirect_to gossip_path(id: gossip_id)
    else
      @errors = @comment.errors
      @gossip = Gossip.find(gossip_id)
      render :new
    end
  end

  def destroy
    
    @comment= Comment.find(params[:id])
    @gossip = @comment.gossip
    @comment.destroy
    flash[:notice] = "Votre commentaire a bien été supprimé."
      redirect_to gossip_path(id: @gossip.id)

  end

  def edit
    @comment= Comment.find(params[:id])
    @gossip = @comment.gossip
  end

  def update
    comment_params = params.require(:comment).permit(:content)
    @comment = Comment.find(params[:id])
    @gossip = @comment.gossip
    if @comment.update(comment_params)
      flash[:notice] = "Votre commentaire a bien été mis à jour."
      redirect_to gossip_path(id: @gossip.id)
    else
      @errors = @comment.errors
      render :edit
    end
    
  end
end

class LikesController < ApplicationController
  def new
    params_index = false
    city = false
    comment_id = ''
    if params["comment"]
      comment_id = params["comment"]
    end
    if params["index"]
      if params["index"] == "true"
        params_index = true
      else
        city = true
      end
    end
    if comment_id == ''
      @gossip_id = params[:id]
      gossip = Gossip.find(@gossip_id)
      if gossip.likes.any? { |like| like.user == current_user}
        if params_index == false
          if city == false
            redirect_to gossip_path(@gossip_id)
          else
            redirect_to city_path(params["index"])
          end
        else
          redirect_to gossips_path 
        end
        return
      end
      like = Like.new(user: current_user, writable: gossip)
      if like.save
        if params_index == false
          if city == false
            redirect_to gossip_path(@gossip_id)
          else
            redirect_to city_path(params["index"])
          end
        else
          redirect_to gossips_path 
        end
      else
        if params_index == false
          if city == false
            redirect_to gossip_path(@gossip_id)
          else
            redirect_to city_path(params["index"])
          end
        else
          redirect_to gossips_path 
        end
      end
    
    else
      comment_id = params[:id]
      comment = Comment.find(comment_id)
      if comment.likes.any? { |like| like.user == current_user}
        redirect_to gossip_path(comment.gossip.id)
        return
      end
      like = Like.new(user: current_user, writable: comment)
      if like.save
        redirect_to gossip_path(comment.gossip.id)
      else

      end
    end
  end

  def create
   
  end

  def destroy
    params_index = false
    city = false
    comment_id = ''
    if params["comment"]
      comment_id = params["comment"]
    end
    if comment_id == ''
      if params["index"]
        if params["index"] == "true"
          params_index = true
        else
          city = true
        end
      end
      like_to_destroy = Like.find(params[:id])
      gossip_id = like_to_destroy.writable.id
      like_to_destroy.destroy
      if params_index == false
        if city == false
          redirect_to gossip_path(gossip_id)
        else
          redirect_to city_path(params["index"])
        end
      else
        redirect_to gossips_path
      end 
    else
      like_to_destroy = Like.find(params[:id])
      comment_id = like_to_destroy.writable.id
      like_to_destroy.destroy
        redirect_to gossip_path(like_to_destroy.writable.gossip.id)
    end
    
  end
end

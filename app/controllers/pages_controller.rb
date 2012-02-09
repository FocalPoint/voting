class PagesController < ApplicationController

	def index
	  #@questions = Question.all
	  @questions = Question.find(:all, :include => :answers, :order => "answers.updated_at DESC")
	end
	
	def show
	  @q = Question.find_all_by_id(params[:q_id])
  	  @a = Answer.new
  	  @answers = Answer.where("question_id = #{params[:q_id]}")
	end

	def new_answer
  	  #raise params[:q_id].inspect
  	  #session[:u_id] = 1
  	  if session[:uid]
  		#raise params[:q_id].inspect
  		@new_answer = Answer.new(:user_id => session[:uid], :question_id => params[:q_id], :answer => params[:answer])
  		#raise @new_answer.inspect
  		@new_answer.save
  		redirect_to root_url

  	  else
 
  		redirect_to root_url, :notice => "Please login to answer a question. Thanks!"
  	  end
    end

	def login
	  user = User.find_by_email(params[:email])
	  if (user && user.authenticate(params[:password]))
	    session[:uid] = user.id
	    redirect_to profile_url, :notice => "You're all logged in!"
	  else
	    flash[:notice] = "Login again please"
	    render :login
	  end
	end
	
	def logout
	  reset_session
	  redirect_to root_url
	end
	
	def profile
	  @user = User.find(session[:uid])
	  @questions_asked = Question.find_all_by_user_id(session[:uid])
	end
	
	def ask
	  @q = Question.new
	end
	
	def up #for up-voting, will add 1 to the result in the vote table
	  if session[:uid]
	    if AnswerVote.where("user_id = ? AND answer_id = ?", session[:uid], params[:a]).count > 0
	      redirect_to show_url(:q_id => params[:q]), :notice => "You only can vote once per answer."
	    else
	      arr = Answer.find_by_sql ["SELECT answer FROM Answers WHERE id = ? AND user_id = ?", params[:a], session[:uid]]
	      if arr.count > 0
	      	redirect_to show_url(:q_id => params[:q]), :notice => "You can't vote on your own answer. Sorry."
	      else
	      	vote = AnswerVote.new do |v|
	        	v.user_id = session[:uid]
	        	v.answer_id = params[:a]
	        	v.result = 1
	      	end
	      	vote.save
	      	redirect_to show_url(:q_id => params[:q])
	      end
	    end
	  else
	    redirect_to login_url
	  end
	end
	
	def down #for down-voting, will subtract 1 from the result in the vote table
	  if session[:uid]
	    if AnswerVote.where("user_id = ? AND answer_id = ?", session[:uid], params[:a]).count > 0
	      redirect_to show_url(:q_id => params[:q]), :notice => "You only can vote once per answer."
	    else
	      arr = Answer.find_by_sql ["SELECT answer FROM Answers WHERE id = ? AND user_id = ?", params[:a], session[:uid]]
	      #raise arr.count.inspect
	      if arr.count > 0
	        redirect_to show_url(:q_id => params[:q]), :notice => "You can't vote on your own answer. Sorry."
	      else
	      #raise arr.count.inspect
	        vote = AnswerVote.new do |v|
	          v.user_id = session[:uid]
	          v.answer_id = params[:a]
	          v.result = -1
	          v.save
	          redirect_to show_url(:q_id => params[:q])
	        end
	      end
	      #vote.save commented this out and put in block three lines above
	      #redirect_to show_url(:q_id => params[:q])
	    end
	  else
	    redirect_to login_url
	  end
	end
	
	def sent_question
	  #raise params[:question].inspect
	  @question = Question.new(params[:question])
	  respond_to do |format|
      if @question.save
        format.html { redirect_to profile_url, :notice => 'Note: Question was successfully added.' }
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "ask" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end

	end

end
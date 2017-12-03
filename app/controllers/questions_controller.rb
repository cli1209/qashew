class QuestionsController < ApplicationController
  before_action :set_owned_question, only: [:edit, :update, :destroy]

  # helper param for the sort_by() call in index method
  helper_method :sort_param

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(nil) # creates an anonymous scope
    @questions = @questions.term(params[:term]) if params[:term].present?
    @search_term = params[:term] if params[:term].present?
    @questions = @questions.sort_by { |m| m[sort_param] }.reverse if sort_param.present?
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
    # to avoid NIL error
    @answer = Answer.new

  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @question = Question.find(params[:question_id])
    @question.upvote_from current_user
    respond_to do |format|
      format.js
    end
  end

  def downvote
    @question = Question.find(params[:question_id])
    @question.downvote_from current_user
    respond_to do |format|
      format.js
    end
  end

  def undoupvote
    @question = Question.find(params[:question_id])
    @question.unliked_by current_user
    respond_to do |format|
      format.js
    end
  end

  def undodownvote
    @question = Question.find(params[:question_id])
    @question.undisliked_by current_user
    respond_to do |format|
      format.js
    end
  end

  def star
    @question = Question.find(params[:question_id])
    current_user.starred << params[:question_id]
    current_user.save(validate: false)
    respond_to do |format|
      format.js
    end
  end

  def unstar
    @question = Question.find(params[:question_id])
    current_user.starred.delete_if {|x| x==@question.id}
    current_user.save(validate: false)
    respond_to do |format|
      format.js
    end
  end


  def tag_cloud
    @tags = Question.tag_counts_on(:tags)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owned_question
      begin
        @question = current_user.questions.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        logger.info "======================================================"
        logger.info e
        logger.info "======================================================"
        flash[:notice] = "You don't have access to that."
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:headline, :content, :user_id, :tag_list)
    end

    # sanitize the ordering param
    def sort_param
      ["created_at", "cached_weighted_score"].include?(params[:sort]) ? params[:sort] : "cached_weighted_score"
    end
end

class Api::Admin::SystemTermsController < ApplicationController
  before_action :admin?, only: %i[index create destroy]

  def index
    terms = SystemTerm.where(level: params.require(:level), category: params.require(:category))
    render json: { terms: terms_to_json(terms) }, status: :ok
  end

  def create
    term = SystemTerm.new(term_params)
    if term.save
      render json: { term: term_to_json(term) }, status: :created
    elsif term.errors[:term].include?("has already been taken")
      render json: { message: "term taken" }, status: :unprocessable_entity
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    term = SystemTerm.find(params.require(:id))
    if term.destroy
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  private

  def term_params
    params.require(:term).permit(:term, :pronunciation, :definition, :description, :example, :level, :category)
  end

  def terms_to_json(terms)
    terms.map { |term| term_to_json(term) }
  end

  def term_to_json(term)
    {
      id: term.id,
      term: term.term,
      pronunciation: term.pronunciation,
      definition: term.definition,
      description: term.description,
      example: term.example
    }
  end
end

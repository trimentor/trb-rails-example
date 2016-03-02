class Birthday::Show < Trailblazer::Operation
  def process(params)
    @model = Birthday.find_by(person_id: params[:person_id])

    @valid = @model.present? # Birthday::Show.run must return correct result
  end

  def person
    @model.person
  end

  def start_time
    @model.event.start_time
  end
end

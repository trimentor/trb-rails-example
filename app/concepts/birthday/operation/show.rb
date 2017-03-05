class Birthday::Show < Trailblazer::Operation
  step :model!

  def model!(options, params:, **)
    options["model"] = Birthday.find_by(person_id: params[:person_id])
  end
end

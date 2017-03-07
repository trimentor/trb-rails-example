class Birthday::Create < Trailblazer::Operation
  step Model(Birthday, :new)
  step Contract::Build(constant: Birthday::Contract::Create)
  step :find_birthday!
  success :create_event!
  step Contract::Validate()
  step Contract::Persist()

  def find_birthday!(options, params:, **)
    res = Birthday::Show.(person_id: params[:person_id])
    if res.success?
      options["contract.default"].errors.messages[:person_id] = ['can only have one birthday']
      return false
    else
      return true
    end
  end

  def create_event!(options, params:, **)
    options["model"].person_id = params[:person_id]

    res = Event::Create.(name: 'birthday', start_time: params[:start_time])
    if res.success?
      params.merge!(event_id: res["model"].id)
      options["model"].event_id = res["model"].id
    else
      res["contract.default"].errors.messages.map do |k, v|
        options["contract.default"].errors.messages[k] = v
      end
      return false
    end
  end
end

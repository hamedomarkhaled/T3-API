# frozen_string_literal: true

# Module for rendering response in JSON format including object's relationships
module Response
  def json_response(object, status = :ok, include = [])
    render json: object.to_json(include: include), status: status
  end
end

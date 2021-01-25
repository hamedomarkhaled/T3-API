module Response
  def json_response(object, status = :ok, include = [])
    render :json => object.to_json(include: include), status: status
  end
end
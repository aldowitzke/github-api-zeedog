class V1::AuthorizationsController < V1::ApplicationController
  def build_jwt(valid_for_minutes = 5)
    exp = Time.now.to_i + (valid_for_minutes*60)
    payload = { "iss": "aldowitzke",
                "exp": exp
              }

    jwt = JWT.encode payload, ENV['JWT_SECRET'], 'HS256'

    render json: jwt
  end
end
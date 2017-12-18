# Errors handling method for application JSON api (parses errors messages)
export default handle_errors = (response) ->
  if !response.ok
    response.json().then((data) -> throw Error(data.errors))
  else
    return response
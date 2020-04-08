defmodule Shiritori.Auth do
  @salt "/OY+zfYhQYZME+rD8gOShxr++biB0CasqAEOFqRsebM124TiS0TUfU8+FbSi1a1i"

  def authenticate(token) do
    Phoenix.Token.verify(ShiritoriWeb.Endpoint, @salt, token, max_age: 604_800)
  end

  def generate_token(player) do
    Phoenix.Token.sign(ShiritoriWeb.Endpoint, @salt, player)
  end
end

require Logger

defmodule Sample do
  @moduledoc ''
  @base_url 'http://api.openweathermap.org/data/2.5/forecast'
  @api_token '23d9c9d6bc8a52f9c26ce6fe6c251dbf'
  @id 1851100

  def main(args) do
    try do
      response = HTTPotion.get! "#{@base_url}?id=#{@id}&APPID=#{@api_token}"
      {_, data} = response.body |> Poison.decode
      mains = Enum.map(data["list"], fn(value) ->
        List.first(value["weather"])
      end)
      weathers = Enum.map(mains, fn(value) -> value["main"] end)
      weather_types = Enum.uniq weathers
      counts = count_by_weather_type(weather_types, weathers)
      index = max_weather_index counts
      counts = Enum.map(counts, fn count -> count.value end)
      today_weather = Enum.at(weather_types, index)
      IO.puts today_weather
    rescue
      e in HTTPotion.HTTPError -> e
      IO.puts 'X'
    end
  end

  def count_by_weather_type(weather_types, weathers) do
    counts = Enum.map(weather_types, fn type ->
      %{value: Enum.count(weathers, fn value -> value === type end)}
    end)
    counts
  end

  def max_weather_index(counts) do
    index = Enum.find_index(counts, fn value ->
      value === Enum.max(counts)
    end)
    index
  end
end

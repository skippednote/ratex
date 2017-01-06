defmodule Ratex.Get do
  use GenServer

  alias Ratex.Repo
  alias Ratex.Record

  @url Application.get_env(:ratex, Ratex.GetData)[:api_url]
  @key Application.get_env(:ratex, Ratex.GetData)[:api_key]
  @name __MODULE__

  # Public API
  def start_link do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def get do
    GenServer.cast(@name, :count)
  end

  # GenServer API
  def init(state) do
    {:ok, state}
  end

  def handle_cast(:count, state) do
    Repo.delete_all(Record)

    fetch()
    |> Map.get("total_records")
    |> convert_to_offset
    |> get_urls

    {:noreply, state}
  end

  def handle_cast({:get, url}, state) do
    url
    |> fetch
    |> Poison.decode!
    |> Map.get("records")
    |> write_to_db

    {:noreply, state}
  end

  # Helpers
  defp build_url(offset \\ 0) do
    @url <> "&api-key=" <> @key <> "&offset=" <> Integer.to_string(offset)
  end

  defp fetch do
    build_url()
    |> fetch
    |> Poison.decode!
  end
  defp fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, headers: _headers, status_code: 200}} ->
        body
      {:ok, %HTTPoison.Error{reason: reason}} ->
        reason
      _ ->
        IO.inspect "Failed to get data"
        :error
    end
  end

  defp convert_to_offset(records) do
    records
    |> String.to_integer
    |> div(100)
  end

  defp get_urls(offset) do
    0..offset
    |> Enum.each(fn(i) ->
      url = i |> build_url
      GenServer.cast(@name, {:get, url})
    end)
  end

  def write_to_db(records) do
    records
    |> Enum.each(fn(record) ->
      changeset = Record.changeset(%Record{}, record)
      Repo.insert!(changeset)
    end)
  end
end

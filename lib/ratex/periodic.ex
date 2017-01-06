defmodule Ratex.Periodic do
  use GenServer

  alias Ratex.Get

  # Public API
  def start_link do
    GenServer.start_link(__MODULE__, 0, [name: __MODULE__])
  end

  # GenServer
  def init(state) do
    run_job()
    {:ok, state}
  end

  def handle_info(:job, state) do
    run_job()
    {:noreply, state}
  end

  # Helper
  defp run_job do
    Get.get
    Process.send_after(self(), :job, 2 * 60 * 60 * 1000)
  end
end

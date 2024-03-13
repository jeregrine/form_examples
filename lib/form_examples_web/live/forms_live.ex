defmodule FormExamplesWeb.FormsLive do
  use FormExamplesWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(form: to_form(%{"query" => nil}))
      |> assign(form2: to_form(%{"query" => nil}))
    }
  end

  def render(assigns) do
    ~H"""
    <% #<.link to="BLOGPOST" class="underline mb-6 block"> Blogpost explaining this... </.link> %>
    <h1 class="text-2xl font-bold">Form with <code class="font-normal text-lg p-1 font-mono border bg-gray-300 bg-gray-50">phx-change="validate"</code></h1>
    <.simple_form for={@form} phx-change="validate" phx-submit="save" id="form1" class="mb-20">
      <.input field={@form[:query]} label="Search" />
    </.simple_form>

    <h1 class="text-2xl font-bold">Form without <code class="font-normal text-lg p-1 font-mono border bg-gray-300 bg-gray-50">phx-change="validate"</code></h1>
    <.simple_form for={@form2} phx-submit="save" id="form2" class="mb-20">
      <.input field={@form2[:query]} label="Search" />
    </.simple_form>

    <.button phx-click="boom">Crash LiveView</.button>
    """
  end

  def handle_event("validate", %{"query" => q}, socket) do
    {:noreply, assign(socket, form: to_form(%{"query" => q}))}
  end

  def handle_event("save", %{"query" => q}, socket) do
    {:noreply,
      socket
      |> assign(form: to_form(%{"query" => nil}))
      |> assign(form2: to_form(%{"query" => nil}))
      |> put_flash(:info, "Form submitted with query: #{q}")}
  end

  def handle_event("boom", _, socket) do
    raise "boom"
  end
end

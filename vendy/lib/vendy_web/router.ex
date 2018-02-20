defmodule VendyWeb.Router do
  use VendyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug VendyWeb.Plugs.LoadCustomer
    plug VendyWeb.Plugs.FetchCart
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VendyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/categories/:category", CategoryController, :show
    # REGISTRATION
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    # SESSION
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    # CART
    post "/cart", CartController, :add

  end

  # Other scopes may use custom stacks.
  # scope "/api", VendyWeb do
  #   pipe_through :api
  # end
end

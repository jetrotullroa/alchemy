defmodule VendyWeb.Router do
  use VendyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :frontend do
    plug VendyWeb.Plugs.LoadCustomer
    plug VendyWeb.Plugs.FetchCart
  end

  pipeline :authenticate_customer do
    plug VendyWeb.Plugs.AuthenticateCustomer
  end

  # Unauthenticated scope
  scope "/", VendyWeb do
    pipe_through [:browser, :frontend]
    # PRODUCTS
    get "/", PageController, :index
    get "/categories/:category", CategoryController, :show
    # REGISTRATION
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    # SESSION
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    # CART
    post "/cart", CartController, :add
    get "/cart", CartController, :show
    put "/cart", CartController, :update
  end

  # Authenticated scope
  scope "/", VendyWeb do
    pipe_through [:browser, :frontend, :authenticate_customer]
    # SESSION
    get "/logout", SessionController, :delete
    # CHECKOUT
    get "/checkout", CheckoutController, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", VendyWeb do
  #   pipe_through :api
  # end
end

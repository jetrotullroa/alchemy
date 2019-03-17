defmodule VendyWeb.Router do
  use VendyWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :frontend do
    plug(VendyWeb.Plugs.LoadCustomer)
    plug(VendyWeb.Plugs.FetchCart)
    plug(VendyWeb.Plugs.Locale)
  end

  pipeline :authenticate_customer do
    plug(VendyWeb.Plugs.AuthenticateCustomer)
  end

  pipeline :admin do
    plug(VendyWeb.Plugs.AdminLayout)
  end

  # Unauthenticated scope
  scope "/", VendyWeb do
    pipe_through([:browser, :frontend])
    # ADMIN
    resources("/admin/users", Admin.UserController)
    # PRODUCTS
    get("/", PageController, :index)
    get("/categories/:category", CategoryController, :show)
    # REGISTRATION
    get("/register", RegistrationController, :new)
    post("/register", RegistrationController, :create)
    # SESSION
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    # CART
    post("/cart", CartController, :add)
    get("/cart", CartController, :show)
    put("/cart", CartController, :update)
  end

  # Authenticated scope
  scope "/", VendyWeb do
    pipe_through([:browser, :frontend, :authenticate_customer])
    # SESSION
    get("/logout", SessionController, :delete)
    # CHECKOUT
    get("/checkout", CheckoutController, :edit)
    put("/checkout/confirm", CheckoutController, :update)
    # ORDERS
    get("/orders", OrderController, :index)
    get("/orders/:order_id", OrderController, :show)
    # SUPPORT TICKET
    resources("/tickets", TicketController, except: [:edit, :update, :delete])
  end

  scope "/admin", VendyWeb.Admin, as: :admin do
    pipe_through([:browser, :admin])

    resources("/users", UserController)
    get("/login", SessionController, :new)
    post("/sendlink", SessionController, :send_link)
    get("/magiclink", SessionController, :create)
  end

  # Other scopes may use custom stacks.
  # scope "/api", VendyWeb do
  #   pipe_through :api
  # end
end

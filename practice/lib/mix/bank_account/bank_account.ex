defmodule Practice.BankAccount do
  use GenServer

  @moduledoc """
    User should be able to Open an account, deposit, withdraw and
    check balance of same account.
  """

  @doc false
  def start(balance) do
    {:ok, account} = GenServer.start(__MODULE__, balance)
    account
  end

  @doc """
    Deposit an amount to an account.

    ## Parameters
      - account: PID from the BankAccount.start
      - amount: Integer. amount to be deposited to the account.

    ## Examples

        iex> Practice.BankAccount.deposit(Practice.BankAccount.start(0), 100)
        :ok
  """
  def deposit(account, amount) do
    GenServer.cast(account, {:deposit, amount})
  end

  @doc """
    Withdraw an amount to an account.


    ## Parameters
      - account: PID from the BankAccount.start
      - amount: Integer. amount to be withdrawed to the account.

    ## Examples

        iex> Practice.BankAccount.withdraw(Practice.BankAccount.start(0), 100)
        :ok
  """
  def withdraw(account, amount) do
    GenServer.cast(account, {:withdraw, amount})
  end

  @doc """
    Check the balance of an account.


    ## Parameters
      - account: PID from the BankAccount.start

    ## Examples

        iex> Practice.BankAccount.check_balance(Practice.BankAccount.start(100))
        100
  """
  def check_balance(account) do
    GenServer.call(account, :balance)
  end

  # callbacks

  @doc false
  def init(balance) do
    {:ok, balance}
  end

  def handle_cast({:deposit, amount}, balance) do
    {:noreply, balance + amount}
  end

  def handle_cast({:withdraw, amount}, balance) do
    {:noreply, balance - amount}
  end

  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end
end

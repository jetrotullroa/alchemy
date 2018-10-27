defmodule Practice.BankAccountTest do
  use ExUnit.Case
  alias Practice.BankAccount
  doctest BankAccount

  @account2_amount 888
  @amount1 100
  @amount2 25

  setup do
    account1 = BankAccount.start(0)
    account2 = BankAccount.start(@account2_amount)
    {:ok, account1: account1, account2: account2}
  end

  test "Deposit to an account", %{account1: account1, account2: _account2} do
    BankAccount.deposit(account1, @amount1)
    BankAccount.deposit(account1, @amount2)
    assert BankAccount.check_balance(account1) === @amount1 + @amount2
  end

  test "Withdraw to an account", %{account1: _account1, account2: account2} do
    BankAccount.withdraw(account2, @amount2)
    assert BankAccount.check_balance(account2) === @account2_amount - @amount2
  end

  test "Check balance of an account", %{account1: _account1, account2: account2} do
    assert BankAccount.check_balance(account2) === @account2_amount
  end
end

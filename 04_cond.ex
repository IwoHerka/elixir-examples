# 'cond' expression is a generalization of 'if' that allows for multiple
# conditions. General structure is as follows:

cond do
  condition1 -> expression1
  condition2 -> expression2
  ...
  true -> expression3 # Optional, acts as a default
end

# Condition can be any expression that evaluates to a boolean value.
# Expressions are code which is returned by 'cond' if its condition evaluates
# matches.

cond do
  2 + 2 == 5 ->
    "This will not be true"
  2 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
end
# => "But this will"


# Example:
defmodule LoanEligibility do
  def check_eligibility(age, income, credit_score) do
    cond do
      underage?(age) ->
        "Not eligible for a loan"

      low_income?(income) ->
        "Income too low for a loan"

      poor_credit?(credit_score) ->
        "Credit score too low for a loan"

      moderate_income?(income) and good_credit?(credit_score) ->
        "Eligible for a small loan"

      high_income?(income) and excellent_credit?(credit_score) ->
        "Eligible for a large loan"

      true ->
        "Loan application needs further review"
    end
  end

  ...
end

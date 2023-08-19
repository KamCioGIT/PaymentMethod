RegisterCommand("payment_example", function (_, _, _)
    TriggerEvent("PaymentMethod:Open", 500, function (price, method)
        if (method == "Bankmoney") then
            print("Du zahlst mit Karte!")
        elseif (method == "Money") then
            print("Du zahlst Bar!")
        end
    end)
end, false)
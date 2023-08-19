---@class PaymentMethod Klasse
---@field public Price number Der Preis der Zahlungsmethode.
---@field private _Events table Eine Tabelle zur Speicherung von Ereignisrückrufen.
---@field public On fun(self: PaymentMethod, Eventname: string, Callback: fun(...: any)) Fügt einen Callback zu einem Ereignis hinzu.
---@field public Trigger fun(self: PaymentMethod, Eventname: string, ...: any) Löst ein Ereignis aus und ruft die Callbacks dafür auf.
---@field public Open fun(self: PaymentMethod) Öffnet die Zahlungsmethode.
---@field public Close fun(self: PaymentMethod) Schließt die Zahlungsmethode.
---@field private __index PaymentMethod
local PaymentMethod = {}

---@type PaymentMethod|nil
local CurrentPaymentMethod = nil

---@param price number Der Preis der Zahlungsmethode.
---@return PaymentMethod
function PaymentMethod:Create(price)
    local Object ={
        ---@type number Der Preis der Zahlungsmethode.
        Price = price,
        ---@type table Eine Tabelle zur Speicherung von Ereignisrückrufen. 
        _Events = {} 
    }

    ---@param self PaymentMethod Das PaymentMethod-Object
    ---@param Eventname string Der Name des Ereignisses.
    ---@param Callback function Der Callback, der bei der Auslösung des Ereignis aufgerufen wird.
    function Object:On(Eventname, Callback)
        if not Object._Events[Eventname] then
            Object._Events[Eventname] = {}
        end
        table.insert(Object._Events[Eventname], Callback)
    end

    ---@param self PaymentMethod Das PaymentMethod-Object
    ---@param Eventname string Der Name des Ereignisses.
    ---@vararg any Zusätzliche Argumente für die Callbacks.
    function Object:Trigger(Eventname, ...)
        if not Object._Events[Eventname] then return end
        for _, Callback in pairs(Object._Events[Eventname]) do
            Callback(...)
        end
    end

    ---@param self PaymentMethod Das PaymentMethod-Object
    function Object:Open()
        Open('paymentMethod', {
            price = Object.Price
        })

        CurrentPaymentMethod = Object
    end

    ---@param self PaymentMethod Das PaymentMethod-Object
    function Object:Close()
        Close('paymentMethod')
        CurrentPaymentMethod = nil
    end

    setmetatable(Object, self)
    self.__index = self
    return Object
end

RegisterNUICallback("setPaymentMethod", function(data, cb)
    if CurrentPaymentMethod then
        CurrentPaymentMethod:Trigger("selectPaymentMethod", data)
    end
end)

RegisterNUICallback('close', function(data, cb)
    if not data or not data. component then return print('[ERROR] No component specified, unable to close') end

    Close(data.component)
    if CurrentPaymentMethod ~= nil then
        CurrentPaymentMethod:Trigger("close")
    end
end)

RegisterNetEvent("PaymentMethod:Open", function (price, select)
    local Menu = PaymentMethod:Create(price)

    Menu:Open()

    Menu:On("selectPaymentMethod", function (method)
        Menu:Close()
        select(price, method)
    end)
end)



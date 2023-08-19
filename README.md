## PaymentMethod
This script provides the users on your server the feature to decide how they want to pay. This is supported by a nice ui, selfmade in React.
I saw the design on [GVMP](https://gvmp.de), but the code is selfmade.

## Preview
![image](https://github.com/Mirrrrrow/PaymentMethod/assets/95571243/684fe16b-2322-4381-8bfa-8121fa753624)

## Usage
The Backend-Code is open source, and documented. An example usage is provided within the [example file](example.lua).
But here is also an example:
```lua
local price = 500
local function paymentSelected(price, method)
    if (method == 'Bankmoney') then print('Pay with card!') return end
    if (method == 'Money') then print('Pay with cash!') return end
end
TriggerEvent("PaymentMethod:Open", price, paymentSelected)
```

## Contact
My discord tag is mirow, feel free to add me if you have quesions :)

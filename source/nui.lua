---Opens a component
---@param component string
---@param data table
---@return nil
function Open(component, data)
    if not component then return print('[ERROR] No component specified, unable to open') end

    SendNUIMessage({
        action = 'toggle',
        data = {
            component = component,
            data = data or {},
            bool = true
        }
    })
    SetNuiFocus(true, true)
end


---Closes a component
---@param component string
function Close(component)
    if not component then return print('[ERROR] No component specified, unable to close') end

    SendNUIMessage({
        action = 'toggle',
        data = {
            component = component,
            bool = false
        }
    })
    SetNuiFocus(false, false)
end



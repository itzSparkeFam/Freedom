local currentResourceName = GetCurrentResourceName()

--- This will print the table in JSON like format to the console.
---@param tbl any The table to print.
local function debugTable(tbl)
    if not Config?.DebugPrint then return end

    if type(tbl) ~= "table" then
        debugPrint("Invalid input. Expected a table.")
        return
    end

    local function printTableHelper(tbl, indent)
        indent = indent or 0
        local indentStr = string.rep("  ", indent)

        for key, value in pairs(tbl) do
            if type(value) == "table" then
                print(indentStr .. key .. " = {")
                printTableHelper(value, indent + 1)
                print(indentStr .. "}")
            else
                print(indentStr .. key .. " = " .. tostring(value))
            end
        end
    end

    printTableHelper(tbl)
end

function debugPrint(...)
    if not Config?.DebugPrint then return end

    local args = { ... }

    if type(args[1]) == 'table' then
        debugTable(args[1])
        return
    end

    local appendStr = ''
    for _, v in ipairs(args) do
        appendStr = appendStr .. ' ' .. tostring(v or 'nil')
    end

    local msgTemplate = '^3[%s]^0%s'
    local finalMsg = msgTemplate:format(currentResourceName, appendStr)
    print(finalMsg)
end

function Notify(msg, type, duration)
    if not msg then return end

    if not type then type = 'info' end
    if not duration then duration = 3000 end

    lib.notify({
        description = msg,
        duration = duration,
        type = type,
    })
end

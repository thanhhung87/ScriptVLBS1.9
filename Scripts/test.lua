szScriptFolder = system.GetScriptFolder()

szChungLib = szScriptFolder.."\\LIB\\chung.lua"
IncludeFile(szChungLib)
tbListItem = {
    "Cöu ChuyÓn Hoµn Hån ®an",
}
function testFightMode()
    local result = player.IsFightMode()
        echo("Is player in fight mode = " .. tostring(result))
end
function testActiveState()
    for i=1,500 do
        if player.IsActiveState(i) == 1 then
            echo("Player active state " .. i .. " is ON")
        end
    end
end
function GetAllItemName()
    local nIndex, nPlace, nXLocDo, nYLocDo = item.GetFirst()
    local file = io.open (gl_ScriptFolder .. "\\item.txt", "w+")
    while nIndex ~= 0 do
        if nPlace == 3 then
            local szName = item.GetName(nIndex)
            file:write(szName .. '\n')
        end
        nIndex, nPlace, nXLocDo, nYLocDo = item.GetNext()
    end
    file:close()
end
function UseItemByList()
    local nIndex, nPlace, nXLocDo, nYLocDo = item.GetFirst()
    while nIndex ~= 0 do
        local szName = item.GetName(nIndex)
        if nPlace == 3 then
            for _, szItem in pairs(tbListItem) do
                if szName == szItem then
                    echo("Using item: " .. szName)
                    item.Use(nIndex, nPlace, nXLocDo, nYLocDo)
                    return 1
                end
            end
        end
        nIndex, nPlace, nXLocDo, nYLocDo = item.GetNext()
    end
    return 0
end
function main()
    echo("Test script started.")
    -- for i = 1,255 do
    --     testActiveState()
    --     echo("Counting: " .. i)
    --     timer.Sleep(500)
    -- end
    UseItemByList()
end
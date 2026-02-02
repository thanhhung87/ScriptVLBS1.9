szScriptFolder = system.GetScriptFolder()

szChungLib = szScriptFolder.."\\LIB\\chung.lua"

IncludeFile(szChungLib)
Item = Item or {}
tbSkillState = {
   -- {nId = 440, szName = "Tiªn Th¶o Lé "},
   -- {nId = 441, szName = "Thiªn s¬n  B¶o Lé"},
    --{nId = 442, szName = "B¸ch Qu¶ Lé"},
    --{nId = 1215, szName = "Th­ T×nh Mói MÝt"},
}
tbListItem = {
    "N»m Th¼ng Lé Bao",
    "Cöu ChuyÓn Hoµn Hån ®an",    
}
tbListItem_Sell = {
    "S¸t Thñ lÖnh",
    "Phï Dung Nguyªn Th¹ch",
    "Khæng T­íc Nguyªn Th¹ch",
    "MËt ®å thÇn bÝ ",
    "Truy c«ng lÖnh",
    "T©m T©m T­¬ng ¸nh phï ",
    "HuyÒn Tinh Kho¸ng Th¹ch ",
    "Chu Sa Nguyªn Kho¸ng",
    "Phi Phong",
    "Hoa hång",
    "Phï Dung Nguyªn Th¹ch ",
    "Khæng T­íc Nguyªn Th¹ch",
    "MËt Ng©n Nguyªn Kho¸ng",
    "Chu Sa Nguyªn Kho¸ng",
    "HuyÒn ThiÕt Nguyªn Kho¸ng",
}
function Item:UseByIndex(nIndex)
    local nItemIndex, nPlace, nX, nY = item.GetFirst()
    while nItemIndex ~= 0 do
        if nPlace == 3 and nItemIndex == nIndex then
            echo("Using item index: " .. nItemIndex)        
            item.Use(nItemIndex, nPlace, nX, nY)
            return 1
        end
        nItemIndex, nPlace, nX, nY = item.GetNext()
    end
    return 0
end
function Item:UseByName(szName)
    local nItemIndex, nPlace, nX, nY = item.GetFirst()
    while nItemIndex ~= 0 do
        local szItemName = item.GetName(nItemIndex)
        if nPlace == 3 and szItemName == szName then
            echo("Using item: " .. szItemName)        
            item.Use(nItemIndex, nPlace, nX, nY)
            return 1
        end
        nItemIndex, nPlace, nX, nY = item.GetNext()
    end
    return 0
    
end
function Item:UseByState()
   
    for _, tbState in pairs(tbSkillState) do
        if player.IsActiveState(tbState.nId) ~= 1 then
            echo("Using item to activate state: " .. tbState.szName)
            --self:UseByName(tbState.szName)
        else
            echo("State already active: " .. tbState.szName)
        end
    end
end
function Item:UseByList()
    for _, szItem in pairs(tbListItem) do
        if self:UseByName(szItem) == 1 then
            return 1
        end
    end
    return 0
end
function Item:SellByList()
    for _, szItem in pairs(tbListItem_Sell) do
        local nItemIndex, nPlace, nX, nY = item.GetFirst()
        while nItemIndex ~= 0 do
            local szItemName = item.GetName(nItemIndex)
            if nPlace == 3 and szItemName == szItem then
                echo("Selling item: " .. szItemName)        
                ShopItem(nItemIndex)
            end
            nItemIndex, nPlace, nX, nY = item.GetNext()
        end
    end
    return 0
    
end
function Item:GetItemUniqueID(nIndex)
    if not nIndex or nIndex == 0 then return nil end

    local nGenre, nDetail, nParticular = item.GetKey(nIndex)
    local nLevel = item.GetLevel(nIndex)
    local nSeries = item.GetSeries(nIndex)
    
    -- Kh?i t?o chu?i g?c v?i thông tin c? b?n
    local szRawData = string.format("%d_%d_%d_L%d_S%d", nGenre, nDetail, nParticular, nLevel, nSeries)
    
    -- L?y thông tin 6 dòng magic
    for i = 0, 5 do
        local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
        if nMagicType > 0 then
            szRawData = szRawData .. string.format("_M%dV%d", nMagicType, nValue)
        end
    end
    
    return szRawData
end

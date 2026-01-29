szScriptFolder = system.GetScriptFolder()
szItemLib = szScriptFolder.."\\LIB\\Item.lua"
IncludeFile(szItemLib)
szLocItemLib = szScriptFolder.."\\LIB\\LocItem.lua"
IncludeFile(szLocItemLib)
szVk = szScriptFolder.."\\LIB\\setdo\\vukhi.lua"
IncludeFile(szVk)
szNon = szScriptFolder.."\\LIB\\setdo\\non.lua"
IncludeFile(szNon)
szNgocBoi = szScriptFolder.."\\LIB\\setdo\\ngocboi.lua"
IncludeFile(szNgocBoi)
szAo = szScriptFolder.."\\LIB\\setdo\\ao.lua"
IncludeFile(szAo)
szGiay = szScriptFolder.."\\LIB\\setdo\\giay.lua"
IncludeFile(szGiay)
szNhan = szScriptFolder.."\\LIB\\setdo\\nhan.lua"
IncludeFile(szNhan)
szDaiLung = szScriptFolder.."\\LIB\\setdo\\dailung.lua"
IncludeFile(szDaiLung)
szBaoTay = szScriptFolder.."\\LIB\\setdo\\baotay.lua"
IncludeFile(szBaoTay)
szDayChuyen = szScriptFolder.."\\LIB\\setdo\\daychuyen.lua"
IncludeFile(szDayChuyen)

resetMenuDialog()
TB_Map = {1,11,78,162,37,80,176,53,20,99,100,101,121,153,174}
-- Tao lookup table de tra cuu nhanh O(1)
TB_Map_Set = {}
for _, mapID in ipairs(TB_Map) do
    TB_Map_Set[mapID] = true
end
local nCheckLimit = 0
local nCountSell = 0
function ban_do()
    while true do
        local nCurMapID = map.GetID()
        -- Kiem tra xem co o trong map trong danh sach khong (O(1))
        if player.IsFightMode() == 0 or TB_Map_Set[nCurMapID] then
            echo("Dang ban do lan: "..nCountSell)
            LocDoTheoType()
            if nCheckLimit == 0 then
                if Item:UseByList() == 1 then
                    nCheckLimit = 1
                end
            end
            if nCountSell < 5 then 
                timer.Sleep(200)
            else
                timer.Sleep(3000)
            end
            nCountSell = nCountSell + 1
        else
            timer.Sleep(200)
            if nCountSell ~= 0 then
                nCountSell = 0
            end
            if nCheckLimit ~= 0 then
                nCheckLimit = 0
            end
        end
        
    end
end

function main()
    ban_do()
end
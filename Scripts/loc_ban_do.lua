szScriptFolder = system.GetScriptFolder()
szItemLib = szScriptFolder.."\\LIB\\Item.lua"
IncludeFile(szItemLib)
szLocItemLib = szScriptFolder.."\\LIB\\LocItem.lua"
IncludeFile(szLocItemLib)
szVk = szScriptFolder.."\\LIB\\ByType\\vukhi.lua"
IncludeFile(szVk)
szNhan = szScriptFolder.."\\LIB\\ByType\\nhan.lua"
IncludeFile(szNhan)

zSetKim = szScriptFolder.."\\LIB\\BySets\\SetKim.lua"
IncludeFile(zSetKim)
zSetMoc = szScriptFolder.."\\LIB\\BySets\\SetMoc.lua"
IncludeFile(zSetMoc)
zSetThuy = szScriptFolder.."\\LIB\\BySets\\SetThuy.lua"
IncludeFile(zSetThuy)
zSetHoa = szScriptFolder.."\\LIB\\BySets\\SetHoa.lua"
IncludeFile(zSetHoa)
zSetTho = szScriptFolder.."\\LIB\\BySets\\SetTho.lua"
IncludeFile(zSetTho)


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
                --Item:UseByList()
                Item:SellByList()
                nCheckLimit = 1
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
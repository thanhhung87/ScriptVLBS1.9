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

resetMenuDialog()
TB_Map = {1,11,78,162,37,80,176,53,20,99,100,101,121,153,174}
-- Tao lookup table de tra cuu nhanh O(1)
TB_Map_Set = {}
for _, mapID in ipairs(TB_Map) do
    TB_Map_Set[mapID] = true
end

function ban_do()
    local nCurMapID = map.GetID()
    -- Kiem tra xem co o trong map trong danh sach khong (O(1))
    if TB_Map_Set[nCurMapID] then
		--LocDoXongBan()
        LocDoTheoType()
        return true -- Dang o trong map hop le
	end
    return false -- Khong o trong map hop le
end
nCheckLimit = 0
function main()

	while true do
		local isInValidMap = ban_do()
        -- Tang delay khi dang o trong map da xu ly de tiet kiem tai nguyen
        if isInValidMap then
			echo("Dang xu ly ban do hop le.")
            timer.Sleep(2000) -- 2s khi da xu ly xong map
            if nCheckLimit == 0 then
                if Item:UseByList() == 1 then
                    nCheckLimit = 1
                end
            end
        else
            timer.Sleep(3000) -- 3s khi dang tim map moi
            Item:UseByState()
            if nCheckLimit == 1 then
                nCheckLimit = 0
            end
        end
	end
end
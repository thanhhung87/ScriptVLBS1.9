szScriptFolder = system.GetScriptFolder()

szChungLib = szScriptFolder.."\\LIB\\chung.lua"
IncludeFile(szChungLib)

-- Include config file
szConfig = szScriptFolder.."\\00_config.lua"
IncludeFile(szConfig)
resetMenuDialog()

function LocDoXongBan()
	if gl_GuiDo == false then
		nVip = 0
		nVipOld = 0
	end
	
	if gl_InternetDelay == nil or gl_InternetDelay < gl_InternetDelayCatch then
		gl_InternetDelay = gl_InternetDelayCatch
	end
	
	if gl_InternetDelay > 3000 then
		gl_InternetDelay = 3000
	end
	
	timer.Sleep(gl_InternetDelay)

    -- Buoc 1: Phan loai item - luu do VIP vao bang tam
    local tbVipItems = {} -- Bang luu thong tin do VIP
    local nIndex, nPlace, nXLocDo, nYLocDo = item.GetFirst()
    
    while nIndex ~= 0 do
        local nGenre = item.GetKey(nIndex)
        if nPlace == 3 and nGenre == 0 then
            local bFlag = 0
            local nDoVip = 0
            if gl_LocDoTheoSet == 1 then
                for k1, v1 in pairs(tbSetDo) do
                    bFlag = 0
                    for i = 0, 5 do
                        local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
                        if 600 >= nValue and v1[nMagicType] ~= nil and nValue >= v1[nMagicType] then
                            bFlag = bFlag + 1
                        end
                    end
                    if bFlag == tablelength(v1) then
                        nDoVip = 1
                    end
                end
            else
                for i = 0, 5 do
                    local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
                    if 600 >= nValue and tbThuocTinh[nMagicType] ~= nil and nValue >= tbThuocTinh[nMagicType] then
                        bFlag = bFlag + 1
                    end
                end
                if bFlag < gl_SoDongVip then
                    nDoVip = 1
                end
            end
            if nDoVip == 0 then
               -- Ban do rac ngay
               ShopItem(nIndex)
            else
                -- Luu thong tin do VIP vao bang tam
                table.insert(tbVipItems, {
                    nIndex = nIndex,
                    nX = nXLocDo,
                    nY = nYLocDo
                })
                nVip = nVip + 1
            end
			itemFiltered = itemFiltered + 1
        end
        nIndex, nPlace, nXLocDo, nYLocDo = item.GetNext()
    end
end
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
		LocDoXongBan()
        return true -- Dang o trong map hop le
    else
        return false -- Khong o trong map hop le
    end
end

function main()
	while true do
		local isInValidMap = ban_do()
        -- Tang delay khi dang o trong map da xu ly de tiet kiem tai nguyen
        if isInValidMap then
			echo("Dang xu ly ban do hop le.")
            timer.Sleep(1000) -- 5s khi da xu ly xong map
        else
            timer.Sleep(3000) -- 1s khi dang tim map moi
        end
	end
end
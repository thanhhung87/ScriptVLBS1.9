szScriptFolder = system.GetScriptFolder()

szChungLib = szScriptFolder.."\\LIB\\chung.lua"
IncludeFile(szChungLib)

-- Include config file
szConfig = szScriptFolder.."\\00_config.lua"
IncludeFile(szConfig)
resetMenuDialog()

freeCellCatch = 47

-- Dung vat pham theo ten trong Hanhtrang -- Edit lai
tbVulanLib.UseItemName = function(szItemName)
	local nItemIndex, nPlace, nX, nY = item.GetFirst()	
	while nItemIndex ~= 0 do
		if nPlace == 3 and item.GetName(nItemIndex) == szItemName then
			item.Use(nItemIndex, nPlace, nX, nY)
			return 1
		end
		nItemIndex, nPlace, nX, nY = item.GetNext()
	end
	return 0
end

----------------------------------------------------------------------------------------
-- Ham them set do
function ThemSetDo(setDo)
	local index = tablelength(tbSetDo)
	tbSetDo[index] = setDo
end
----------------------------------------------------------------------------------------
-- Ham them set do theo kieu (su dung tbType de chi dinh loai do)
-- Vi du: ThemSetDoByType({itemType = tbType.VuKhi.Kiem, [137] = 8, [85] = 200})
-- Hoac: ThemSetDoByType({itemType = tbType.VuKhi, [137] = 8}) -- Loc tat ca vu khi
-- Luu vao tbSetDoByType rieng biet
function ThemSetDoByType(setConfig)
	if setConfig.itemType == nil then
		echo("Loi: ThemSetDoByType can phai co itemType!")
		return
	end
	
	-- Kiem tra xem itemType la mot loai cu the hay mot nhom
	local itemType = setConfig.itemType
	
	-- Neu itemType co nGenre => la loai cu the (VD: VuKhi.Dao)
	-- Neu khong co nGenre => la nhom (VD: VuKhi)
	if itemType.nGenre ~= nil then
		-- Loai cu the - chi dinh nDetail va nParticular
		local newSet = {
			nDetail = itemType.nDetail,
			nParticular = itemType.nParticular,
		}
		
		-- Copy tat ca cac thuoc tinh magic tu setConfig (tru itemType)
		for k, v in pairs(setConfig) do
			if k ~= "itemType" then
				newSet[k] = v
			end
		end
		
		-- Them vao tbSetDoByType
		if tbSetDoByType == nil then
			tbSetDoByType = {}
		end
		local index = tablelength(tbSetDoByType)
		tbSetDoByType[index] = newSet
	else
		-- Nhom (VD: VuKhi) - them set cho tat ca cac loai trong nhom
		-- Thu thap tat ca cac gia tri nDetail khac nhau
		local tbDetailSet = {} -- Luu cac nDetail duy nhat
		for subTypeName, subType in pairs(itemType) do
			if subType.nDetail ~= nil then
				tbDetailSet[subType.nDetail] = true
			end
		end
		
		-- Tao mot set cho moi nDetail khac nhau
		if tbSetDoByType == nil then
			tbSetDoByType = {}
		end
		
		for nDetail, _ in pairs(tbDetailSet) do
			-- Tao set voi chi nDetail, khong co nParticular
			local newSet = {
				nDetail = nDetail,
				-- Khong co nParticular => loc tat ca loai trong nhom co cung nDetail
			}
			
			-- Copy tat ca cac thuoc tinh magic tu setConfig (tru itemType)
			for k, v in pairs(setConfig) do
				if k ~= "itemType" then
					newSet[k] = v
				end
			end
			
			-- Them vao tbSetDoByType
			local index = tablelength(tbSetDoByType)
			tbSetDoByType[index] = newSet
		end
	end
end

-- Ham loc do theo cac loai da dinh nghia trong tbSetDoByType
-- Tu dong loc tat ca cac loai do da duoc them qua ThemSetDoByType
function LocDoTheoType()
	if tbSetDoByType == nil or tablelength(tbSetDoByType) == 0 then
		echo("Chua co set nao trong tbSetDoByType!")
		return
	end
	
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
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szItemName = item.GetName(nIndex)
        
        -- Kiem tra xem item co match voi bat ky set nao trong tbSetDoByType khong
        local isMatchAnyType = false
        if nPlace == 3 and nGenre == 0 and IsHoangKimItem(nIndex) == false then
           echo("Dang kiem tra item: " .. szItemName .. " (Genre=" .. nGenre .. ", Detail=" .. nDetail .. ", Particular=" .. nParticular .. ")")
            for _, setDo in pairs(tbSetDoByType) do
                -- Kiem tra xem set co chi dinh nDetail khong
                if setDo.nDetail ~= nil then
                    -- Neu chi dinh nDetail, phai khop nDetail
                    if setDo.nDetail == nDetail then
                        -- Kiem tra nParticular
                        if setDo.nParticular ~= nil then
                            -- Neu chi dinh nParticular, phai khop chinh xac
                            if setDo.nParticular == nParticular then
                                isMatchAnyType = true
                               --echo("Match type: Genre=" .. nGenre .. ", Detail=" .. nDetail .. ", Particular=" .. nParticular)
                                break
                            end
                        else
                            -- Khong chi dinh nParticular => loc tat ca loai trong nhom nay
                            isMatchAnyType = true
                            -- echo("Match type: Genre=" .. nGenre .. ", Detail=" .. nDetail .. ", Particular=any")
                            break
                        end
                    end
                end
            end
        end
        
        -- Xu ly item
        if nPlace == 3 and nGenre == 0 and IsHoangKimItem(nIndex) == false then
            if isMatchAnyType == false then
                -- Item khong match bat ky type nao => ban luon
                ShopItem(nIndex)
                echo("Item khong thuoc loai can loc, ban do rac: " .. szItemName)
                itemFiltered = itemFiltered + 1
            else
                -- Item match type => kiem tra dieu kien VIP
                local bFlag = 0
                local nDoVip = 0
                if gl_LocDoTheoSet == 1 then
                    -- Su dung tbSetDoByType
                    for k1, v1 in pairs(tbSetDoByType) do
                        -- Kiem tra loai item co khop voi set
                        local matchWeaponType = true
                        if v1.nDetail ~= nil and v1.nDetail ~= nDetail then
                            matchWeaponType = false
                        end
                        if v1.nParticular ~= nil and v1.nParticular ~= nParticular then
                            matchWeaponType = false
                        end
                        
                        if matchWeaponType then
                            bFlag = 0
                            for i = 0, 5 do
                                local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
                                if 600 >= nValue and v1[nMagicType] ~= nil and nValue >= v1[nMagicType] then
                                    bFlag = bFlag + 1
                                end
                            end
                            -- Dem so luong thuoc tinh (khong tinh nDetail va nParticular)
                            local attrCount = 0
                            for k, v in pairs(v1) do
                                if k ~= "nDetail" and k ~= "nParticular" then
                                    attrCount = attrCount + 1
                                end
                            end
                            if bFlag == attrCount then
                                nDoVip = 1
                                break  -- Da tim thay set match, khong can kiem tra tiep
                            end
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
                   echo("Item khong phai VIP, ban do rac ngay. Index: " .. nIndex)
                else
                    -- Luu thong tin do VIP vao bang tam
                    table.insert(tbVipItems, {
                        nIndex = nIndex,
                        nX = nXLocDo,
                        nY = nYLocDo
                    })
                    nVip = nVip + 1
                    echo("Tim duoc item VIP: " .. szItemName .. " (Index: " .. nIndex .. ")")
                end
                itemFiltered = itemFiltered + 1
            end
        end
        nIndex, nPlace, nXLocDo, nYLocDo = item.GetNext()
    end
    
    echo("Da loc xong " .. itemFiltered .. " item, tim duoc " .. nVip .. " VIP")
end

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
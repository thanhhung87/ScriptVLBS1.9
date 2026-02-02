szScriptFolder = system.GetScriptFolder()

szChungLib = szScriptFolder.."\\LIB\\chung.lua"
IncludeFile(szChungLib)

-- Include config file
szConfig = szScriptFolder.."\\LIB\\00_config.lua"
IncludeFile(szConfig)
resetMenuDialog()

freeCellCatch = 47
nCountItemVip = 0
itemFiltered = 0
-- Bang mo ta cac loai vat pham dua vao ItemGenre, DetailType, ParticularType
tbType = {
	-- Vu khi can chien (meleeweapon.txt) - ItemGenre=0, DetailType=0
	VuKhi= {
		Kiem = {nGenre = 0, nDetail = 0, nParticular = 0},     -- Kiem (ThietTruy thu, Cang Kiem, ...)
		Dao = {nGenre = 0, nDetail = 0, nParticular = 1},      -- Dao (Yeu Dao, Don Dao, ...)
		Con = {nGenre = 0, nDetail = 0, nParticular = 2},      -- Con (Thieu Hoa Con, Te Mi Con, ...)
		Thuong = {nGenre = 0, nDetail = 0, nParticular = 3},   -- Thuong (Thiet Thuong, Truong Thuong, ...)
		Chuy = {nGenre = 0, nDetail = 0, nParticular = 4},     -- Chuy (Toan Dau chuy, Bat Lang chuy, ...)
		SongDao = {nGenre = 0, nDetail = 0, nParticular = 5},  -- Song dao (Nga Mi Thich, Tan Thiet Song Dao, ...)
		Quyen = {nGenre = 0, nDetail = 0, nParticular = 6},
		PhiTieu = {nGenre = 0, nDetail = 1, nParticular = 0},  -- Phi tieu (Kim Tien tieu, Yen tu Tieu, ...)
		PhiDao = {nGenre = 0, nDetail = 1, nParticular = 1},   -- Phi dao (Cang Phi Dao, Luu Diep Dao, ...)
		TuTien = {nGenre = 0, nDetail = 1, nParticular = 2},    -- Am khi/Co quan (To Tien, Nu, Cham, ...)-- Quyen/Trien Thu (Pho thong Trien Thu, ...)
	},
	-- Ao giap (armor.txt) - ItemGenre=0, DetailType=2
	Ao = {
		TatCa = {nGenre = 0, nDetail = 2},  -- Dinh nghia chung cho tat ca ao
        Nam = {nGenre = 0, nDetail = 2, nParticular = {0, 1,2,3,4,5,6,14,15,16,17,18,19,20}},  -- Ao giap nam
        Nu = {nGenre = 0, nDetail = 2, nParticular = {7, 8,9,10,11,12,13,21,22,23,24,25,26,27,28}},   -- Ao giap nu
	},
	-- Nhan (ring.txt) - ItemGenre=0, DetailType=3
	Nhan = {
		TatCa = {nGenre = 0, nDetail = 3},    -- Tat ca nhan (Hoang Ngoc Gioi Chi, Cam Lam Thach, ...)
	},
    -- Day chuyen (amulet.txt) - ItemGenre=0, DetailType=4
    DayChuyen = {
		TatCa = {nGenre = 0, nDetail = 4},  -- Dinh nghia chung cho tat ca ngoc boi/day chuyen
        Nam = {nGenre = 0, nDetail = 4, nParticular = 1},  -- Day chuyen nam
        Nu = {nGenre = 0, nDetail = 4, nParticular = 0},   -- Day chuyen nu
	},
    -- Giay (boot.txt) - ItemGenre=0, DetailType=5
	Giay = {
		TatCa = {nGenre = 0, nDetail = 5},  -- Dinh nghia chung cho tat ca giay
        Nam = {nGenre = 0, nDetail = 5, nParticular = {0,1}},  -- Giay nam
        Nu = {nGenre = 0, nDetail = 5, nParticular = {2,3}},   -- Giay nu
	},
    -- Dai lung (belt.txt) - ItemGenre=0, DetailType=6
	DaiLung = {
		TatCa = {nGenre = 0, nDetail = 6}, -- Tat ca dai lung
	},
    -- Non/Mu (helm.txt) - ItemGenre=0, DetailType=7
	Non = {
		TatCa = {nGenre = 0, nDetail = 7}, -- Tat ca non/mu
        Nam = {nGenre = 0, nDetail = 7, nParticular = {0,1,2,3,4,5,6}},  -- Non/Mu nam
        Nu = {nGenre = 0, nDetail = 7, nParticular = {7,8,9,10,11,12,13}},   -- Non/Mu nu
	},
	-- Bao tay/Ho uyen (cuff.txt) - ItemGenre=0, DetailType=8
	BaoTay = {
		TatCa = {nGenre = 0, nDetail = 8},  -- Dinh nghia chung cho tat ca bao tay/ho uyen
        Nam = {nGenre = 0, nDetail = 8, nParticular = 1},  -- Bao tay nam
        Nu = {nGenre = 0, nDetail = 8, nParticular = 0},   -- Bao tay nu
	},
	-- Ngoc boi (pendant.txt) - ItemGenre=0, DetailType=9
	NgocBoi = {
		TatCa = {nGenre = 0, nDetail = 9},
        Nam = {nGenre = 0, nDetail = 9, nParticular = 1},  -- Ngoc boi nam
        Nu = {nGenre = 0, nDetail = 9, nParticular = 0},   -- Ngoc boi nu
	},	
}
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
    	
    if gl_InternetDelay > 100 then
		gl_InternetDelay = 100
	end
	timer.Sleep(gl_InternetDelay)

    -- Buoc 1: Phan loai item - luu do VIP vao bang tam
    local tbVipItems = {} -- Bang luu thong tin do VIP
    local nIndex, nPlace, nXLocDo, nYLocDo = item.GetFirst()
    
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szItemName = item.GetName(nIndex)        
		if nPlace == 3 and nGenre == 0 and IsHoangKimItem(nIndex) == false then
			local b_DoVip = false
            for _, setDo in pairs(tbSetDoByType) do
				local b_Type = false
                if setDo.nDetail == nDetail then
                    local isParticularMatch = false
                    if setDo.nParticular == nil then
                        isParticularMatch = true
                    elseif type(setDo.nParticular) == "table" then
                        for _, pVal in pairs(setDo.nParticular) do
                            if pVal == nParticular then 
								isParticularMatch = true
								break 
							end
                        end
                    elseif setDo.nParticular == nParticular then
                        isParticularMatch = true
                    end

                    if isParticularMatch then
						b_Type = true
                    end
                end
				if b_Type == true then           
					local bFlag = 0
					local nRequiredCount = 0 
					for magicID, minValue in pairs(setDo) do						
						if type(magicID) == "number" then
							--echo("Kiem tra magicID: "..magicID.." - minValue: "..minValue)
							nRequiredCount = nRequiredCount + 1                       
							for i = 0, 5 do
								local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
								--echo("Item name: "..szItemName.." So sanh voi magicType: "..nMagicType.." - value: "..nValue)
								if nMagicType == magicID and nValue >= minValue then
									bFlag = bFlag + 1
									break
								end
							end
						end
					end
					if bFlag == nRequiredCount then
						table.insert(tbVipItems, {nIndex = nIndex, nX = nXLocDo, nY = nYLocDo})
						nCountItemVip = nCountItemVip + 1
						b_DoVip = true
						--echo("Tim thay do VIP: "..szItemName)
						break						
					end
				end

            end
            if b_DoVip == false then
                --ShopItem(nIndex)
                itemFiltered = itemFiltered + 1
            else
				echo("Giu lai do VIP: "..szItemName)
                itemFiltered = itemFiltered + 1
            end
        end
        nIndex, nPlace, nXLocDo, nYLocDo = item.GetNext()
    end
    echo("Xong! Loc: " .. itemFiltered .. " - Giu: " .. nCountItemVip)
end

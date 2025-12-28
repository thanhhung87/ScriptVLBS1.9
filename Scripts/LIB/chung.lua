szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
------------------------------------------------------------

-- Global Vari ---------------------------------------------
chungVersion = "2.3.3"
chungVersionDate = "15/10/2018"
gl_Time = os.clock()
gl_TimeSuDoThiep = gl_Time
gl_FirstTime = gl_Time
gl_ScriptFolder = system.GetScriptFolder()
gl_SoDongVip = 4
gl_MenuSkip = 2
gl_EnterWait = 30
gl_ShowSelectedMenu = false
gl_QuangCao = false
gl_QuangCaoTimeBreak = os.time()
gl_textQuangCao = "<enter><enter><enter><enter>LVT OFFicial<enter><enter>"
gl_QuangCaoCount = 0
gl_ChatNham = false
gl_ChatNhamTimeBreak = os.clock()
gl_LocDoTheoSet = 1
gl_LocDoNguHanh = 0
gl_menuClickSpeed = 50
gl_Sleep = 50
gl_Tien = false
gl_TienHanhTrang = 0
gl_GuiDo = true
gl_InternetDelay = 50
gl_InternetDelayCatch = 150
gl_InternetShit = false
gl_InternetShitTime = os.clock()
gl_filterCount = 0
preMenuText = ""
gl_Debug = false
tbSetDo = {}
tbSetDoByType = {}

-- option loc do ngu hanh
dongAn_1 = 1
dongAn_2 = 3
dongAn_3 = 5
tbNguHanh = {
	[dongAn_1] = {},
	[dongAn_2] = {},
	[dongAn_3] = {},
}

nVip = 0
nVipOld = 0

itemFiltered = 0
filterRepordTimeBreak = os.clock()
gl_CurrentDate = os.date("%Y/%m/%d")


gl_VipReportTimeBreak = os.clock()

tbRoomType = {
	[1] = 4, -- ruong mac dinh
	[7] = 9, -- ruong mo rong 1
	[8] = 10, -- ruong mo rong 2
}



-- End -----------------------------------------------------
function useTHP()
    tbVulanLib.UseItemName("ThÇn Hµnh Phï")
end

function useLenhBai(szLenhBai)
    local szLenhBai = szLenhBai or 'LÖnh bµi T©n Thñ'
    if tbVulanLib.UseItemName(szLenhBai) == 0 then
		tbVulanLib.Chat("CH_NEARBY", "<bclr=red>Kh«ng t×m thÊy "..szLenhBai.." :@:@")
	end
end

function clickMenu(nIndex)
    if hasMenu(gl_MenuSkip) then
		timer.Sleep(gl_menuClickSpeed)
        local nType = getMenuType()
        -- while menu.GetText(nType, nIndex) == preMenuText do
        --     timer.Sleep(gl_menuClickSpeed)
        -- end
        if gl_ShowSelectedMenu or gl_Debug then
            echo('§· chän: ' .. menu.GetText(nType, nIndex))
        end
        menu.ClickIndex(nType, nIndex)
        -- preMenuText = menu.GetText(nType, nIndex)
        return true
    else
        if gl_Debug then
            echo("Click Menu gÆp sù cè ngoµi ý muèn! Vui lßng ®îi auto xö lý!")
        end
        return false
    end
end

function clickMenuNext(nIndex)
    if hasDialogOrMenu(5) then
        local nType = getMenuType()
        clickMenu(nIndex)
    end
end

function clickMenuAll(...)
	local freeCell = getFreeHanhTrang(false)
	if freeCell ~= nil then
		for i,v in ipairs(arg) do
			if clickMenu(v) == false then
				resetMenuDialog()
				return false
			end
		end
	end
	return true
end

function resetMenuDialog()
    if dialog.IsVisible() then
        dialog.Close()
    end
    if menu.IsVisible(1) then
        menu.Close(1)
    end
    if menu.IsVisible(0) then
        menu.Close(0)
    end
end

function getMenuType()
    if menu.GetText(1, 0) == '' then
        return 0
    end
    return 1
end

function clickText(szText)
    echo('§· chän: ' .. szText)
    menu.ClickText(nType, szText)
end

function x2_sudothiep()
if player.GetLevel() > 79 then return end
if os.clock() - gl_TimeSuDoThiep < 30 then return end
if player.IsFightMode() == 0 then return end
if player.IsActiveState(76) == 1 then return end
gl_TimeSuDoThiep = os.clock()
echo("BËt "..szSuDoThiep)
tbVulanLib.UseItemName(szSuDoThiep)
echo("BËt "..szSuDoThiep.. ' kÕt thóc')
end

function check_state()
    for i=1,500 do
        if player.IsActiveState(i) == 1 then
            echo(i)
        end
    end
end

function bat_heal()
    local nMana = player.GetMana()
if nMana > 50 then return end
if player.GetLevel() > 80 then return end
    -- if player.IsActiveState(52) == 1 then return end
    echo("NhËn vßng s¸ng")
    tbVulanLib.UseItemName("CÈm nang ®ång hµnh")
    tbVulanLib.WaitMenuTimeOut(0,2)
    clickMenu(0,0)
end

function checkVar(var)
    for k, v in pairs(var) do
        echo(k)
    end
end

function getFreeHanhTrang(showEcho)
    local free = 60
    local nItemIndex, nPlace, nX, nY, nWidth, nHeight
    for i = 0, 255 do
        nItemIndex, nPlace, nX, nY = item.GetPos(i)
        if nPlace == 3 then
            nWidth, nHeight = item.GetSize(nItemIndex)
            free = free - nWidth * nHeight
        end
    end
    if showEcho then
        echo('Hµnh trang cßn trèng: ' .. free .. ' chç')
    end
    return free
end

function box_2(szContent)
    system.MessageBox(szContent)
end

function checkNPC()
    for i = 0, 255 do
        if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            echo(npc.GetName(i) .. ' kind: ' .. npc.GetKind(i) .. " length: " ..string.len(npc.GetName(i)))
        end
    end
end

function showNPC()
    for i = 0, 255 do
        if npc.GetKind(i) == 0 and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            local szHe = " kh«ng râ "
            if npc.GetSeries(i) == 0 then
                szHe = " hÖ kim "
            end
            if npc.GetSeries(i) == 1 then
                szHe = " hÖ méc "
            end
            if npc.GetSeries(i) == 2 then
                szHe = " hÖ thñy "
            end
            if npc.GetSeries(i) == 3 then
                szHe = " hÖ háa "
            end
            if npc.GetSeries(i) == 4 then
                szHe = " hÖ thæ "
            end
            echo(npc.GetName(i) .. szHe .. npc.GetLife(i))
        end
    end
end

function writeNPC()
    local file = io.open (gl_ScriptFolder .. "\\npc.txt", "w")
    for i = 0, 255 do
        if npc.GetKind(i) == 3 and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            -- file:write("npc_" .. toSlug(npc.GetName(i)) .. " = \"" .. npc.GetName(i) .. "\"", "\n")
            file:write("\"" .. npc.GetName(i) .. "\"", "\n")
        end
    end
    file:close()
end

function writeMapPath()
    echoRed("Ghi l¹i qu·ng ®­êng nh©n vËt di chuyÓn!")
    local x = 0
    local time = os.date("*t", os.time())
    local file = io.open (gl_ScriptFolder .. "\\mapPath.txt", "w")
    file:write("local mapPath = {")
    -- s
    while true and x < 20 do
        local nx, ny = player.GetMapPos(i)
        file:write("{" .. nx .. "," .. ny .. "}")

        if player.GetDoingStatus() == 1 then
            x = x + 1
            echo(x)
        end
        timer.Sleep(200)
    end
    file:close()
    echoRed("Ghi l¹i thµnh c«ng!")
end

function talkNPC(szNPCName)
    local minLength = 999999
    local indexNPC = 2

    for i = 2, 255 do
        local nx, ny = npc.GetMapPos(i)
        if npc.GetKind(i) == 3 and filled(szNPCName) and npc.GetName(i) == szNPCName then
            echo ("T×m thÊy " .. szNPCName .. " sÏ nãi chuyÖn trong chèc l¸t")
            echo(nx .. "/" .. ny)
            player.DialogNpc(i)
            hasDialogOrMenu(4)
            echo("Nãi chuyÖn thµnh c«ng!")
            echoLine()
            return true
        end
        if npc.GetKind(i) == 3 and blank(szNPCName) then
            if getDistance(nx, ny) < minLength then
                indexNPC = i
                minLength = getDistance(nx, ny)
            end
        end
    end

    if blank(szNPCName) then
        if gl_Debug then
            echo(minLength)
        end
        if minLength > 1100 then
            echo ("Kh«ng nhËp vµo tªn npc, nãi chuyÖn víi ng­êi gÇn nhÊt: " .. npc.GetName(indexNPC))
            player.DialogNpc(indexNPC)
            hasDialogOrMenu(4)
            echo("Nãi chuyÖn thµnh c«ng!")
            echoLine()
            return true
        else
            echoRed("NPC gÇn nhÊt ®øng c¸ch qu¸ xa")
            return false
        end
    end
    echo("Nãi chuyÖn thÊt b¹i!")
    echoLine()
end

function hasDialogOrMenu(nSecond)
    gl_FirstTime = os.clock()
    while menu.IsVisible(0) == 0 and menu.IsVisible(1) == 0 and dialog.IsVisible() == 0 do 
        timer.Sleep(gl_Sleep) 
        if (os.clock() - gl_FirstTime) > nSecond then
            return false
        end
    end
    return true
end

function hasMenu(nSecond)
    gl_FirstTime = os.clock()
    while menu.IsVisible(0) == 0 and menu.IsVisible(1) == 0 do 
        timer.Sleep(gl_Sleep) 
        if (os.clock() - gl_FirstTime) > nSecond then
			gl_InternetShit = true
			gl_InternetShitTime = os.clock()
            return false
        end
    end
    timer.Sleep(30) 
    return true
end

function hasDialog(nSecond)
    gl_FirstTime = os.clock()
    while dialog.IsVisible() == 0 do 
        timer.Sleep(gl_Sleep) 
        if (os.clock() - gl_FirstTime) > nSecond then
            return false
        end
    end
    return true
end

function testLength()
    for i = 0, 255 do
        if npc.IsExists(i) and npc.GetKind(i) == 3 and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            echo(npc.GetName(i))
            echo(tbVulanLib.GetLengthPlayer(nx, ny))
        end
    end
end


function LocDo()
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
	
	local tmpFreeCell = getFreeHanhTrang(false)
	if tmpFreeCell == nil then
		return
	end
	
    if gl_Debug then
        echo("TiÕn hµnh läc ®å!")
    end
    gl_FirstTime = os.clock()
    while nFreeHanhTrang == getFreeHanhTrang(false) do 
        timer.Sleep(500)
        if (os.clock() - gl_FirstTime) > 1 then
            --gl_EnterWait = 500
            if gl_Debug then
                echoRed("CËp nhËt hµnh trang thÊt b¹i")
            end
            nFreeHanhTrang = 61
        end
    end
    --local nVip = 0
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
			
			-- loc do 5 hanh
			if gl_LocDoNguHanh == 1 and nDoVip == 1 then
				echo("TiÕn hµnh läc ®å ngò hµnh!")
				local nMagicType2, nValue2 = item.GetMagicAttrib(nIndex, kIndex)
				if tbNguHanh[dongAn_1] ~= nil and tablelength(tbNguHanh[dongAn_1]) > 0 then
					local nMagicType, nValue = item.GetMagicAttrib(nIndex, dongAn_1)
					if tbNguHanh[dongAn_1][nMagicType] == nil then
						nDoVip = 0
					end
				end
				if tbNguHanh[dongAn_2] ~= nil and tablelength(tbNguHanh[dongAn_2]) > 0 then
					local nMagicType, nValue = item.GetMagicAttrib(nIndex, dongAn_2)
					if tbNguHanh[dongAn_2][nMagicType] == nil then
						nDoVip = 0
					end
				end
				if tbNguHanh[dongAn_3] ~= nil and tablelength(tbNguHanh[dongAn_3]) > 0  then
					local nMagicType, nValue = item.GetMagicAttrib(nIndex, dongAn_3)
					if tbNguHanh[dongAn_3][nMagicType] == nil then
						nDoVip = 0
					end
				end
			end
			
            if nDoVip == 0 then
                ShopItem(nIndex)
            else
                GuiDo(nIndex, nXLocDo, nYLocDo)
                nVip = nVip + 1
            end
			itemFiltered = itemFiltered + 1
        end
        nIndex, nPlace, nXLocDo, nYLocDo = item.GetNext()
    end
	
    if nVip > 0 then
		if nVip > nVipOld then			
			nVipOld = nVip
		end
		if gl_ChatNham and (os.time() - gl_VipReportTimeBreak) > 10 then
			tbVulanLib.Chat("CH_NEARBY","<bclr=red>Th­a cËu ®· t×m ®­îc " .. nVip .. " mãn VIP ¹! :0")
			gl_VipReportTimeBreak = os.time()
		end
		
    end
	--[[
	if os.time() - gl_Time > 300 then
        echoRed(line())
        echoGreen("Auto ChungNguyÔn version " .. chungVersion)
		echoGreen("Edit by Hoµng Minh")
		echoGreen("Hoµn toµn miÔn phÝ vµ open source!")
		echoRed(line())
        --echoDonate()
        gl_Time = os.time()
    end
	--]]
	if os.time() - filterRepordTimeBreak > 600 then
		echoRed(line())
        echoGreen("Auto Loc Do VIP")
		echoGreen("Edit by LVT Official")
		echoGreen("Hoµn toµn miÔn phÝ vµ open source!")
		--echoRed(line())
        reportFilter(itemFiltered, nVip)
        filterRepordTimeBreak = os.time()
    end
	
    echoQuangCao()
    nFreeHanhTrang = getFreeHanhTrang(false)
	
	-- neu ruong dang mo thi dong lai
	if box.IsVisible() == 1 then
		box.Close()
		timer.Sleep(1000)
	end
end

function reportFilter(itemCount, vipCount)
	local timeNow = os.date("%H:%M:%S")
	local today = os.date("%Y/%m/%d")
	
	if today ~= gl_CurrentDate then
		gl_CurrentDate = today
		itemCount = 0
		itemFiltered = 0
		vipCount = 0
		nVip = 0
	end
	
	echoRed(line())
	echo(os.date("%Y/%m/%d %H:%M:%S"))
	echoRed("-----------------------------------")
	echo("Sè item ®· läc: "..itemCount)
	echo("Sè item VIP: "..vipCount)
	echoRed(line())
	local fileName = os.date("%Y_%m_%d-")..player.GetID()..".txt"
    local file = io.open (gl_ScriptFolder .. "\\reportFilter\\"..fileName, "a+")
	file:write(line() .. '\n')
	file:write(os.date("%Y/%m/%d %H:%M:%S") .. '\n')
	file:write("-----------------------------------" .. '\n')
	file:write("So item da loc: ".. itemCount .. '\n')
	file:write("So item VIP: ".. vipCount .. '\n')
	file:write(line() .. '\n')
    file:close()
end

function quangItemRaNgoai()
	if item.IsHold() == 0 then
		return
	end

	local nIndex, nPlace, nX, nY = item.GetFirst()
	while nIndex ~= 0 do 
		if nPlace == 1 then
			item.ThrowAway()
			return
		end
		nIndex, nPlace, nX, nY = item.GetNext()
	end
end

function GuiDo(nIndex, nXLocDo, nYLocDo)
    if gl_GuiDo then
        echoGreen("TiÕn hµnh cÊt ®å!!!")
		-- nem bo vat pham dang cam tren tay
		quangItemRaNgoai()
		
		-- neu chua mo ruong thi tien hanh mo ruong
		if box.IsVisible() == 0 then
			if gl_ChatNham then
				tbVulanLib.Chat("CH_NEARBY", "<bclr=blue>Hª! hª! Cã ®å VIP!!! :U")
			end
			player.PathMoveTo(0,0,"R­¬ng chøa ®å")
			box.Open()
			timer.Sleep(1000)
			
			gl_FirstTime = os.clock()
			while box.IsVisible() == 0 do
				box.Open()
				timer.Sleep(2000)
				if os.clock() - gl_FirstTime > 10 and box.IsVisible() == 0 then
                    echoRed("Kh«ng t×m thÊy r­¬ng chøa ®å!")
                    echoRed("T¾t chÕ ®é göi ®å vµo r­¬ng!")
                    gl_GuiDo = false
                    break
                end
			end
			if gl_GuiDo == false then
				return
			end
		end
		
        local nWidthGuiDo, nHeightGuiDo = item.GetSize(nIndex)
		local ruongChuaDo = nil
		-- tim noi chua do ruong mac dinh
		local bFound, nXGuiDo, nYGuiDo = player.FindRoom(nWidthGuiDo, nHeightGuiDo, 1)
		if bFound == 1 then
			ruongChuaDo = tbRoomType[1]
		end
		
		-- tim noi chua do ruong mo rong 1
		if bFound == 0 then
			bFound, nXGuiDo, nYGuiDo = player.FindRoom(nWidthGuiDo, nHeightGuiDo, 7)
			if bFound == 1 then
				ruongChuaDo = tbRoomType[7]
			end
		end
		
		-- tim noi chua do ruong mo rong 2
		if bFound == 0 then
			bFound, nXGuiDo, nYGuiDo = player.FindRoom(nWidthGuiDo, nHeightGuiDo, 8)
			if bFound == 1 then
				ruongChuaDo = tbRoomType[8]
			end
		end

        if bFound == 1 then
            echoRed("B¹n ph¶i ch¾n ch¾n r­¬ng ch­a ®å ®ang ®­îc më s½n!!!")
			-- lay item tu hanh trang len tay
            item.Move(3,nXLocDo, nYLocDo,0,0,0)
			timer.Sleep(200)
            while item.IsHold() == 0 do
                echo("no hold")
                timer.Sleep(200)
            end
			-- chuyen item vao ruong chua do
            item.Move(ruongChuaDo, nXGuiDo, nYGuiDo, ruongChuaDo, nXGuiDo, nYGuiDo)
            gl_FirstTime = os.clock()
            while item.IsHold() == 1 do
                timer.Sleep(200)
                if os.clock() - gl_FirstTime > 5 then
                    echoRed("R­¬ng ®å ch­a më, t¾t tÝnh n¨ng göi ®å!!!")
                    gl_GuiDo = false
					-- dat item tu tay tro lai hanh trang
                    item.Move(3,nXLocDo, nYLocDo, 3,nXLocDo, nYLocDo)
                    break
                end
            end
        else
            gl_GuiDo = false
            echoRed("R­¬ng kh«ng cßn chç trèng!!!")
        end
    end
end
-- Ham kiem tra item co phai do hoang kim khong
function IsHoangKimItem(nIndex)
    local nPrice = item.GetPrice(nIndex)
    
    -- Do hoang kim co gia = 49999
    if nPrice >= 49999 then
        return true
    end
    
    return false
end
function writeThuocTinh()
    echoRed('Ghi toµn bé thuéc tÝnh cã trong hµnh trang ra file')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local file = io.open (gl_ScriptFolder .. "\\option.txt", "w+")
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szName = item.GetName(nIndex)
        -- echo (szName)
        -- echo (nGenre .. nDetail .. nParticular)
        if nPlace == 3 and nGenre == 0 and item.GetPrice(nIndex) > 0 then
            echo(szName)
            file:write(szName .. '\n')
            for i = 0, 5 do
                local nMagicType, nValue1, nValue2, nValue3 = item.GetMagicAttrib(nIndex, i)
                echo('Dßng ' .. (i+1) .. ': ' .. nMagicType .. ' - ' .. nValue1)
                file:write('[' .. nMagicType .. '] = ' .. nValue1 .. ',' .. '\n')
            end
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
end

function enter()
    if gl_Debug then
        echo("Enter Sleep: " .. gl_EnterWait)
    end
    timer.Sleep(gl_EnterWait)
    system.SendKey(13, 1)
    --gl_EnterWait = 30
end

function nhapso(nSo)
    local nLength
    gl_FirstTime = os.clock()
    while dialog.IsVisible() == 0 do
        timer.Sleep(10)
        if os.clock() - gl_FirstTime > 3 then
            resetMenuDialog()
            if gl_Debug then
                echoRed("NhËp sè kh«ng thµnh c«ng!")
            end
            return
        end
    end
    for i in string.gmatch(tostring(nSo), "%d") do
        timer.Sleep(50)
        system.SendKey(48 + tonumber(i), 0)
    end
    enter()
	timer.Sleep(gl_menuClickSpeed)
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function ShopItem(nIndex)
	local startTime = os.clock()*1000
    if gl_Tien then
        gl_TienHanhTrang = player.GetMoney(0)
        shop.Buy(nIndex)
        while gl_TienHanhTrang == player.GetMoney(0) do
            timer.Sleep(10)
        end
    else
        nFreeHanhTrang = getFreeHanhTrang(false)
        shop.Buy(nIndex)
        gl_FirstTime = os.clock()
        while nFreeHanhTrang == getFreeHanhTrang(false) do
            timer.Sleep(10)
            if os.clock() - gl_FirstTime > 2 then
                break
            end
        end
    end
	gl_InternetDelay = (os.clock()*1000 - startTime)
    --echoGreen(gl_InternetDelay)
	if gl_InternetDelay < 100 then
		gl_InternetDelay = 100
	end
    
end

function writeMenu()
    local nType = 1
    if menu.IsVisible(1) == 0 then
        nType = 0
    end
    local file = io.open (gl_ScriptFolder .. "\\menu.txt", "w")
    for i=0, menu.GetCount(nType) do
        echo (menu.GetText(nType, i))
        file:write(toSlug(menu.GetText(nType, i)) .. '\n')
    end
    file:close(file)
end

function blank(var)
    return var == nil
end

function filled(var)
    return not blank(var)
end

function getDistance(x1, y1)
    local x2, y2 = player.GetMapPos()
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

function echo(szContent)
    system.Print(szContent)
end

function echoColor(szContent, szColor)
    szContent = "<color=" .. szColor .. ">" .. szContent
    echo(szContent)
end

function echoGreen(szContent)
    echoColor(szContent, "green")
end

function echoRed(szContent)
    echoColor(szContent, "red")
end

function line()
    return "==================================="
end

function echoLine()
    echo(line())
end
function echoDonate()
    echoRed(line())
    echo("Chñ TK: NGUYEN TRAN CHUNG")
    echo("Sè TK: 0061001069423")
    echo("Chi nh¸nh Vietcombank Kh¸nh Hßa")
    echoRed(line())
end

function echoQuangCao()
    if gl_QuangCao and (os.time() - gl_QuangCaoTimeBreak) > 180 then
        tbVulanLib.Chat("CH_WORLD", gl_textQuangCao)
		gl_QuangCaoTimeBreak = os.time()
    end
	if gl_ChatNham and (os.time() - gl_ChatNhamTimeBreak) > 20 then
		tbVulanLib.Chat("CH_NEARBY", "<bclr=pink>ChungNguyÔn " .. chungVersion .. ". Edit by Hoµng Minh :U")
		gl_ChatNhamTimeBreak = os.time()
	end
end

function toSlug(str)
    str = string.gsub(str,"iÕ","tiet")
    str = string.gsub(str,"§¸i","dai")
    str = string.gsub(str,"§­","d")
    str = string.gsub(str,"ê","uo")
    str = string.gsub(str,"­u","uu")
    str = string.gsub(str,"¤","o")
    str = string.gsub(str,"¢","a")
    str = string.gsub(str,"uyÕ","uye")
    return str
    :gsub('%®¹o', 'dao') -- duong

    :gsub('%­­®', 'd') -- dd

    :gsub('%­­­øu', 'uu') -- uuws
    :gsub('%­­­õu', 'uu') -- uuwf
    :gsub('%­­­÷u', 'uu') -- uuwx
    :gsub('%öu', 'uu') -- uuwr
    :gsub('%­­ùu', 'uu') -- uuwj

    :gsub('%¸', 'a') -- as
    :gsub('%µ', 'a') -- af
    :gsub('%·', 'a') -- ax
    :gsub('%¶', 'a') -- ar
    :gsub('%¹', 'a') -- aj

    :gsub('%©', 'a') -- aa
    :gsub('%Ê', 'a') -- aas
    :gsub('%Ç', 'a') -- aaf
    :gsub('%É', 'a') -- aax
    :gsub('%È', 'a') -- aar
    :gsub('%Ë', 'a') -- aaj

    :gsub('%¨', 'a') -- aw
    :gsub('%¾', 'a') -- aws
    :gsub('%»', 'a') -- awf
    :gsub('%½', 'a') -- awx
    :gsub('%¼', 'a') -- awr
    :gsub('%Æ', 'a') -- awj

    :gsub('%Ð', 'e') -- es
    :gsub('%Ì', 'e') -- ef
    :gsub('%Ï', 'e') -- ex
    :gsub('%Î', 'e') -- er
    :gsub('%Ñ', 'e') -- ej

    :gsub('%Õ', 'e') -- ees
    :gsub('%Ò', 'e') -- eef
    :gsub('%Ô', 'e') -- eex
    :gsub('%Ó', 'e') -- eer
    :gsub('%Ö', 'e') -- eej

    :gsub('%Ý', 'i') -- is
    :gsub('%×', 'i') -- if
    :gsub('%Ü', 'i') -- ix
    :gsub('%Ø', 'i') -- ir
    :gsub('%Þ', 'i') -- ij

    :gsub('%ã', 'o') -- os
    :gsub('%ß', 'o') -- of
    :gsub('%â', 'o') -- ox
    :gsub('%á', 'o') -- or
    :gsub('%ä', 'o') -- oj

    :gsub('%«', 'o') -- oo
    :gsub('%è', 'o') -- oos
    :gsub('%å', 'o') -- oof
    :gsub('%ç', 'o') -- oox
    :gsub('%æ', 'o') -- oor
    :gsub('%é', 'o') -- ooj

    :gsub('%ý', 'y') -- s
    :gsub('%ú', 'y') -- f
    :gsub('%ü', 'y') -- x
    :gsub('%û', 'y') -- r
    :gsub('%þ', 'y') -- j

    :gsub('%ó', 'u') -- us
    :gsub('%ï', 'u') -- uf
    :gsub('%ò', 'u') -- ux
    :gsub('%ñ', 'u') -- ur
    :gsub('%ô', 'u') -- uj

    :gsub('%­¬', 'uo') -- uow
    :gsub('%­­­í', 'uo') -- uos
    :gsub('%­­­ê', 'uo') -- uof
    :gsub('%­­­ì', 'uo') -- uox
    :gsub('%­­­ë', 'uo') -- uor
    :gsub('%­­î', 'uo') -- uoj

    -- :gsub(' I$', '1')
    -- :gsub(' II$', '2')
    -- :gsub(' III$', '3')
    -- :gsub(' IV$', '4')
    -- :gsub(' V$', '5')
    -- :gsub('[^%w]', '')
    :lower()
end

tbThuocTinhName = {
    [43] = "Kh«ng thÓ ph¸ hñy", 
    [58] = "Bá qua nÐ tr¸nh", 
    [85] = "Sinh lùc", 
    [89] = "Néi lùc", 
    [93] = "ThÓ lùc", 
    [97] = "Søc m¹nh", 
    [98] = "Th©n ph¸p",
    [99] = "Sinh khÝ", 
    [88] = "Phôc håi sinh lùc mçi nöa gi©y", 
    [92] = "Phôc håi néi lùc mçi nöa gi©y", 
    [96] = "Phôc håi thÓ lùc mçi nöa gi©y", 
    [101] = "Kh¸ng ®äc", 
    [102] = "Kh¸ng háa", 
    [103] = "Kh¸ng l«i", 
    [104] = "Phßng thñ vËt lý", 
    [105] = "Kh¸ng b¨ng", 
    [106] = "TG lµm chËm", 
    [108] = "TG tróng ®äc", 
    [110] = "TG lµm cho¸ng", 
    [111] = "Tèc ®é di chuyÓn", 
    [113] = "TG phôc håi", 
    [115] = "Tèc ®é ®¸nh (ngo¹i c«ng)", 
    [116] = "Tèc ®é ®¸nh (néi c«ng)", 
    [114] = "Kh¸ng tÊt c¶", 
    [117] = "Ph¶n ®ßn cËn chiÕn", 
    [135] = "May m¾n %", 
    [121] = "STVL ®iÓm", 
    [122] = "Háa s¸t ngo¹i c«ng", 
    [123] = "B¨ng s¸t ngo¹i c«ng", 
    [124] = "L«i s¸t s¸t ngo¹i c«ng", 
    [125] = "§éc s¸t ngo¹i c«ng", 
    [126] = "STVL %", 
    [134] = "CHSTTNL", 
    [136] = "Hót sinh lùc", 
    [137] = "Hót néi lùc", 
    [139] = "Kü n¨ng MP", 
    [166] = "TØ lÖ c«ng kÝch chÝnh x¸c", 
    [168] = "STVL néi c«ng", 
    [169] = "B¨ng s¸t néi c«ng", 
    [170] = "Háa s¸t néi c«ng", 
    [171] = "L«i s¸t néi c«ng", 
    [172] = "§éc s¸t néi c«ng,"  
}


-- Start
nFreeHanhTrang = 61
echoLine()
echo("Scripts 23/5/2023")
echoGreen("ChØnh söa vµ tèi ­u bëi LVT Official.")
echoGreen("YTB: https://www.youtube.com/@LVTOfficial")
echoGreen("Sever: Congthanhchien.us")
echo("Start script!")
-- End
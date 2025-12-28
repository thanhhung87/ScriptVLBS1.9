szScriptFolder = system.GetScriptFolder()

szChungLib = szScriptFolder.."\\LIB\\chung.lua"
IncludeFile(szChungLib)

-- Include config file
szConfig = szScriptFolder.."\\00_config.lua"
IncludeFile(szConfig)

-- -- Set Item Hoa
-- setHoa_BaoTay_Non_DaiLung = szScriptFolder.."\\LIB\\setdo\\hoa-non-baotay-dailung.lua"
-- setHoa_Ao_Giay = szScriptFolder.."\\LIB\\setdo\\hoa-ao-giay.lua"

-- -- Set Item Thuy
-- setThuy_BaoTay_Non_DaiLung = szScriptFolder.."\\LIB\\setdo\\thuy-non-baotay-dailung.lua"
-- setThuy_Ao_Giay = szScriptFolder.."\\LIB\\setdo\\thuy-ao-giay.lua"

-- -- Set Item Moc
-- setMoc_BaoTay_Non_DaiLung = szScriptFolder.."\\LIB\\setdo\\moc-non-baotay-dailung.lua"
-- setMoc_Ao_Giay = szScriptFolder.."\\LIB\\setdo\\moc-ao-giay.lua"

-- -- Set Item Tho
-- setTho_BaoTay_Non_DaiLung = szScriptFolder.."\\LIB\\setdo\\tho-non-baotay-dailung.lua"
-- setTho_Ao_Giay = szScriptFolder.."\\LIB\\setdo\\tho-ao-giay.lua"

-- -- Set Item Kim
-- setKim_BaoTay_Non_DaiLung = szScriptFolder.."\\LIB\\setdo\\kim-non-baotay-dailung.lua"
-- setKim_Ao_Giay = szScriptFolder.."\\LIB\\setdo\\kim-ao-giay.lua"

-- -- Set Item VK
-- setVK = szScriptFolder.."\\LIB\\setdo\\vk.lua"

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
-- Ham nhan do xanh cap 10
function NhanDoXanhCap10(sl, ...)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end
	
	LocDo()
	local freeCell = getFreeHanhTrang(false)
	if freeCell ~= nil and freeCell > freeCellCatch then
		local pageing = math.ceil(sl/10);
		for i = 1, pageing do
			useLenhBai()
			timer.Sleep(gl_menuClickSpeed)
			clickMenuAll(1,...)
			nhapso(sl)
			sl = sl - 10
			
			if i < pageing then
				timer.Sleep(50)
			end
		end
		if gl_InternetDelay < 100 then
			gl_InternetDelay = 100
		end
	end
end
----------------------------------------------------------------------------------------
-- Ham nhan do xanh cap 1
function NhanDoXanhCap1(sl, ...)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end
	
	LocDo()
	local freeCell = getFreeHanhTrang(false)
	if freeCell ~= nil and freeCell > freeCellCatch then
		local pageing = math.ceil(sl/10);
		for i = 1, pageing do
			useLenhBai()
			timer.Sleep(gl_menuClickSpeed)
			clickMenuAll(1,...)
			nhapso(sl)
			sl = sl - 10
			
			if i < pageing then
				timer.Sleep(50)
			end
		end
		if gl_InternetDelay < 100 then
			gl_InternetDelay = 100
		end
	end
end
----------------------------------------------------------------------------------------
-- Ham nhan do HKMP
function NhanHKMP(...)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end
	
	LocDo()
	local freeCell = getFreeHanhTrang(false)
	if freeCell ~= nil and freeCell > freeCellCatch then
		useLenhBai()
		timer.Sleep(gl_menuClickSpeed)
		clickMenuAll(3,...)
		timer.Sleep(gl_InternetDelay)
	end
end

-- Ham nhan do HKMP 2
function NhanHKMP_2(l,...)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end
	
	LocDo()
	local freeCell = getFreeHanhTrang(false)
	if freeCell ~= nil and freeCell > freeCellCatch then
		for i = 1, l do
			useLenhBai()
			timer.Sleep(gl_menuClickSpeed)
			clickMenuAll(3,...)
			if i < l then
				timer.Sleep(100)
			end
		end
		--timer.Sleep(gl_InternetDelay)
		if gl_InternetDelay < 100 then
			gl_InternetDelay = 100
		end
	end
end
----------------------------------------------------------------------------------------
-- Ham nhan do AnBangDinhQuoc
function NhanAnBangDinhQuoc(id)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end
	
	LocDo()
	local freeCell = getFreeHanhTrang(false)
	if freeCell ~= nil and freeCell > freeCellCatch then
		useLenhBai()
		timer.Sleep(gl_menuClickSpeed)
		clickMenuAll(4,id)
		timer.Sleep(gl_InternetDelay)
	end
end
----------------------------------------------------------------------------------------
-- Ham nhan do AnBangDinhQuoc 2
function NhanAnBangDinhQuoc_2(l, id)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end
	
	LocDo()
	local freeCell = getFreeHanhTrang(false)
	if freeCell ~= nil and freeCell > freeCellCatch then
		for i = 1, l do
			useLenhBai()
			timer.Sleep(gl_menuClickSpeed)
			clickMenuAll(4,id)
			if i < l then
				timer.Sleep(100)
			end
		end
		--timer.Sleep(gl_InternetDelay)
	end
end
----------------------------------------------------------------------------------------
-- Ham them set do
function ThemSetDo(setDo)
	local index = tablelength(tbSetDo)
	tbSetDo[index] = setDo
end
----------------------------------------------------------------------------------------
-- Ham nhan do xanh
function NhanDoXanh(...)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end

	LocDo()
	echo("dang loc do")
	timer.Sleep(3000)
	-- local clickNext = true
	-- local freeCell = getFreeHanhTrang(false)
	-- local freeCellOld = nil
	-- local cellCacth = 30
	-- local delay = gl_InternetDelay
	
	-- if gl_InternetShit and cellCacth ~= 56 then
	-- 	cellCacth = 56
	-- 	echoRed(line())
	-- 	echo("M¹ng chËp chên!")
	-- 	echo("T¹m thêi gi¶m sè l­îng trong 5 phót.!")
	-- 	echoRed(line())
	-- end
	-- if os.clock() - gl_InternetShitTime > 300 then
	-- 	cellCacth = 5
	-- 	gl_InternetShit = false
	-- end
	
	-- while true do
	
	-- 	if clickNext == false then
	-- 		if delay ~= gl_InternetDelay then
	-- 			gl_InternetDelay = delay
	-- 		end
	-- 		break
	-- 	end
		
	-- 	gl_FirstTime = os.clock()
	-- 	while freeCell == freeCellOld and freeCellOld ~= nil do
	-- 		if freeCell <= cellCacth then
	-- 			clickNext = false
    --             break
	-- 		end
	-- 		timer.Sleep(gl_InternetDelay)
	-- 		freeCell = getFreeHanhTrang(false)
	-- 		if (os.clock() - gl_FirstTime > 1) then
	-- 			clickNext = false
    --             break
    --         end
			
	-- 	end
		
	-- 	-- if clickNext == true then
	-- 	-- 	if freeCell ~= nil and freeCell >= cellCacth and freeCell ~= freeCellOld then
	-- 	-- 		freeCellOld = freeCell
	-- 	-- 		--useLenhBai()
	-- 	-- 		timer.Sleep(gl_menuClickSpeed)
	-- 	-- 		clickNext = clickMenuAll(...)
	-- 	-- 		--nhapso(gl_SoluongItem)
	-- 	-- 		--echo(gl_InternetDelay)
	-- 	-- 		--timer.Sleep(gl_InternetDelay)
	-- 	-- 		delay = 100
	-- 	-- 	else
	-- 	-- 		clickNext = false
	-- 	-- 	end
	-- 	-- end
		
	-- end
end
----------------------------------------------------------------------------------------

-- Ham nhan do HKMP va HK An Bang, Dinh Quoc vv
function NhanDoHoangKim(...)
	
	if player.GetID() == 0 then
		echo("Kh«ng t×m thÊy th«ng tin nh©n vËt!")
		timer.Sleep(3000)
		return
	end
	
	LocDo()
	local clickNext = true
	local freeCell = getFreeHanhTrang(false)
	local freeCellOld = nil
	local cellCacth = 30
	local delay = gl_InternetDelay
	
	if gl_InternetShit and cellCacth ~= 56 then
		cellCacth = 56
		echoRed(line())
		echo("M¹ng chËp chên!")
		echo("T¹m thêi gi¶m sè l­îng trong 5 phót.!")
		echoRed(line())
	end
	if os.clock() - gl_InternetShitTime > 300 then
		cellCacth = 30
		gl_InternetShit = false
	end
	
	while true do
	
		if clickNext == false then
			if delay ~= gl_InternetDelay then
				gl_InternetDelay = delay
			end
			break
		end
		
		gl_FirstTime = os.clock()
		while freeCell == freeCellOld and freeCellOld ~= nil do
			if freeCell <= cellCacth then
				clickNext = false
                break
			end
			timer.Sleep(gl_InternetDelay)
			freeCell = getFreeHanhTrang(false)
			if (os.clock() - gl_FirstTime > 1) then
				clickNext = false
                break
            end
			
		end
		
		if clickNext == true then
			if freeCell ~= nil and freeCell >= cellCacth and freeCell ~= freeCellOld then
				freeCellOld = freeCell
				useLenhBai()
				clickNext = clickMenuAll(...)
				--nhapso(gl_SoluongItem)
				--echo(gl_InternetDelay)
				--timer.Sleep(gl_InternetDelay)
				delay = 100
			else
				clickNext = false
			end
		end
		
	end
end
----------------------------------------------------------------------------------------

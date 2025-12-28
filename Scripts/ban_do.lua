szMrCoLib = system.GetScriptFolder().."\\LIB\\MrCoLib.lua"
IncludeFile(szMrCoLib)
-- Template thuoc tinh
--[[
tbThuocTinh = {
    [43] = 1, -- khong the pha huy
	[58] = 2, -- bo qua ne tranh
	[85] = 200, -- sinh luc
	[89] = 200, -- noi luc
	[93] = 200, -- the luc
	[97] = 20, -- suc manh
	[98] = 20, --than phap
	[99] = 20, -- sinh khi
	[88] = 6, -- phuc hoi sinh luc moi nua giay
	[92] = 6, -- phuc hoi noi luc moi nua giay
	[96] = 9, -- phuc hoi the luc moi nua giay
	[101] = 25, -- khang doc
	[102] = 25, -- khang hoa
	[103] = 30, -- khang loi
	[104] = 25, -- ptvl
	[105] = 25, -- khang bang
	[106] = 40, -- tg lam cham
	[108] = 40, -- tg trung doc
	[110] = 40, -- tg lam choang
	[111] = 40, -- toc do di chuyen
	[113] = 40, -- thoi gian phuc hoi
	[115] = 30, -- toc do danh (ngoai cong)
	[116] = 40, -- toc do danh (noi cong)
	[114] = 20, -- khang tat ca
	[117] = 20, -- phan don can chien
	[135] = 10, -- may man %
	[121] = 50, -- stvl diem (dong an)
	[122] = 100, -- hoa sat ngoai cong
	[123] = 100, -- bang sat ngoai cong
	[124] = 100, -- loi sat sat ngoai cong
	[125] = 50, -- doc sat ngoai cong
	[126] = 100, -- stvl % (dong hien)
	[134] = 15, -- chsttnl
	[136] = 10, -- hut sinh luc
	[137] = 10, -- hut noi
	[139] = 3, -- ky nang cua phai do duoc cong them
	[166] = 500, -- ti le cong kich chinh xac
	[168] = 200, -- stvl noi cong
	[169] = 200, -- bang sat noi cong
	[170] = 200, -- hoa sat noi cong
	[171] = 200, -- loi sat noi cong
	[172] = 50,  -- doc sat noi cong
}
--]]

ThemSetDo({
    [139] = 1, -- ky nang vong co
})
ThemSetDo({
	[171] = 180, -- loi sat noi cong
	[116] = 20, -- toc do danh (noi cong)
})
ThemSetDo({
    [104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
	[98] = 20, --than phap
})
ThemSetDo({
    [102] = 25, -- khang hoa
	[110] = 40, -- tg lam choang
	[99] = 20, -- sinh khi
})
ThemSetDo({
    [114] = 20, -- khang tat ca
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
})
ThemSetDo({
    [114] = 20, -- khang tat ca
	[102] = 25, -- khang hoa
	[110] = 40, -- tg lam choang
})
ThemSetDo({
    [115] = 30, -- toc do danh (ngoai cong)
	[125] = 50, -- doc sat ngoai cong
})

TB_Map = {1,11,78,162,37,80,176,53,20,99,100,101,121,153,174}
-- Tao lookup table de tra cuu nhanh O(1)
TB_Map_Set = {}
for _, mapID in ipairs(TB_Map) do
    TB_Map_Set[mapID] = true
end
-- Luu map ID da xu ly
last_processed_map = 0
countcheck = 0
function ban_do()
    local nCurMapID = map.GetID()
    
    -- Kiem tra xem co o trong map trong danh sach khong (O(1))
    if TB_Map_Set[nCurMapID] then
        -- Chi chay neu chua xu ly map nay
        if last_processed_map ~= nCurMapID then
            echo("dang loc do xong ban")
				for i = 1,3 do
					LocDoXongBan()
					timer.Sleep(500)
				end
            
            last_processed_map = nCurMapID
        end
        return true -- Dang o trong map hop le
    else
        -- Reset khi ra khoi map
        last_processed_map = 0
        return false -- Khong o trong map hop le
    end
end

function main()
	while true do
		local isInValidMap = ban_do()
        -- Tang delay khi dang o trong map da xu ly de tiet kiem tai nguyen
        if isInValidMap then
            timer.Sleep(5000) -- 5s khi da xu ly xong map
        else
            timer.Sleep(2000) -- 1s khi dang tim map moi
        end
	end
end
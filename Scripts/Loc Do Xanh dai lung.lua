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

-- DANH SACH CAC SET DO
ThemSetDo({
	--[85] = 199, -- sinh luc
   --[89] = 199, -- noi luc
    --[93] = 199, -- the luc
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
	--[98] = 20, --than phap
})
ThemSetDo({
	[85] = 199, -- sinh luc
    [89] = 199, -- noi luc
    [88] = 5, -- phuc hoi sinh luc moi nua giay
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
	[98] = 20, --than phap
})
ThemSetDo({
	[85] = 199, -- sinh luc
    [89] = 199, -- noi luc
    [43] = 1, -- khong the pha huy
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
	[98] = 20, --than phap
})
---
ThemSetDo({
	[85] = 180, -- sinh luc
    [89] = 180, -- noi luc
    [93] = 180, -- the luc
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
	[134] = 14, -- chsttnl
})
ThemSetDo({
	[85] = 180, -- sinh luc
    [89] = 180, -- noi luc
    [88] = 5, -- phuc hoi sinh luc moi nua giay
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
	[134] = 14, -- chsttnl
})
ThemSetDo({
	[85] = 180, -- sinh luc
    [89] = 180, -- noi luc
    [43] = 1, -- khong the pha huy
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
	[134] = 14, -- chsttnl
})

function main()
	while true do
		-- So 0: Chon menu: menu test
		-- So 2: Chon menu: ta muon nhan trang bi xanh
		-- So 2: Chon menu: Dai lung
		-- So 0: Chon menu: Thien Tam Yeu Dai
		-- So 3: Chon menu: He Hoa
		NhanDoXanh(0,2,2,0,3);
	end
end
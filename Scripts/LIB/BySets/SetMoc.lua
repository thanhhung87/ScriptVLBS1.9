--VuKhi 
ThemSetDoByType({
	itemType = tbType.VuKhi,  -- Chi loc vk
	[116] = 20, -- toc do danh (noi cong)
	[172] = 40,  -- doc sat noi cong
})
ThemSetDoByType({
	itemType = tbType.VuKhi.Con,  -- Chi loc vk
	[115] = 20, -- toc do danh (ngoai cong)
	[125] = 5, -- doc sat ngoai cong
})
ThemSetDoByType({
	itemType = tbType.VuKhi.Dao,  -- Chi loc vk
	[115] = 20, -- toc do danh (ngoai cong)
	[125] = 5, -- doc sat ngoai cong
})
ThemSetDoByType({
	itemType = tbType.VuKhi.PhiDao,  -- Chi loc vk
	[115] = 20, -- toc do danh (ngoai cong)
	[125] = 5, -- doc sat ngoai cong
})
ThemSetDoByType({
	itemType = tbType.VuKhi.TuTien,  -- Chi loc vk
	[115] = 20, -- toc do danh (ngoai cong)
	[125] = 5, -- doc sat ngoai cong
})

-- 
-- Non Moc Nam
ThemSetDoByType({
	itemType = tbType.Non.Nam,
	[103] = 30, -- khang loi
	[85] = 160, -- sinh luc
})
-- Non Moc Nu
ThemSetDoByType({
	itemType = tbType.Non.Nu,
	[103] = 30, -- khang loi
	[85] = 120, -- sinh luc
})
-- Ao 
--thuy - nam
ThemSetDoByType({
	itemType = tbType.Ao.Nam,
	[113] = 40, -- thoi gian phuc hoi
    [102] = 25, -- khang hoa
})
--thuy - nu
ThemSetDoByType({
	itemType = tbType.Ao.Nu,
	[113] = 40, -- thoi gian phuc hoi
    [102] = 5, -- khang hoa
}) 
-- Dai lung Kim
ThemSetDoByType({
	itemType = tbType.DaiLung.TatCa,
	[101] = 25, -- khang doc
	[85] = 120, -- sinh luc
})
-- Giay Hoa

ThemSetDoByType({
	itemType = tbType.Giay.Nam,
    [111] = 40, -- toc do di chuyen
	[104] = 20, -- ptvl
	
})

ThemSetDoByType({
	itemType = tbType.Giay.Nu,
    [111] = 40, -- toc do di chuyen
	[104] = 25, -- ptvl
	[106] = 40, -- tg lam cham
})
-- Day Chuyen
--Thuy Nam
ThemSetDoByType({
	itemType = tbType.DayChuyen.Nam,
	--[114] = 10, -- khang tat ca
	[102] = 20, -- khang hoa
	
})
ThemSetDoByType({
	itemType = tbType.DayChuyen.Nam,
	[114] = 10, -- khang tat ca
	[102] = 5, -- khang hoa
	
})
--Thuy Nu
ThemSetDoByType({
	itemType = tbType.DayChuyen.Nu,
	[114] = 20, -- khang tat ca
	[102] = 5, -- khang hoa
	
})
--- Bao Tay
--Tho -- Nam
ThemSetDoByType({
	itemType = tbType.BaoTay.Nam,
	[105] = 25, -- khang bang
})
--Tho --nu
ThemSetDoByType({
	itemType = tbType.BaoTay.Nu,
	[105] = 25, -- khang bang
})

--- Ngoc Boi
--Tho Nam
ThemSetDoByType({
	itemType = tbType.NgocBoi.Nam,
	[105] = 15, -- khang bang
	-- [110] = 40, -- tg lam choang
	-- [99] = 20, -- sinh khi
})
--Tho Nu
ThemSetDoByType({
	itemType = tbType.NgocBoi.Nu,
	[105] = 20, -- khang bang
	-- [110] = 40, -- tg lam choang
	-- [99] = 20, -- sinh khi
})
-- Nhan ----------
ThemSetDoByType({
	itemType = tbType.Nhan.TatCa,
	[139] = 1, -- ky nang von co
})
--hoa
ThemSetDoByType({
	itemType = tbType.Nhan.TatCa,
	[104] = 5, -- ptvl
	-- [106] = 40, -- tg lam cham
})
-- Kim
ThemSetDoByType({
	itemType = tbType.Nhan.TatCa,
	[101] = 15, -- khang doc
})

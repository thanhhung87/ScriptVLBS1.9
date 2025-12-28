
-- Global Vari ---------------------------------------------
-- log do theo set
gl_LocDoTheoSet = 1

-- khi gl_LocDoTheoSet = 0 se tu dong giu lai Item co so dong VIP tuong ung
gl_SoDongVip = 5

-- loc do theo ngu hanh dong an -1 -2 -3. Chi co tac dung khi da loc duoc do VIP
gl_LocDoNguHanh = 0

-- toc do click menu
gl_menuClickSpeed = 30

-- gui do vao ruong
gl_GuiDo = false

-- che do debug
gl_Debug = false

-- quang cao kenh the gioi
gl_QuangCao = false -- muon tat thi set la false

-- Chat nham linh ta linh tinh
gl_ChatNham = false -- muon tat thi set la false

-- So luong Item xanh moi luot nhan toi da (ap dung cho ham NhanDoXanh() tu phien ban 2.3.2 tro di )
gl_SoluongItem = 10

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
	},
	
	-- Ngoc boi/Day chuyen (amulet.txt) - ItemGenre=0, DetailType=4
	NgocBoi = {
		TatCa = {nGenre = 0, nDetail = 9},
	},
	
	-- Giay (boot.txt) - ItemGenre=0, DetailType=5
	Giay = {
		TatCa = {nGenre = 0, nDetail = 5},  -- Dinh nghia chung cho tat ca giay
	},
	
	-- Non/Mu (helm.txt) - ItemGenre=0, DetailType=7
	Non = {
		TatCa = {nGenre = 0, nDetail = 7}, -- Tat ca non/mu
	},
	
	-- Nhan (ring.txt) - ItemGenre=0, DetailType=3
	Nhan = {
		TatCa = {nGenre = 0, nDetail = 3, nParticular = 0},    -- Tat ca nhan (Hoang Ngoc Gioi Chi, Cam Lam Thach, ...)
	},
	
	-- Dai lung (belt.txt) - ItemGenre=0, DetailType=6
	DaiLung = {
		TatCa = {nGenre = 0, nDetail = 6}, -- Tat ca dai lung
	},
	
	-- Bao tay/Ho uyen (cuff.txt) - ItemGenre=0, DetailType=8
	BaoTay = {
		TatCa = {nGenre = 0, nDetail = 8},  -- Dinh nghia chung cho tat ca bao tay/ho uyen
	},
	DayChuyen = {
		TatCa = {nGenre = 0, nDetail = 4},  -- Dinh nghia chung cho tat ca ngoc boi/day chuyen
	},
}
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







tbthuocTinh = {
    [43] = 1, -- khong the pha huy
	[58] = 2, -- bo qua ne tranh
	[85] = 180, -- sinh luc
	[89] = 180, -- noi luc
	[93] = 180, -- the luc
	[97] = 20, -- suc manh
	[98] = 20, --than phap
	[99] = 20, -- sinh khi
	[88] = 5, -- phuc hoi sinh luc moi nua giay
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
	[117] = 19, -- phan don can chien
	[135] = 1, -- may man %
	[121] = 50, -- stvl diem (dong an)
	[122] = 100, -- hoa sat ngoai cong
	[123] = 100, -- bang sat ngoai cong
	[124] = 100, -- loi sat sat ngoai cong
	[125] = 50, -- doc sat ngoai cong
	[126] = 100, -- stvl % (dong hien)
	[134] = 13, -- chsttnl
	[136] = 8, -- hut sinh luc
	[137] = 8, -- hut noi
	[139] = 1, -- ky nang cua phai do duoc cong them
	[166] = 300, -- ti le cong kich chinh xac
	[168] = 200, -- stvl noi cong
	[169] = 200, -- bang sat noi cong
	[170] = 200, -- hoa sat noi cong
	[171] = 200, -- loi sat noi cong
	[172] = 50,  -- doc sat noi cong
}

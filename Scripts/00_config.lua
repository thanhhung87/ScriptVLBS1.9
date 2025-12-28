
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

tbThuocTinh = {
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
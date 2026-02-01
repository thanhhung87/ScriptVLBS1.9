szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)


datau_Name = "D· TÈu Vozer"
tinvatdatau_Name = "TÝn VËt D· TÈu"
dungTinVatDaTau = function ()
    -- while true do
    --     if tbVulanLib.CountItem(3,tinvatdatau_Name) < 1 then
    --         system.Print("<color=yellow>khong T×m thÊy: tin vat da tau")
    --         return
            
    --     end
     
    --     timer.Sleep(3000)
    --     tbVulanLib.UseItemName(tinvatdatau_Name)
    --     system.Print("<color=yellow>keet thuc")
    -- end
    -- system.Print("<color=yellow>keet thuc")
    -- -- timer.Sleep(1000)
    -- -- tbVulanLib.UseItemName(tinvatdatau_Name)
	-- player.PathMoveTo(0,0,datau_Name);
    -- timer.Sleep(500)
    while true do
        tbVulanLib.TalkToNpc(datau_Name,1)
        tbVulanLib.WaitMenuTimeOut(1,2)
        system.Print("<color=yellow>tim click 1") 
        -- -- timer.Sleep(1000);
        if system.MatchString(menu.GetText(1, 0), "§­¬ng nhiªn, mau cho ta biÕt nhiÖm vô tiÕp theo lµ g×") == 1 then 
            menu.ClickIndex(1, 0) 
            system.Print("<color=yellow>click 1s")
        end

        tbVulanLib.WaitMenuTimeOut(2,2)  
        -- -- timer.Sleep(1000);
    
        -- menu.ClickIndex(i, 0)
        system.Print("<color=yellow>tim click 2")
        -- if tbVulanLib.CountItem(3,tinvatdatau_Name) > 0 then
        --     system.Print("<color=yellow>T×m thÊy: tin vat da tau")
        --     tbVulanLib.UseItemName(tinvatdatau_Name)
        --     tbVulanLib.WaitMenuTimeOut(1,2)
        --     menu.ClickIndex(1, 0)
        -- end
       
        menu.ClickIndex(0, 4)
   
     
        timer.Sleep(500)
        menu.ClickIndex(1, 0)
        tbVulanLib.TalkToNpc(datau_Name)
        -- for i = 0, 10 do
        timer.Sleep(500);
        menu.ClickIndex(1, 1)
        system.Print("<color=yellow>da kicl phan thuong")
    end
    

end

function main()
   dungTinVatDaTau()
end

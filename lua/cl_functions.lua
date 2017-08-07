

function cusHud.funcs.saveDesign(design)
	cusHud.sql.reloadDB()
	for k,element in pairs(design) do
		
		local eX, eY = element.pan:GetPos()
		local eZ = element.pan:GetZPos()
		local eWide = element.pan:GetWide()
		local eTall = element.pan:GetTall()
		local col = Color(255,255,255,255)
		if v.colOp == "BackgroundColor" then
			col = v.pan:GetBackgroundColor()
		elseif v.colOp == "text" then
			col = v.pan:GetChildren()[1].GetTextColor()
		end
		
		
		local varTabl = {x = eX, y = eY, z = eZ, sX = eWide, sY = eTall, color = col, op = v.op}
		
		cusHud.sql.save(varTabl)
		
	end
end

function cusHud.funcs.loadDesign()
	local design = cusHud.sql.getDesign()
	if design == nil then
		cusHud.hudDisplay = {}
	else
		cusHud.hudDisplay = design
	end
end

--cusHud.hudDisplay.test = {x = 100, y=100, z=10, sX=600, sY =600, col = "255/255/255/255", op = "box"}
--cusHud.hudDisplay.box2 = {x = 400, y=500, z=10, sX=100, sY=100, col = "150/150/150/255", op = "box"}



hook.Add("HUDPaint", "drawCusHud", function()

	if table.Count(cusHud.createElement) == 0 then
		hook.Call("RegisterElements_Hud", nil, "")
	end
	
	
	
	
	if cusHud.edit then return end
	
	local zLimit = 1
	for k,v in pairs(cusHud.hudDisplay) do
		if tonumber(zLimit) < tonumber(v.z) then
			zLimit = v.z
		end
	end
	
	
	for i=0,zLimit do
		for k,v in pairs(cusHud.hudDisplay) do
			if tonumber(v.z) == i then
				cusHud.createElement[v.type](v)
			end
		end
	
		i = i + 1
	end
	
	
end)




local function save(tbl)
	//PrintTable(tbl)
	sql.Query("INSERT INTO surfHud (type, x,y,z,sX,sY,col) VALUES ('"..tbl.op.."',"..tbl.x..","..tbl.y..","..tbl.z..","..tbl.sX..","..tbl.sY..",'"..tbl.color.r.."/"..tbl.color.g.."/"..tbl.color.b.."/"..tbl.color.a.."')")
end

local function reloadDB()
	sql.Query("DROP TABLE surfHud")
	cusHud.sql.create()
end

local function getDesign()
	if sql.TableExists("surfHud") then
		local respon = sql.Query("SELECT * FROM 'surfHud'")
		return respon
	else
		return nil
	end
end

function cusHud.sql.create()
	local complete = sql.Query("CREATE TABLE IF NOT EXISTS surfHud (type VARCHAR(200), x BIGINT, y BIGINT, z BIGINT, sX BIGINT, sY BIGINT, col VARCHAR(40))")
end





concommand.Add("saveHud", function()
	
	PrintTable(cusHud.editDisplay)
		
	//sql.Query("DROP TABLE surfHud")
	//sql.Query("CREATE TABLE IF NOT EXISTS surfHud (type VARCHAR(200), x BIGINT, y BIGINT, z BIGINT, sX BIGINT, sY BIGINT, col VARCHAR(40))")
	
	reloadDB()
	
	for k,v in pairs(cusHud.editDisplay) do
		local x1,y1 = v.pan:GetPos()
		local z1 = v.pan:GetZPos()
		local sX1 = v.pan:GetWide()
		local sY1 = v.pan:GetTall()
		local col = Color(255,255,255,255)
		print(v.op)
		if v.op == "box" then
			col = v.pan:GetBackgroundColor()
		elseif v.op == "text" then
			col = v.pan:GetChildren()[1]:GetTextColor()
		elseif v.op == "curtime" then
			col = v.pan:GetChildren()[1]:GetTextColor()
		end
		print(col)
		local varTabl = {x = x1, y = y1, z = z1, sX = sX1, sY = sY1, op = v.op, color = col or Color(255,255,255,255)}
		
		save(varTabl)
	end
end)

concommand.Add("loadHud", function()
	
	local des = getDesign()
	PrintTable(des)
	if des ~= nil then
		cusHud.hudDisplay = des
	end
end)





function cusHud.sql.save(tbl)
	//PrintTable(tbl)
	sql.Query("INSERT INTO surfHud (type, x,y,z,sX,sY,col) VALUES ('"..tbl.op.."',"..tbl.x..","..tbl.y..","..tbl.z..","..tbl.sX..","..tbl.sY..",'"..tbl.color.r.."/"..tbl.color.g.."/"..tbl.color.b.."/"..tbl.color.a.."')")
end

function cusHud.sql.reloadDB()
	sql.Query("DROP TABLE surfHud")
	cusHud.sql.create()
end

function cusHud.sql.getDesign()
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



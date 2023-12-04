    print("por quanto tempo quer que a turtle minere?? (unit:block(s))")
		times = read()
		hbtimes = times -


	local mineral = {
		"minecraft:coal_ore",
		"minecraft:iron_ore",
		"minecraft:redstone_ore",
		"minecraft:gold_ore",
		"minecraft:lapis_ore",
		"minecraft:quartz_ore",
	}

	local special = {
		"minecraft:diamond_ore",
		"minecraft:emerald_ore",
		"minecraft:mossy_cobblestone",
		"minecraft:planks",
		"minecraft:fence",
		"minecraft:nether_brick",
		"minecraft:stone_slab",
		"minecraft:double_stone_slab",
		"minecraft:nether_brick_fence",
		"minecraft:nether_brick_stairs",
		"minecraft:nether_wart",
	}

	local smsg = {
		"Encontra Diamante",
		"Encontra Esmeralda",
		"Encontra spawn de monstro",
		"Encontra mina abandonada",
		"Encontra mina abandonada",
		"Encontra fortaleza do nether",
		"Encontra fortaleza do nether",
		"Encontra fortaleza do nether",
		"Encontra fortaleza do nether",
		"Encontra fortaleza do nether",
		"Encontra fortaleza do nether",
	}

	local fluid = {
		"minecraft:water",
		"minecraft:flowing_water",
		"minecraft:lava",
		"minecraft:flowing_lava",
	}

	function go(side)
		if side == 0 then
			while not turtle.forward() do
				turtle.dig()
			end
		end
		
		if side == 1 then
			turtle.turnLeft()
			while not turtle.forward() do
				turtle.dig()
			end
			turtle.turnRight()
		end
		
		if side == 2 then
			while not turtle.back() do
				turtle.turnLeft()
				turtle.turnLeft()
				turtle.dig()
				turtle.turnRight()
				turtle.turnRight()
				turtle.turnRight()
			end
		end
		
		if side == 3 then
			turtle.turnRight()
			while not turtle.forward() do
				turtle.dig()
			end
			turtle.turnLeft()
		end
		
		if side == 4 then
			while not turtle.up() do
				turtle.digUp()
			end
		end
		
		if side == 5 then
			while not turtle.down() do
				turtle.digDown()
			end
		end
	end

	function compare(side)
		if side == 0 then
			success, data = turtle.inspect() 
			
			if success then 
				for i = 1, table.getn(fluid) do
					if data.name == fluid[i] then
						place(0, isearch("minecraft:cobblestone"))
					end
				end
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						x, y, z = gps.locate()
						asmsg = smsg[i].."x:"..x.." y:"..y.." z:"..z
						alert(asmsg)
						asmsg = "nil"
						data = "nil"
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if data.name == mineral[i] then
						data = "nil"
						return true
					end
				end
			else
				return false
			end
			
			return false
		end
		
		if side == 4 then		
			success, data = turtle.inspectUp() 
			
			if success then 
				for i = 1, table.getn(fluid) do
					if data.name == fluid[i] then
						place(4, isearch("minecraft:cobblestone"))
					end
				end
			
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						asmsg = smsg[i].."x:"..x.." y:"..y.." z:"..z
						alert(asmsg)
						asmsg = "nil"
						data = "nil"
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if data.name == mineral[i] then
						data = "nil"
						return true
					end
				end
			else
				return false
			end
			
			return false
		end
		
		if side == 5 then
			success, data = turtle.inspectDown() 
			
			if success then 
				for i = 1, table.getn(fluid) do
					if data.name == fluid[i] then
						place(5, isearch("minecraft:cobblestone"))
					end
				end
				
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						asmsg = smsg[i].."x:"..x.." y:"..y.." z:"..z
						alert(asmsg)
						asmsg = "nil"
						data = "nil"
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if data.name == mineral[i] then
						data = "nil"
						return true
					end
				end
			else
				return false
			end
			
			return false
		end
	end

	function dig(side)
		if side == 0 then
			turtle.dig()
		end
	
		if side == 1 then
			turtle.turnLeft()
			turtle.dig()
			turtle.turnRight()
		end
		
		if side == 2 then
			turtle.turnLeft()
			turtle.turnLeft()1
			turtle.dig()
			turtle.turnRight()
			turtle.turnRight()
		end
		
		if side == 3 then
			turtle.turnRight()
			turtle.dig()
			turtle.turnLeft()
		end
		
		if side == 4 then
			turtle.digUp()
		end
		
		if side == 5 then
			turtle.digDown()
		end
	end

	function dfs(side)
		if side == 0 then
			if compare(0) == "special" then
				return "special"
			end
			
			for i = 1, 4 do
				if compare(0) then
					dig(0)
					go(0)
					
					dfs(0)
					dfs(1)
					dfs(2)
					
					go(2)
					place(0, isearch("minecraft:cobblestone"))
				end
				turtle.turnLeft()
			end
		end
		
		if side == 1 then
			if compare(4) == "special" then
				return "special"
			end
			
			if compare(4) then
				dig(4)
				go(4)
				
				dfs(0)
				dfs(1)
				dfs(2)
				
				go(5)
				place(4, isearch("minecraft:cobblestone"))
			end
		end
		
		if side == 2 then
			if compare(5) == "special" then
				return "special"
			end
			
			if compare(5) then
				dig(5)
				go(5)
				
				dfs(0)
				dfs(1)
				dfs(2)
				
				go(4)
				place(5, isearch("minecraft:cobblestone"))
			end
		end
	end

	function place(side, grid)
		if side == 0 then
			turtle.select(grid)
			turtle.place()
		end
		
		if side == 1 then
			turtle.turnLeft()
			turtle.select(grid)
			turtle.place()
			turtle.turnRight()
		end
		
		if side == 2 then
			turtle.turnLeft()
			turtle.turnLeft()
			turtle.select(grid)
			turtle.place()
			turtle.turnRight()
			turtle.turnRight()
		end
		
		if side == 3 then
			turtle.turnRight()
			turtle.select(grid)
			turtle.place()
			turtle.turnLeft()
		end
		
		if side == 4 then
			turtle.select(grid)
			turtle.placeUp()
		end
		
		if side == 5 then
			turtle.select(grid)
			turtle.placeDown()
		end
	end

	function alert(message)
		rednet.open("right")
		rednet.broadcast(message)
	end

	function isearch(iname) 
		for i = 1, 16 do
			local data = turtle.getItemDetail(i)
			if data then
				if iname == data.name then
					iname = "nil"
					data = "nil"
					return i
				end
			end
		end
		return false
	end


for i = 1, 1 do
	alert("Starting mining...")

	for i = 1, times do
		dig(0)
		go(0)
		dig(4)
		dfs(0)
		dfs(2)
	end

	alert("Start backing...")

	turtle.turnLeft()
	turtle.turnLeft()
	go(4)
	place(5, isearch("minecraft:torch"))


	for i = 1, hbtimes do
		go(0)
		dfs(0)
		dfs(1)
	
		if i%8 == 0 then
			place(5, isearch("minecraft:torch"))
		end
	end

	turtle.turnLeft()
	turtle.turnLeft()
	go(5)
end

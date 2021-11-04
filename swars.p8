pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
--variables/init
p={}
p.x=5
p.y=5
lastimer = 0
s=1 --sprite number
d=4 --delay between sprite change
saniply=false --dont play animation when still

--a list for the lasers in the game
lasers = {}

function _init()
	new_ti(20,20)
end
-->8
--draw
function _draw()
	cls()
	draw_enemies()
	for o in all(lasers) do o:draw() end
	map()
	spr(s,p.x,p.y)
end

--function for drawing objects
function laserdraw(o)
	spr(o.spr,o.x,o.y)
end

--moves bullest a little bit at a time
function laserupdate(b)
	b.x += b.dx --x moves by dx every frame
	b.y -= b.dy --y moves by dy every frame
	b.time -= 1 --if the laser has exsited for too long, delete it
	return b.time > 0 --returns true if still alive
end

--creates a new laser
function newlaser(x,y,w,h,dx,dy)
	local b = { --only use b in this function
	x=x,y=y,dx=dx,dy=dy,
	w=w,h=j,
	time=60, --how long a bullet will last
	update=laserupdate, --putting function in table
	spr=4,draw=laserdraw
	}
	add(lasers,b)
	return b --if a laser is special we can adjust it
end
-->8
--update
function _update()
	saniply=false
	
	if lastimer > 0 then
		lastimer -= 1 
	else
		lastimer = 0
	end

	if btn(⬅️) then p.x-=1 saniply=true end
	if btn(➡️) then p.x+=1 saniply=true end
	if btn(⬆️) then p.y-=1 saniply=true end
	if btn(⬇️) then p.y+=1 saniply=true end
	if btn(❎) then createlas() end
	
	--update sprite animation
	if saniply then shipani() else s=1 end
	
	--if anyone moves offscreen
	wrap()
	wrap_enemies()
	
	--update enemy ships
	update_enemies()
	
	local i,j=1,1 --properly support deleting items
	while(lasers[i]) do
		if lasers[i]:update() then
			if(i!=j) lasers[j]=lasers[i] lasers[i]=nil --shifts object if necessary
			j+=1
		else lasers[i]=nil end --remove lasers that have died or timed out
			i+=1 --go to the next object
	end
end

function starttimer()
 lastimer = 30
end

function wrap()
	-- handle if character moves
	-- offscreen
	if p.x>127 then p.x=-8 end
	if p.x<-8 then p.x=127 end
	if p.y>127 then p.y=-8 end
	if p.y<-8 then p.y=127 end
end

function shipani()
	--update sprite animation
	d-=1
	if d<0 then
		s+=16
		if s>49 then s=1 end
		d=4
	end
end

function createlas()
	if lastimer == 0 then
			newlaser(p.x,p.y,4,4,0,2)
			starttimer()
		end
end
-->8
--enemies
tis={}
function new_ti(x,y)
	local enship={}
		enship.x=x
		enship.y=y
		enship.type="ti"
		enship.spr=2
		enship.hp=4
	tis[#tis+1]=enship
end

function update_enemies()
	for m in all(tis) do
		m.x+=1
	end
end

function draw_enemies()
	for mob in all(tis) do
		spr(mob.spr, mob.x, mob.y)
	end
end

function wrap_enemies()
	-- handle if enemy moves
	-- offscreen
	for m in all(tis) do
		if m.x>127 then m.x=-8 end
		if m.x<-8 then m.x=127 end
	end
end
__gfx__
0000000000000000d000000d00888800000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000
00000000000dd00060000006089aa9800000000000000000000000000000000000000000f0000000000000000000000000000000000000000000000000000000
00700700d006600d60d77d0689a77a98e000000e0030030000000000000001000000000000007000000010000000000000000000000000000000000000000000
00077000500cc0057d6556d78a7777a8e000000e00b00b0000000000010000000000000000000000f00000000000000000000000000000000000000000000000
0007700076d77d67d5d00d5d8a7777a8e000000e00b00b0000000000000000000000000000f00000000000000000000000000000000000000000000000000000
0070070055adda55d05dd50d89a77a988000000800b00b0000000000000000000000000000000000000000100000000000000000000000000000000000000000
000000006dddddd6d000000d089aa98000000000000000000000000000000f000000000000000f000d0000000000000000000000000000000000000000000000
0000000000a00a005000000500888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d006600d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000500cc0050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000076d77d670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000559dda550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000006dddddd60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000a009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d006600d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000500cc0050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000076d77d670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000055adda550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000006dddddd60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000a00a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d006600d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000500cc0050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000076d77d670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000055add9550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000006dddddd60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000900a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0a0000070606060700070700000a00000a000007060606070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06060a060607060606060606060a0a0a06060a06060706060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060606060606090a070606060606060606060606060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060706060a06060607060a0a0606060a060706060a0606060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060606070606060606060a060006060606060607060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060607060606060007060606060606060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0606060a06060a0006000006060606090606060a06060a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070706060a0606060707070707070707070706060a0606060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0000070606060700070700000a0a0000070606060700070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06060a060607060606060606060a06060a060607060606060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060606060606090a070606060606060606060606090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060706060a06060607060a0a0606060706060a06060607060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0000070606060700070700000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06060a060607060606060606060a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060606060606090a070606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060706060a06060607060a0a0606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060606070606060606060a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0706060606060606060607060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

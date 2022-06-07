local json = require("json")
local coro = require("coro-http")
command.Register("server", "server info", function(msg, args)

local id = "14926382" -- battlemetrics server idnizi girin , https://www.battlemetrics.com/servers/gmod/14926382
local link = ("https://api.battlemetrics.com/servers/"..id) 
local result , body = coro.request("GET", link)

body = json.parse(body)
if body.data.attributes.country == "DE" then
	flag = ":flag_de:"
elseif body.data.attributes.country == "TR" then
	flag = ":flag_tr:"
elseif body.data.attributes.country == "FR" then
	flag = ":flag_fr:"
elseif body.data.attributes.country == "US" then
	flag = ":flag_us:"
elseif body.data.attributes.country == "GB" then
	flag = ":flag_gb:"
elseif body.data.attributes.country == "GB" then
	flag = ":flag_gb:"
elseif body.data.attributes.country == "CA" then
	flag = ":flag_ru:"
else flag = ":globe_with_meridians:"
end
if body.data.attributes.status == "online" then
	Status = "Sunucu Aktif"
elseif body.data.attributes.status == "offline" then
		Status = "Sunucu Kapalı"
end	

msg.channel:send{
embed = {
title = body.data.attributes.name;
fields = {
	{name = "Sunucu Adresi"; value = body.data.attributes.ip..":"..body.data.attributes.port.." "..flag},
	{name = "Oyuncu Sayısı"; value = body.data.attributes.players.."/"..body.data.attributes.maxPlayers},
	{name = "Harita"; value = body.data.attributes.details.map},
			},
footer = {text = Status },
color = 0x0000ff

		}
	}

end)

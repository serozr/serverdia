local json = require("json")
local coro = require("coro-http")
local id = "9756869" -- battlemetrics server idnizi girin , https://www.battlemetrics.com/servers/gmod/14926382
local link = ("https://api.battlemetrics.com/servers/"..id) 
local result , body = coro.request("GET", link)
body = json.parse(body)

CLIENT:on('ready', function()
    CLIENT:setGame("Sunucuda "..body.data.attributes.players.."/"..body.data.attributes.maxPlayers.." Oynuyor")
  end)
local sql = require("sqlite3")
local SQL = {}

SQL.name = "sql" 
SQL.con = sql.open("master.db")

function SQL.Query(q)
	return SQL.con:exec(q)
end

function SQL.Escape(q)
	q = string.gsub(q, "'", "''")

	return q
end

function SQL.TableExists(n)
	return SQL.Query(string.format("SELECT name FROM sqlite_master WHERE type='table' AND name='%s';", SQL.Escape(n))) and true or false
end

return SQL
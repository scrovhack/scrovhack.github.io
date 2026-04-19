local cjson = require "cjson"

local response = {
  runtime = "Lua",
  message = "Hello from Lua",
  time = os.date("!%Y-%m-%dT%H:%M:%SZ")
}

print(cjson.encode(response))

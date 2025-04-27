local url = require("socket.url")
local http = require("socket.http")
local ltn12 = require("ltn12")
local dkjson = require("dkjson")

-- Rest of your code

local function load_api_key(filepath)
  local file, err = io.open(filepath, "r")
  if not file then
    print("Error opening API key file:", err)
    return nil
  end

  local api_key = file:read("*a")
  file:close()
  if api_key then
      return api_key:match("^%s*(.-)%s*$") --remove whitespace
  else
      return nil
  end
end

local api_key = load_api_key("../../code1/ha1falcon")

if api_key then
    -- local request_body = [[filetype=python]]
    local data1 = 'hash=dbba6444431852492c3d337f1cd2f22cce00536629b5ebabaafd2c23b3f0ba5e' -- well, that is a random hash for testing

    local request_body = data1
    print(request_body)
    local response_body = {}

    local res, code, response_headers = http.request{
        url = "https://hybrid-analysis.com/api/v2/search/hash",
        method = "POST",
        headers =
        {
            ["Content-Type"] = "application/x-www-form-urlencoded";
            ["Content-Length"] = #request_body;
            ["api-key"] = api_key;
            ["accept"] = "application/json";
        },
        source = ltn12.source.string(request_body),
        sink = ltn12.sink.table(response_body),
    }

    if code == 200 then
        local response_body2 = table.concat(response_body)
        local decoded_response = dkjson.decode(response_body2)
        print(dkjson.encode(decoded_response, { indent = true }))
    else
        print("API request failed:", code, status)
        print(dkjson.encode(headers_response, { indent = true }))
    end
end

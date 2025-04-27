local url = require("socket.url")
local http = require("socket.http")
local ltn12 = require("ltn12")
local dkjson = require("dkjson")

-- Functions related to saving output

    -- here it saves whole json file
local function save_json_to_file(data, filename)
  local file, err = io.open(filename, "w")
  if not file then
    print("Error opening JSON file: " .. err)
    return
  end

  local json_string = dkjson.encode(data, { indent = true })
  file:write(json_string)
  file:close()
  print("JSON data saved to " .. filename)
end

    -- here it saves just the sha256 hash
local function save_hash_to_file(hash_value, filename)
  local file, err = io.open(filename, "w")
  if not file then
    print("Error opening hash file: " .. err)
    return
  end

  file:write("hash=" .. hash_value)
  file:close()
  print("Hash saved to " .. filename)
end

-- api key loading
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


-- if api key is valid, do actual functionality
if api_key then
    -- local request_body = [[filetype=python]]
    -- here are parameters of api call
    local data1 = {
            filetype = "",
            port = "",
            imp_hash = "",
            vx_family = "",
            domain = "",
            filename = "",
            host = "",
            uses_tactic = "Exfiltration",
            date_to = "",
            ssdeep = "",
            env_id = "140",
            av_detect = "0",
            similar_to = "",
            url = "",
            context = "",
            authentihash = "",
            filetype = "",
            country = "",
            verdict = "5",
            filetype_desc = "",
            tag = "",
            date_from = "",
            uses_technique = "",
            }
    -- here it takes it apart and puts it together into right format
    local parts = {}
    for key, value in pairs(data1) do
        if value ~= "" then
            table.insert(parts, key .. "=" .. value)
        end
    end

    local data2 = table.concat(parts, "&")

    local request_body = data2
    print(request_body)
    local response_body = {}

    -- here it goes through the request towards hybrid-analysis api
    local res, code, response_headers = http.request{
        url = "https://hybrid-analysis.com/api/v2/search/terms",
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
        save_json_to_file(decoded_response, "output.json")
    else
        print("API request failed:", code, status)
        print(dkjson.encode(headers_response, { indent = true }))
    end

end

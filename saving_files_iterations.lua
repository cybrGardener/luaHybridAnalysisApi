-- testing function to save output in different ways

local function save_json_to_file(json_data, filename)
  local file, err = io.open(filename, "w")
  if not file then
    print("Error opening file: " .. err)
    return
  end

  local json = require("json")
  local formatted_json = json.encode(json_data, { indent = true }) -- Add indentation for readability
  file:write(formatted_json)
  file:close()
  print("JSON saved to " .. filename)
end

local function process_api_output(api_output)
  local json = require("json")
  local data = json.decode(api_output)

  if not data or not data.result then
    print("Invalid API output format.")
    return
  end

  -- Task 1: Saving each JSON object to a separate file
  for i, item in ipairs(data.result) do
    local filename = "json" .. i .. ".json"
    save_json_to_file(item, filename)
  end

    -- Iterate through all sha256 hashes and save them in the specified format
  local hash_list = {}
  for _, item in ipairs(data.result) do
    if item.sha256 then
      table.insert(hash_list, "hashes%5B%5D=" .. item.sha256)
    end
  end

  local formatted_hashes = table.concat(hash_list, "&")

  local formatted_filename = "formatted_hashes.txt"
  local formatted_file, err = io.open(formatted_filename, "w")
  if not formatted_file then
    print("Error opening formatted hash file: " .. err)
    return
  end

  formatted_file:write(formatted_hashes)
  formatted_file:close()
  print("Formatted hashes saved to " .. formatted_filename)
end

local api_output = [[
{
  "search_terms":[{
    "value":"140",
    "id":"env_id"
  },{
    "value":"5",
    "id":"verdict"
  },{
    "value":"Exfiltration",
    "id":"uses_tactic"
  },{
    "value":"0",
    "id":"av_detect"
  }],
  "count":50,
  "result":[{
    "submit_name":"mboxview64.exe",
    "environment_description":"Windows 11 64 bit",
    "threat_score":63,
    "job_id":"67dc4faa89e401cef40f05fa",
    "sha256":"1e555738ceaba6c6f7a766f504a189fee66baace7b9b06e100a1ba94a8b0fed0",
    "type_short":"64-bit exe",
    "av_detect":"0",
    "size":7103488,
    "verdict":"malicious",
    "analysis_start_time":"2025-03-20 17:27:44",
    "environment_id":140
  },{
    "submit_name":"PC372A Keyboard Setup V1.6.6 20220722.exe",
    "environment_description":"Windows 11 64 bit",
    "threat_score":100,
    "job_id":"67dc2949ab56786afd025036",
    "sha256":"b522d4eab0a1e866a10b6459a52dd6daf23d0678bf0645235352c89afb4b2f75",
    "type_short":"exe",
    "av_detect":"0",
    "size":2883758,
    "verdict":"malicious",
    "analysis_start_time":"2025-03-20 14:42:19",
    "environment_id":140
  },{
    "submit_name":"XENX_Driver_Installer_1.3.2_x64.exe",
    "environment_description":"Windows 11 64 bit",
    "threat_score":100,
    "job_id":"67dc1b84e7df0fce1e0eb9f9",
    "sha256":"456411a8d910dda1a10ada828e1599bdf3b0c868f62097ae82988a1bd0e6701b",
    "type_short":"exe",
    "av_detect":"0",
    "size":62849195,
    "verdict":"malicious",
    "analysis_start_time":"2025-03-20 13:43:44",
    "environment_id":140
  },{
    "submit_name":"DaluxBoxSync_4.2.0.msi",
    "environment_description":"Windows 11 64 bit",
    "threat_score":85,
    "job_id":"67dc08d36f506b43ac00ae13",
    "sha256":"16a17785c51d88a34360f35f8c198e442f401a86f1c74a350a0a3ce5cd34cdfd",
    "type_short":"msi",
    "av_detect":"0",
    "size":4759552,
    "verdict":"malicious",
    "analysis_start_time":"2025-03-20 12:27:19",
    "environment_id":140
  }]
}
]]

process_api_output(api_output)

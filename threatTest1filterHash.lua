function filterAll(filepath)
  local file, err = io.open(filepath, "r")
  if not file then
    print("Error opening file:", err)
    return nil
  end

  local json_string = file:read("a") -- Read the entire file content
  file:close()

  local dkjson = require("dkjson")
  local data, err = dkjson.decode(json_string)
  if not data then
    print("Error decoding JSON:", err)
    return nil
  end

  local results = {}
  if type(data) == "table" and data.result then
    for _, item in ipairs(data.result) do
      if type(item) == "table" and item.submit_name and item.sha256 and item.threat_score then
        table.insert(results, {
          submit_name = item.submit_name,
          sha256 = item.sha256,
          threat_score = tonumber(item.threat_score)
                  })
      end
    end
  end
  return results
end

-- Sorting here
local function compare_results(a, b)
    -- Sort by Threat Score in descending order
    if a.threat_score > b.threat_score then
        return true
    elseif a.threat_score < b.threat_score then
        return false
    else
        -- If Threat Scores are equal, sort by the first three letters of Submit Name alphabetically, change them all to lower
        local name_a = string.sub(a.submit_name, 1, 3):lower()
        local name_b = string.sub(b.submit_name, 1, 3):lower()
        return name_a < name_b
    end
end

-- Usage here:
local filepath = "output.json" -- Replace with the actual path to your JSON file

local extracted_data = filterAll(filepath)

if extracted_data then
  -- Sort things
  table.sort(extracted_data, compare_results)
  -- Print the extracted data
  for i, item in ipairs(extracted_data) do
    print(i .. ". Submit Name: " .. item.submit_name .. ", SHA256: " .. item.sha256 .. ", Threat Score: " .. item.threat_score)
  end
end

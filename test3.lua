-- that is the data input I am using right now - 04.2025

local data = {
  filetype = "",
  port = "",
  imp_hash = "",
  vx_family = "",
  domain = "",
  filename = "",
  host = "",
  uses_tactic = "TA0005",
  date_to = "",
  ssdeep = "",
  env_id = "",
  av_detect = "0-30",
  similar_to = "",
  url = "",
  context = "",
  authentihash = "",
  filetype = "",
  country = "",
  verdict = "5",
  filetype_desc = "",
  tag = "",
  date_from = "2025-01-01",
  uses_technique = "",
}

local parts = {}
for key, value in pairs(data) do
  if value ~= "" then
    table.insert(parts, key .. "=" .. value)
  end
end

local result = table.concat(parts, "&")

print(result)


-- here I am testing some other tables schemes libraries and so on

local url = require("socket.url")
query = {
    scheme = "http",
    data = {
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
}
local request_body = url.build(query)

print(request_body)

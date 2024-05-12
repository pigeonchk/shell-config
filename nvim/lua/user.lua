if not _G.user then
    --[[
    -- user.username:          local username of the user.
    -- user.name:              public name of the user.
    -- user.email:             public email of the user.
    -- user.gitremote:         git remote address.
    -- user.gitrepos:          names of repositories in stored user.gitremote.
    -- user.prefer_liblicense: preferred license for libraries projects.
    -- user.prefer_binlicense: preferred license for binary projects.
    --]]
    _G.user = { }
end

function user.__index(tbl, key)
    local cached = ("_cached_%s").format(key)
    local v = rawget(tbl, cached)
    if not v then
        local simple = {
            username  = "USER",
            name      = "NAME",
            email     = "EMAIL",
            gitremote = "GITREMOTE",
            prefer_liblicense = "PREFER_LIB_LICENSE",
            prefer_binlicense = "PREFER_BIN_LICENSE",
        }

        local array = {
            gitrepos = "GITREMOTE_REPOS"
        }

        if simple[key] then
            v = vim.env[simple[key]]
        elseif array[key] then
            local arr = vim.env[simple[key]]
            v = arr and vim.split(arr, ':', {plain=true, trimempty=true})
        end

        rawset(tbl, cached, v)
    end

    return v
end

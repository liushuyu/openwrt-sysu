module("luci.controller.sysuh3c", package.seeall)

function index()
  if not nixio.fs.access("/etc/config/sysuh3c") then
    return
  end

  entry({"admin", "services", "sysuh3c"}, cbi("sysuh3c"), _("SYSU H3C"), nil).dependent = true
  entry({"admin", "status", "sysuh3c"}, call("action_sysuh3c_status")).leaf = true

end

function action_sysuh3c_status()
  local pid
  local data = {};
  pid = luci.sys.exec("pidof sysuh3c")
  luci.http.prepare_content("application/json")
  if pid ~= "" then
    data["run"] = luci.i18n.translate("Enabled")
    data["started"] = nixio.fs.stat("/var/run/sysuh3c.pid", "mtime") or -1
  else
    data["run"] = luci.i18n.translate("Disabled")
  end
  uci.cursor():foreach("sysuh3c", "auth", function(s)
      data["user"] = s["username"]
      return false
  end)
  luci.http.write_json(data)
end

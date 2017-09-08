local m, s, o

if luci.sys.call("pidof sysuh3c > /dev/null") == 0 then
  m = Map("sysuh3c", translate("SYSU H3C"), translate("SYSU H3C authenticator is <b>running</b>"))
else
  m = Map("sysuh3c", translate("SYSU H3C"), translate("SYSU H3C authenticator is <b>not running</b>"))
end

-- Network Settings
s = m:section(TypedSection, "network", translate("Network Settings"))
s.anonymous = true

o = s:option(Flag, "enabled", translate("Enable"))
o.default = 0
o.rmempty = false

o = s:option(ListValue, "ifname", translate("Interface"))
for i, v in ipairs(luci.sys.net.devices()) do
  if not (v == "lo" or v == "br-lan") then
    o:value(v)
  end
end

-- Authentication Settings

s = m:section(TypedSection, "auth", translate("Authentication Settings"))
s.anonymous = true

o = s:option(Value, "username", translate("User Name"))
o.rmempty = false

o = s:option(Value, "pwd", translate("Password"))
o.password = true
o.rmempty = false

o = s:option(ListValue, "method", translate("EAP-MD5 CHAP Method"))
o:value("md5")
o:value("xor")
o.rmempty = false
o.default = "xor"

return m

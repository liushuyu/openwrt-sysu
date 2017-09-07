--[[

LuCI mentohust
Author:tsl0922
Email:tsl0922@sina.com

]]--

require("luci.tools.webadmin")

m = Map("mentohust", translate("MentoHUST"), translate("A Ruijie and Cernet supplicant on Linux and MacOS from HustMoon Studio."))
function m.on_commit(self)
os.execute("/etc/init.d/mentohust start")
end

s = m:section(TypedSection, "option", translate("Start option"),translate("Configure mentohust's start option"))
s.anonymous = true

s:option(Flag, "enable", translate("MentoHUST_enable"), translate("enable or disable mentohust")).default="0"

s:option(Flag, "boot", translate("Start at boot"), translate("Start mentohust when the router boots.")).default="0"


s = m:section(TypedSection, "mentohust", translate("Config mentohust"),translate("The options below are all of mentohust's arguments."))
s.anonymous = true

s:option(Value, "Username", translate("Username")).default="xxx"

pw=s:option(Value, "Password", translate("Password"))
pw.password = true
pw.rmempty = false
pw.default= "xxx"

nic=s:option(ListValue, "Nic", translate("net card name"))
nic.anonymous = true
for k, v in pairs(luci.sys.net.devices()) do
	nic:value(v)
end


s:option(Value, "IP", translate("IP"),translate("default to localhost's IP")).default="0.0.0.0"

s:option(Value, "Mask", translate("netmask"),translate("default to localhost's netmask")).default="255.255.255.0"

s:option(Value, "Gateway", translate("gateway"),translate("default to 0.0.0.0")).default="0.0.0.0"

s:option(Value, "DNS", translate("DNS"),translate("default to 0.0.0.0")).default="0.0.0.0"

s:option(Value, "PingHost", translate("Ping host"),translate("default to 0.0.0.0,i.e. disable this function")).default="0.0.0.0"

s:option(Value, "Timeout", translate("authenticate timeout(s)"),translate("default to 8s")).default="8"

s:option(Value, "EchoInterval", translate("heartbeat timeout(s)"),translate("default to 30s")).default="30"

s:option(Value, "RestartWait", translate("wait on failure timeout(s)"),translate("default to 15s")).default="15"

s:option(Value, "MaxFail", translate("max failure times"),translate("0 means no limit,default to 8")).default="8"

s:option(Value, "dhcpscript", translate("DHCP script"),translate("use dhclient by default")).default="udhcpc -i"

return m

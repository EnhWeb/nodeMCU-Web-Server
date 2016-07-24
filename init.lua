if (file.open("credentials.txt", "r") == true) then
SSID = file.readline()
PASS = file.readline()
file.close()

SSID = string.gsub(SSID, "\n", "")
PASS = string.gsub(PASS, "\n", "")

PASS = crypto.decrypt("AES-ECB", "1[($72;#WsMP4Hs/", PASS)
end



local function isEmpty(t)
    if (t == nil or t == "") then
    return true
    end   
end

if (isEmpty(SSID) == true or isEmpty(PASS) == true) then
    dofile("APmode.lua")
else   
    wifi.setmode(wifi.STATION)
    wifi.sta.config(SSID,PASS)

    print("Connecting to " .. SSID .. "...")


    cnt = 10
    tmr.alarm(0,500,1,function()
        if wifi.sta.getip()==nil then
            cnt = cnt -1
            if cnt<=0 then
                tmr.stop(0)
                print("Connection failed. Check the credentials you are using.")
                node.restart()
            end
        else
            tmr.stop(0)
            print("Station connected to " .. SSID)
            wifi.sta.sethostname("NodeESPv7")
            print("Hostname is NodeESPv7.")
            ipAddress, nm, gw = wifi.sta.getip()
            print("IP Address: " .. ipAddress)
            print("Netmask: " .. nm)
            print("Gateway: " .. gw)
            print("RSSI: " .. wifi.sta.getrssi() .. " dBm") 
        end
    end)
end

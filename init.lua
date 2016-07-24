if (file.open("credentials.txt", "r") == true) then 
SSID = (file.readline())
if (SSID == nil) then
file.close()
else
PASS = crypto.decrypt("AES-ECB","1[($72;#WsMP4Hs/",(file.readline()))
file.close()
end
end

local function isEmpty(s) -- Checks if string is nil or empty
    if (s == nil or s == "") then
    return true
    end   
end

if (isEmpty(SSID) == true or isEmpty(PASS) == true) then
    dofile("APmode.lua")
else   
    
    SSID = string.gsub(SSID, "\n", "")
    PASS = string.gsub(PASS, "\n", "")
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
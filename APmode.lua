    wifi.setmode(wifi.SOFTAP)
    apConfig={}
    apConfig.ssid="NodeESPv7" -- Configure your AP SSID
    apConfig.pwd="RiTA#903724" -- Password
    wifi.ap.config(apConfig)
    ipConfig=
    {   
        ip="192.168.1.1",              -- Configure AP IP
        netmask="255.255.255.0",
        gateway="192.168.0.1"
    }
    wifi.ap.setip(ipConfig)
    print("SSID or Password not found. Starting in AP mode.")
    print("Connect to http://" .. ipConfig.ip .. " for setup.")

    dofile("APserver.lua")
    

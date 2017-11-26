print("###### LuckyHacker ######")
print(" - Loading ConnectWifi.lua")
dofile("ConnectWifi.lua")

print(" - Loading WebServer.lua")
dofile("WebServer.lua")

tmr.alarm(1,2000, 1, function() 
   if wifi.sta.getip()==nil then 
      print(" - Waiting for IP...") 
   else 
      print(" - IP: "..wifi.sta.getip()) 
      tmr.stop(1) 
   end 
end)

print(" - init.lua executed")
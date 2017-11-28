ControlHTML = [[
<!doctype html>
<html>
<head>
<title>LuckyCoffee</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
<style>
html, body {
	font-family: "Comic Sans MS", cursive, sans-serif;
	background-color: #fffdd0;
	margin: 0;
	padding: 0;
	height: 100%;
}

button {
	color:#fffdd0;
	font-size:20px;
	width:90%;
	margin-left:5%;
	margin-bottom:5px;
	height:5em;
	border-radius:10px;
	border-color:#593C1F;
}

h1 {
	text-align:center;
	color:#593C1F;
}

.neutralbutton {
	background-color: #593C1F;
}
</style>
<script>

</script>
</head>
<body>
<h1>LuckyCoffee:</h1>
<a href="?coffee=ON"><button class="neutralbutton">Go!</button></a>
</body>
</html>
]]

coffee_relay_timeout_ms = 50
us_to_ms = 1000
indentifier = "CoffeeNode"
coffee_gpio = 1
gpio.mode(coffee_gpio, gpio.OUTPUT);
gpio.write(coffee_gpio, gpio.LOW);
			
s = net.createServer(net.TCP)
s:listen(80,function(conn)
    conn:on("receive", function(client,request)
		URL = "http://" .. wifi.sta.getip()
		if (string.sub(request, 1, 7) == "restart") then
			print(" - remote - Restarting...")
			node.restart()
		elseif string.match(request, "/identify") then
			client:send(identifier)
		elseif string.match(request, "GET") then
			client:send(ControlHTML);
			if string.match(request, "?coffee=ON") then
				gpio.write(coffee_gpio, gpio.HIGH);
				tmr.delay(coffee_relay_timeout_ms * us_to_ms)
				gpio.write(coffee_gpio, gpio.LOW);
			end
		end
        client:close();
        collectgarbage();
    end)
end)

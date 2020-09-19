-- Autoreload this config file
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon config loaded")


-- Simple window edge snapping
snapKeys = {"cmd", "ctrl"}

hs.hotkey.bind(snapKeys, "H", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.x = 0
    win:setFrame(f)
end)

hs.hotkey.bind(snapKeys, "L", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.w - f.w
    win:setFrame(f)
end)

hs.hotkey.bind(snapKeys, "K", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.y = 0
    win:setFrame(f)
end)

hs.hotkey.bind(snapKeys, "J", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:fullFrame()

    f.y = max.h - f.h
    win:setFrame(f)
end)

hs.hotkey.bind(snapKeys, "I", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:fullFrame()

    f.x = (max.w / 2) - (f.w / 2)
    f.y = (max.h / 2) - (f.h / 2)
    win:setFrame(f)
end)


-- Prevent sleeping menubar item
local caffeineMenubar = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeineMenubar:setTitle("☕")
    else
        caffeineMenubar:setTitle("💤")
    end
end
caffeineMenubar:setClickCallback(function()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end)
setCaffeineDisplay(hs.caffeinate.get("displayIdle"))


-- Take image from webcam upon screen unlock
local snapCommand = '/usr/local/bin/imagesnap -q -w 5 ~/Pictures/snaps/$(date -u +%Y%m%dT%H%M%SZ).jpg'
local lastSnap = 0
local function timePassed() return (hs.timer.secondsSinceEpoch() - lastSnap) > hs.timer.hours(3) end
local activityWatcher = hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.screensDidUnlock and hs.screen.primaryScreen():name() == "Color LCD" and timePassed() then
      lastSnap = hs.timer.secondsSinceEpoch()
      os.execute(snapCommand)
    end
end)
activityWatcher:start()


-- Randomish MAC address depending on WiFi SSID
local wifiWatcher = hs.wifi.watcher.new(function()
    local wifiName = hs.wifi.currentNetwork()
    if wifiName then
        local hash = hs.hash.SHA256(wifiName .. os.date('%Y-%m-%d'))
        t = {}
        for i in string.gmatch(string.sub(hash, 0, 10), '%S%S') do
            table.insert(t, i)
        end
        macAddress = '02:' .. table.concat(t, ':')
        -- Make sure ifconfig is in sudoers with NOPASSWD
        os.execute("sudo ifconfig en0 ether " .. macAddress)
    end
end)
wifiWatcher:start()

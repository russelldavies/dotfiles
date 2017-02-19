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
local snapCommand = '[[ $(ioreg -r -k AppleClamshellState -d 4 |'..
'grep \'"AppleClamshellState" = No\') ]] &&'..
'imagesnap -q -w 5 ~/Pictures/snaps/$(date -u +%Y%m%dT%H%M%SZ).jpg &'
local lastSnap = 0
local powerStates = {}
local activityWatcher = hs.caffeinate.watcher.new(function(event)
    table.insert(powerStates, event)
    if event == hs.caffeinate.watcher.screensDidLock then
        powerStates = {}
    -- There are three wakeup events in quick succession
    elseif #powerStates == 3 and
            powerStates[1] == hs.caffeinate.watcher.screensDidWake and
            (hs.timer.secondsSinceEpoch() - lastSnap) > hs.timer.hours(1) then
        lastSnap = hs.timer.secondsSinceEpoch()
        hs.execute(snapCommand, true)
    end
end)
activityWatcher:start()


-- Lockscreen keyboard shortcut
hs.hotkey.bind({"cmd", "shift"}, "L", function()
    hs.caffeinate.lockScreen()
end)


-- Backup menu item
local backupMenubar = hs.menubar.new()
local backupEnabled = function() return os.execute('launchctl list local.backup') end
local toggleBackup = function(enabled)
    local action = 'load'
    if enabled then action = 'unload' end
    os.execute(string.format('launchctl %s ~/Library/LaunchAgents/local.backup.plist', action))
    return not enabled
end
local setbackupDisplay = function(enabled)
    icon = "💾"
    if not enabled then icon = icon .. "❌" end
    backupMenubar:setTitle(icon)
end
backupMenubar:setClickCallback(function()
    setbackupDisplay(toggleBackup(backupEnabled()))
end)
setbackupDisplay(backupEnabled())

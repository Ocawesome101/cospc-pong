-- pong! --

local input = require("common.input")

local w, h = term.getSize(2)

local ballX, ballY, ballDirX, ballDirY = 16, 16, 1, 1

local function drawBall()
  term.drawPixels(ballX - 4, ballY - 4, 0x0, 8, 8)
end

local function drawCenterLine()
  local y = math.floor(h/2)
  for i=0, w-1, 1 do
    local color = (i%4==1) and 0 or 15
    term.setPixel(i, y, color)
  end
end

term.setGraphicsMode(2)
local pressed = {}
local lastTimerID
while true do
  term.clear()
  drawBall()
  drawCenterLine()
  ballX = ballX + ballDirX
  ballY = ballY + ballDirY
  if ballX >= (w - 8) then
    ballDirX = -ballDirX
  elseif ballX <= 8 then
    ballDirX = -ballDirX
  end
  if ballY >= (h - 8) or ballY <= 8 then
    ballDirY = -ballDirY
  end
  
end

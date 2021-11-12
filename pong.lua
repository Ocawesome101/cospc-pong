-- pong! --

local input = require("common.input")

local w, h = term.getSize(2)

local numbers = {
  [0] = {
    "\15\0\0\15\15",
    "\0\15\15\0\15",
    "\0\15\15\0\15",
    "\0\15\15\0\15",
    "\15\0\0\15\15"
  }, {
    "\15\15\0\15\15",
    "\15\15\0\15\15",
    "\15\15\0\15\15",
    "\15\15\0\15\15",
    "\15\15\0\15\15",
  }, {
    "\0\0\0\15\15",
    "\15\15\15\0\15",
    "\15\15\0\15\15",
    "\15\0\15\15\15",
    "\0\0\0\0\15",
  }, {
    "\0\0\0\15\15",
    "\15\15\15\0\15",
    "\15\0\0\15\15",
    "\15\15\15\0\15",
    "\0\0\0\15\15",
  }, {
    "\0\15\0\15\15",
    "\0\15\0\15\15",
    "\0\0\0\0\15",
    "\15\15\0\15\15",
    "\15\15\0\15\15",
  }, {
    "\0\0\0\0\15",
    "\0\15\15\15\15",
    "\0\0\0\15\15",
    "\15\15\15\0\15",
    "\0\0\0\15\15",
  }, {
    "\15\0\0\0\15",
    "\0\15\15\15\15",
    "\0\0\0\15\15",
    "\0\15\15\0\15",
    "\15\0\0\25\15",
  }, {
    "\0\0\0\0\15",
    "\15\15\15\0\15",
    "\15\15\0\15\15",
    "\15\0\15\15\15",
    "\0\15\15\15\15",
  }, {
    "\15\0\0\15\15",
    "\0\15\15\0\15",
    "\15\0\0\15\15",
    "\0\15\15\0\15",
    "\15\0\0\15\15",
  }, {
    "\15\0\0\15\15",
    "\0\15\15\0\15",
    "\15\0\0\0\15",
    "\15\15\15\0\15",
    "\0\0\0\15\15",
  }
}

local ballX, ballY, ballDirX, ballDirY = 16, 16, 1, 1
local ballSpeed = 2
local paX, pbX = math.floor(w/2), math.floor(w/2)
local paddleWidth, paddleHeight = 16, 8

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

local function drawPaddles()
  term.drawPixels(paX - paddleWidth, 2, 0, paddleWidth*2, paddleHeight)
  term.drawPixels(pbX - paddleWidth, h-2-paddleHeight, 0,
    paddleWidth*2, paddleHeight)
end

local scoreA, scoreB = 0, 0

local function drawScores()
  local sa, sb = tostring(scoreA), tostring(scoreB)
  for i=1, #sa, 1 do
    local c = tonumber(sa:sub(i, i))
    term.drawPixels(2+(i-1)*5, 2, numbers[c])
  end
  for i=1, #sb, 1 do
    local c = tonumber(sb:sub(i, i))
    term.drawPixels(2+(i-1)*5, h-7, numbers[c])
  end
end

term.setGraphicsMode(2)
local is = input.new(1/40)
while true do
  term.setFrozen(true)
  term.clear()
  drawBall()
  drawCenterLine()
  drawPaddles()
  drawScores()
  term.setFrozen(false)
  ballX = ballX + ballDirX*ballSpeed
  ballY = ballY + ballDirY*ballSpeed
  if ballX >= (w - 8) then
    ballDirX = -ballDirX
  elseif ballX <= 8 then
    ballDirX = -ballDirX
  end
  if ballY >= (h - 8) then
    if ballX >= pbX - paddleWidth and ballX <= pbX + paddleWidth then
      ballDirY = -ballDirY
    else
      scoreA = scoreA + 1
      ballX, ballY = math.floor(w/2), math.floor(h/2)
    end
  elseif ballY <= 8 then
    if ballX >= paX - paddleWidth and ballX <= paX + paddleWidth then
      ballDirY = -ballDirY
    else
      scoreB = scoreB + 1
      ballX, ballY = math.floor(w/2), math.floor(h/2)
    end
  end
  local sig = input.poll(is)
  if sig[1] == "terminate" then
    break
  end
  if is.pressed[keys.left] then
    paX = math.max(paddleWidth, paX - 4)
  end
  if is.pressed[keys.right] then
    paX = math.min(w - paddleWidth, paX + 4)
  end
  if is.pressed[keys.a] then
    pbX = math.max(paddleWidth, pbX - 4)
  end
  if is.pressed[keys.d] then
    pbX = math.min(w - paddleWidth, pbX + 4)
  end
end

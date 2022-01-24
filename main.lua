function love.load()
  GAMESTATE = 2

  TARGET = {}

  TARGET.y = 300
  TARGET.x = 300
  TARGET.r = 50

  SCORE = 0
  TIME = 10

  FONTSIZE = 40
  GAMEFONT = love.graphics.newFont(FONTSIZE)

  SPRITES = {}
  SPRITES.sky = love.graphics.newImage('sprites/sky.png')
  SPRITES.target = love.graphics.newImage('sprites/target.png')
  SPRITES.crosshair = love.graphics.newImage('sprites/crosshairs.png')

  love.mouse.setVisible(false)
end

function love.update(dt)
  if TIME > 0 and GAMESTATE == 1 then
    TIME = TIME - dt
  end
  if TIME < 0 then
    TIME = 0
  end
end

function love.draw()
  love.graphics.draw(SPRITES.sky, 0, 0)

  if GAMESTATE == 2 then
    love.graphics.setFont(GAMEFONT)
    love.graphics.printf(
      "Click to anywhere to start",
      0,
      ( love.graphics.getHeight() / 2 - FONTSIZE / 2 ),
      love.graphics.getWidth(),
      "center"
    )
  end

  if GAMESTATE == 1 then
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(GAMEFONT)
    love.graphics.print(SCORE, 20, 20)
    love.graphics.print("Time left: "..math.ceil(TIME), 300, 20)
    love.graphics.draw(SPRITES.target, TARGET.x - TARGET.r, TARGET.y - TARGET.r)
  end

  if TIME == 0 then
    love.graphics.clear()
    love.graphics.draw(SPRITES.sky, 0, 0)
    love.graphics.printf(
      "Game over. Final score: " ..SCORE,
      0,
      ( love.graphics.getHeight() / 2 - FONTSIZE / 2 ),
      love.graphics.getWidth(),
      "center"
    )
    love.graphics.printf(
      "Click to retry",
      0,
      ( love.graphics.getHeight() / 2 + 40 ),
      love.graphics.getWidth(),
      "center"
    )
  end

  love.graphics.draw(SPRITES.crosshair, love.mouse.getX() - 20, love.mouse.getY() - 20)
end

-- Helper functions

function love.mousepressed(x, y, button)
  if GAMESTATE == 2 then
    GAMESTATE = 1
  end

  if GAMESTATE == 1 and button == 1 then
    local isInDistance = (DISTANCEBETWEEN(x, y, TARGET.x, TARGET.y) < TARGET.r)
    if isInDistance then
      SCORE = SCORE + 1
      -- TARGET.r = math.random(5, 50)
      TARGET.x = math.random(TARGET.r, love.graphics.getWidth() - TARGET.r)
      TARGET.y = math.random(TARGET.r, love.graphics.getHeight() - TARGET.r)
    else
      SCORE = 0
    end
  end
  if GAMESTATE == 1 and button == 1 and TIME == 0 then
    TIME = 10
    SCORE = 0
  end
end

function DISTANCEBETWEEN(x1, y1, x2, y2)
  return math.sqrt( ( x2 - x1 )^2 + (y2 - y1)^2 )
end
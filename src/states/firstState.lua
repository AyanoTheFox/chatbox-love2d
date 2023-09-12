firsState = {}

function firsState:enter(_argc, _argv)
    animegril = love.graphics.newImage("assets/images/animegril.png")
    animegrilportatil = love.graphics.newImage("assets/images/animegrilportatil.png")
end

function firsState:draw()
    love.graphics.setBackgroundColor(1, 1, 1, 1)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("line", 32, 32, love.graphics.getWidth() - 64, love.graphics.getHeight())
    love.graphics.line(32, 32, 0, 0)
    love.graphics.line(love.graphics.getWidth() - 32, 32, love.graphics.getWidth(), 0)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(animegril, love.graphics.getWidth() / 2 - animegril:getWidth() / 2, 0)
    chatBox:say(
        {
            text = "ohayõu :3\ni'm a anime gril\nhow are you?";
            x = 80; y = 16
        },
        {
            color = {0; 0; 0; .5};
            arrow = {}
        },
        {
            name = {
                box = {
                    texture = nil;
                    color = {0; 0; 0; .5};
                    w = 128
                };
                text = "Anime gril";
                color = {1; 0; 1; 1};
                x = 64 - love.graphics.getFont():getWidth("Anime gril") / 2
            };
            image = {
                frame = {
                    texture = nil;
                    x = 0; y = 0; w = 80; h = 64
                };
                texture = animegrilportatil;
                w = 64; h = 64
            };
        },
        love.graphics.getWidth() / 2 - 200,
        love.graphics.getHeight() - 64,
        400,
        64
    )
    chatBox:ask(
        {
            {
                text = "yes";
                isAnswed = function()
                    
                end;
                y = 32
            };
            {
                text = "no";
                isAnswed = function()
                    
                end;
                y = 64
            }
        },
        nil,
        nil,
        128,
        nil,
        {1; 1; 1; 1},
        {0; 0; 0; .5}
    )
end

function firsState:update(_elapsed)
    
end

function firsState:touchpressed(_id, _x, _y, _dx, _dy, _pressed)
    chatBox:touchpressed(_x, _y)
end

function firsState:touchmoved(_id, _x, _y, _dx, _dy, _pressed)
    chatBox:touchmoved(_x, _y)
end

function firsState:touchreleased(_id, _x, _y, _dx, _dy, _pressed)
    chatBox:touchreleased(_x, _y)
end

return firsState
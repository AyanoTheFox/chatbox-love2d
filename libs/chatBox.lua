--               [[private]]               --
local CHATBOX = {
    tx; ty;
    rx; ry
} --module

--               [[public]]               --
--?make someone say someting
--#_message is a tbl
--#_messageBox is a tbl
--#_people is a tbl
--#_x is a numb
--#_y is a numb
--#_w is a numb
--#_h is a numb
function CHATBOX:say(_message, _messageBox, _people, _x, _y, _w, _h)
--                      ^           ^          ^
--   message text settings/messagebox settinga/who are saying settings
    assert(type(_x) == "number", "bad argument to #4 expected number got " .. type(_x))
    assert(type(_y) == "number", "bad argument to #5 expected number got " .. type(_y))
    assert(type(_w) == "number", "bad argument to #6 expected number got " .. type(_w))
    assert(type(_h) == "number", "bad argument to #7 expected number got " .. type(_h))
    local _currentFont = love.graphics.getFont()
    --&message box
    if _messageBox then
        --%message box texture
        if _messageBox.color then love.graphics.setColor(_messageBox.color)
        else love.graphics.setColor(0, 0, 0, 1) end
        if _messageBox.texture then love.graphics.draw(_messageBox.texture, _x, _y, 0, _w / _messageBox.texture:getWidth(), _h / _messageBox.texture:getHeight())
        else love.graphics.rectangle("fill", _x, _y, _w, _h) end
        --%arrow
        if _messageBox.arrow then
            if _messageBox.arrow.setColor then love.graphics.setColor(_messageBox.arrow.setColor)
            else love.graphics.setColor(1, 1, 1, 1) end
            if _messageBox.arrow.texture then love.graphics.draw(_messageBox.arrow.texture, _x + (_messageBox.arrow.x or _w - _messageBox.arrow.texture:getWidth()), _y + (_messageBox.arrow.y or _h - _messageBox.arrow.texture:getHeight()), 0, _w / _people.arrow.texture:getWidth(), _h / _people.arrow.texture:getHeight())
            else love.graphics.print(">", _x + (_messageBox.arrow.x or _w - love.graphics.getFont():getWidth(">")), _y + (_messageBox.arrow.y or _h - love.graphics.getFont():getHeight())) end
        end
    end
    --&message text
    if _message then
        if _message.color then love.graphics.setColor(_message.color)
        else love.graphics.setColor(1, 1, 1, 1) end
        if _message.font then love.graphics.setFont(_message.font) end
        if _message.text then love.graphics.printf(_message.text, _x + (_message.x or 0), _y + (_message.y or 0), _w - (_message.x or 0), _message.align or "left") end
        love.graphics.setFont(_currentFont)
    end
    --&people
    if _people then
        if _people.name then
            --%people name box texture
            if _people.name.box then
                if _people.name.box.color then love.graphics.setColor(_people.name.box.color)
                else love.graphics.setColor(0, 0, 0, 1) end
                if _people.name.box.texture then love.graphics.draw(_people.name.box.texture, _x + (_people.name.box.x or 0), _y + (_people.name.box.y or -_people.name.box.texture:getHeight()), 0, (_people.name.box.w or love.graphics.getFont():getWidth(_people.name.text)) / _people.name.box.texture:getWidth(), (_people.name.box.h or love.graphics.getFont():getHeight()) / _people.name.box.texture:getHeight())
                else love.graphics.rectangle("fill", _x + (_people.name.box.x or 0), _y + (_people.name.box.y or -love.graphics.getFont():getHeight()), _people.name.box.w or love.graphics.getFont():getWidth(_people.name.text), _people.name.box.h or love.graphics.getFont():getHeight()) end
            end
            --%people name
            if _people.name.text then
                if _people.name.color then love.graphics.setColor(_people.name.color)
                else love.graphics.setColor(1, 1, 1, 1) end
                if _people.name.font then love.graphics.setFont(_people.name.font) end
                love.graphics.print(_people.name.text, _x + (_people.name.x or 0), _y + (_people.name.y or -love.graphics.getFont():getHeight()))
                love.graphics.setFont(_currentFont)
            end
        end
        --&people image
        if _people.image then
            --%people image frame
            if _people.image.frame then 
                if _people.image.frame.color then love.graphics.setColor(_people.image.frame.color)
                else love.graphics.setColor(1, 1, 1, 1) end
                if _people.image.frame.texture then love.graphics.draw(_people.image.frame.texture, _x + (_people.image.frame.x or 0), _y + (_people.image.frame.y or 0), 0, (_people.image.frame.w / _people.image.texture:getWidth()) or 1, (_people.image.frame.h / _people.image.texture:getHeight() or 1))
                else love.graphics.rectangle("fill", _x + (_people.image.frame.x or 0), _y + (_people.image.frame.y or 0), _people.image.frame.w or _people.image.texture:getWidth(), _people.image.texture.h or _people.image.texture:getHeight()) end
            end
            --%people picture 
            if _people.image.color then love.graphics.setColor(_people.image.color)
            else love.graphics.setColor(1, 1, 1, 1) end
            if _people.image.texture then love.graphics.draw(_people.image.texture, _x + (_people.image.x or 8), _y + (_people.image.y or 8), 0, _people.image.w / _people.image.texture:getWidth(), _people.image.h / _people.image.texture:getHeight())
            else love.graphics.rectangle("fill", _x + (_people.image.x or 0), _y + (_people.image.y or 0), 64, 64) end
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
    if self.rx and self.ry then if self.rx > _x and self.ry > _y and self.rx < _x + _w and self.ry < _y + _h then if _message.isPassed then _message.isPassed() end end end
    self.rx, self.ry = nil, nil
end

--?make a ask
--#_answers is tbl
--#_fgColor is tbl
--#_bgColor is tbl
function CHATBOX:ask(_answers, _texture, _texturePressed, _w, _h, _fgColor, _bgColor)
--                                                   ^         ^
--                                            default bg and fg colors
    if _fgColor == nil then _fgColor = {1; 1; 1; 1} end
    if _bgColor == nil then
        if _texture then  _bgColor = {1; 1; 1; 1}
        else _bgColor = {0; 0; 0; .5} end
    end
    --%answer
    for _, answer in ipairs(_answers) do
        --%answer box color
        if answer.bgColor then love.graphics.setColor(answer.bgColor)
        else love.graphics.setColor(_bgColor) end
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print(tostring(CHATBOX.rx) .. tostring(CHATBOX.ry))
            love.graphics.setColor(1, 1, 0, 1)
        --%answer box
        if self.rx and self.ry then 
            if self.rx > (answer.x or love.graphics.getWidth() / 2) - _w and self.ry > answer.y and self.rx < answer.x + _w * 2 and self.ry < (_h or love.graphics.getFont():getHeight()) then 
                if answer.texturePressed then love.graphics.draw(answer.texturePressed, (answer.x or love.graphics.getWidth() / 2) - _w, answer.y, 0, _w * 2 / _texture:getWidth(), (_h or love.graphics.getFont():getHeight()) / _texture:getHeight())
                elseif _texturePressed then love.graphics.draw(_texturePressed, (answer.x or love.graphics.getWidth() / 2) - _w, answer.y, 0, _w * 2 / _texture:getWidth(), (_h or love.graphics.getFont():getHeight()) / _texture:getHeight())
                else
                    love.graphics.setColor(1, 1, 1, .5)
                    love.graphics.rectangle("fill", (answer.x or love.graphics.getWidth() / 2) - _w, answer.y, _w * 2, _h or love.graphics.getFont():getHeight())
                    love.graphics.setColor(1, 1, 1, 1)
                end
            end
        else
            if answer.texture then love.graphics.draw(answer.texture, (answer.x or love.graphics.getWidth() / 2) - _w, answer.y, 0, _w * 2 / answer.texture:getWidth(), (_h or love.graphics.getFont():getHeight()) / answer.texture:getHeight())
            elseif _texture then love.graphics.draw(_texture, (answer.x or love.graphics.getWidth() / 2) - _w, answer.y, 0, _w * 2 / _texture:getWidth(), (_h or love.graphics.getFont():getHeight()) / _texture:getHeight())
            else love.graphics.rectangle("fill", (answer.x or love.graphics.getWidth() / 2) - _w, answer.y, _w * 2, _h or love.graphics.getFont():getHeight()) end
        end
        if answer.text then
            --%answer fg color
            if answer.fgColor then love.graphics.setColor(answer.fgColor)
            elseif _fgColor then love.graphics.setColor(_fgColor) 
            else love.graphics.setColor(1, 1, 1, 1) end
            --%answer text
            love.graphics.print(answer.text, answer.x or love.graphics.getWidth() / 2 - love.graphics.getFont():getWidth(answer.text) / 2, answer.y)
        end
        if self.rx and self.ry then if self.rx > (answer.x or love.graphics.getWidth() / 2) - _w and self.ry > answer.y and self.rx < answer.x + _w * 2 and self.ry < (_h or love.graphics.getFont():getHeight()) and answer.isAnswed then answer.isAnswed() end end
        self.rx, self.ry = nil, nil
    end
end

function CHATBOX:touchpressed(_x, _y)
    self.tx, self.ty = _x, _y
end

function CHATBOX:touchmoved(_x, _y)
    self.tx, self.ty = _x, _y
end

function CHATBOX:touchreleased(_x, _y)
    self.rx, self.ry = _x, _y
    self.tx, self.ty = nil, nil
end

return CHATBOX
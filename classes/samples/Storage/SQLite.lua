require "classes.constants.screen"
require "sqlite3"

SQLite={}

function SQLite:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local background = display.newImageRect("img/backgroundNotifications.png", 360, 570)
    local labelTitle = display.newText("SQLite demo", 20, 30, native.systemFontBold, 20)
    local labelSubtitle = display.newText("Creates or opens a local database", 20, 50, native.systemFont, 14)
    local labelInfo = display.newText("(Data is shown below)", 20, 90, native.systemFont, 14)
    local db = sqlite3.open(system.pathForFile("data.db", system.DocumentsDirectory))
    local word = {'Hello', 'World', 'Lua'}

    function private.SQLite()

        background.x = screen.centerX
        background.y = screen.centerY

        labelTitle.anchorX = 0
        labelTitle.anchorY = 0
        labelTitle:setFillColor(190/255, 190/255, 255/255)

        labelSubtitle.anchorX = 0
        labelSubtitle.anchorY = 0
        labelSubtitle:setFillColor(190/255, 190/255, 255/255)

        labelInfo.anchorX = 0
        labelInfo.anchorY = 0
        labelInfo:setFillColor(255/255, 255/255, 255/255)

        this:insert(background)
        this:insert(labelTitle)
        this:insert(labelSubtitle)
        this:insert(labelInfo)

        db:exec([[
                    CREATE TABLE IF NOT EXISTS WordsTable(id INTEGER PRIMARY KEY, word1, word2);
               ]])
        db:exec([[
                    INSERT INTO WordsTable VALUES (NULL, ']]..word[1]..[[',']]..word[2]..[[');
               ]])
        db:exec([[
                    INSERT INTO WordsTable VALUES (NULL, ']]..word[2]..[[',']]..word[1]..[[');
               ]])
        db:exec([[
                    INSERT INTO WordsTable VALUES (NULL, ']]..word[1]..[[',']]..word[3]..[[');
               ]])

        for row in db:nrows("SELECT * FROM WordsTable") do
            local textTwoWords = row.word1.." "..row.word2
            local labelTwoWords = display.newText(textTwoWords, 20, 120 + (20 * row.id), native.systemFont, 16)
            labelTwoWords.anchorX=0
            labelTwoWords.anchorY=0
            labelTwoWords:setFillColor(255/255, 0/255, 255/255)
            this:insert(labelTwoWords)
        end

        Runtime:addEventListener("system", private.onApplicationExit)

    end

    function private.onApplicationExit(event)
        if event.type == "applicationExit" then
            db:close()
        end
    end

    function public:destroy()
        Runtime:removeEventListener("system", private.onApplicationExit)

        background:removeSelf()
        background = nil

        labelTitle:removeSelf()
        labelTitle = nil

        labelSubtitle:removeSelf()
        labelSubtitle = nil

        labelInfo:removeSelf()
        labelInfo = nil

        this:removeSelf()
        this = nil
    end

    private.SQLite()
    return this
end
return SQLite

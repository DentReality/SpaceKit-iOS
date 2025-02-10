function Demo()
    closeButtonFunction = Complete

    local chapterSelect = loadModule("chapterSelect")
    
    setFullscreen()
    chapterSelect.TitleMenu()
end

function Complete()
    complete()
end

function Close()
    closeButtonFunction()
end
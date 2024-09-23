local maps = {}

function maps.Start()
    disableFeature("panMap")
    disableFeature("rotateMap")
    disableFeature("zoomMap")

    maps.Present2DFloorplan()
end

function maps.StartLocation()
    maps.BranchIfHasLocation()
end

function maps.Present2DFloorplan()
    ImageDialog.new(Resource.new("Maps1"), "Hyper take the 2D floorplan of your store…", maps.PresentVirtualiseEveryDetail):present(context)
end

function maps.PresentVirtualiseEveryDetail()
    ImageDialog.new(Resource.new("Maps2"), "…virtualise every detail of it…", maps.PresentBrandAndStyle):present(context)
end

function maps.PresentBrandAndStyle()
    ImageDialog.new(Resource.new("Maps3"), "…and let you bring your brand and style…", maps.PresentBeautifulMaps):present(context)
end

function maps.PresentBeautifulMaps()
    setBottom()
    MessageDialog.new({"…to create beautiful 3D maps of your stores."}, maps.PresentUsersCanDrag):present(context)
end

function maps.PresentUsersCanDrag()
    enableFeature("panMap")

    TaskDialog = TaskDialog.new("Users can drag to move around your storestore…", "Drag across your store", maps.PresentRotate)
    TaskDialog:present(context)
    
    CompleteFunction = function()
        TaskDialog:complete()
    end
    
    Waiter.new("panMap", CompleteFunction):wait(context)
end

function maps.PresentRotate()
    disableFeature("panMap")
    enableFeature("rotateMap")

    TaskDialog = TaskDialog.new("…drag two fingers around a point to rotate your store…", "Rotate around your store", maps.PresentZoom)
    TaskDialog:present(context)
    
    CompleteFunction = function()
        TaskDialog:complete()
    end
    
    Waiter.new("rotateMap", CompleteFunction):wait(context)
end

function maps.PresentZoom()
    disableFeature("rotateMap")
    enableFeature("zoomMap")

    TaskDialog = TaskDialog.new("…and open and close a pinch to zoom in and out…", "Zoom in and out of your store", maps.PresentEveryDetail)
    TaskDialog:present(context)
    
    CompleteFunction = function()
        TaskDialog:complete()
    end
    
    Waiter.new("zoomMap", CompleteFunction):wait(context)
end

function maps.PresentEveryDetail()
    enableFeature("panMap")
    enableFeature("rotateMap")
    enableFeature("zoomMap")
    
    MessageDialog.new({"…allowing users to explore every detail of your store."}, maps.BranchIfHasLocation):present(context)
end

function maps.BranchIfHasLocation()
    if hasLocationEstimate then 
        maps.CenterOnUser()
    else
        maps.WaitForLocation()
    end
end

function maps.WaitForLocation()
    hide()
    WaiterFunction = function()
        maps.CenterOnUser()
    end

    Waiter.new("locationEstimate", WaiterFunction):wait(context)
end

function maps.CenterOnUser()
    centerOnUser()
    setBottom()
    MessageDialog.new({"Here you can see the user location represented on the map with our location puck…"}, maps.PresentUsesWifiData):present(context)
end

function maps.PresentUsesWifiData()
    setFullscreen()
    ImageDialog.new(Resource.new("Location1"), "HyperLocation uses Wifi data…", maps.PresentDeviceMotionData):present(context)
end

function maps.PresentDeviceMotionData()
    ImageDialog.new(Resource.new("Location2"), "…and device motion data…", maps.PresentAugmentedReality):present(context)
end

function maps.PresentAugmentedReality()
    ImageDialog.new(Resource.new("Location3"), "…with augmented reality data…", maps.PresentIndustryLeadingAccuracy):present(context)
end

function maps.PresentIndustryLeadingAccuracy()
    ImageDialog.new(Resource.new("Location4"), "…And combines to produce industry leading location accuracy…", maps.PresentTheMoreYouMove):present(context)
end

function maps.PresentTheMoreYouMove()
    ImageDialog.new(Resource.new("Location5"), "…And the more you move the accuracy increases to less than 1 meter!", maps.PresentMapSummary):present(context)
end

function maps.PresentMapSummary()
    setFullscreen()
    local message = {
        "**Maps & Location Summary**",
        "Hyper takes your 2D flooplan and virtualises it into a detailed, customisable, 3D map.",
        "And allows your users to explore every detail of your stores.",
        "**Any questions?**"
    }
    MessageDialog.new(message, maps.QuestionsAndAnswers):present(context)
end

function maps.QuestionsAndAnswers()
    local questions = loadQuestions("maps")
    QADialog.new("Got a question about maps?", questions, maps.End):present(context)
end

function maps.End()
    if superflow then 
        local routing = loadModule("routing")
        routing.Start()
    else 
        local chapterSelect = loadModule("chapterSelect")
        chapterSelect.PresentEndScreen()
    end
end

return maps

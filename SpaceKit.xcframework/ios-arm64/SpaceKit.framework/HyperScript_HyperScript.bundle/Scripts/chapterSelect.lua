local chapterSelect = {}

superflow = false

function chapterSelect.TitleMenu()
    superflow = false
    closeButtonFunction = Complete

    enableFeature("panMap")
    enableFeature("rotateMap")
    enableFeature("zoomMap")

    enableFeature("arNavigation")
    enableFeature("gotIt")

    Options = {
        Option.new("Maps", "Discover how we 2D floorplan to beautiful 3D maps.", "map.fill", chapterSelect.StartMaps),
        Option.new("HyperLocation", "Find out about our industry leading location technology.", "location.north.circle", chapterSelect.StartLocation),
        Option.new("Routing", "See the most efficient way to get your customers from A to B.", "point.bottomleft.filled.forward.to.point.topright.scurvepath", chapterSelect.StartRouting),
        Option.new("Multi Item Routing", "Dive into how we route customers with full multi item shopping lists.", "checklist", chapterSelect.PresentUnderConstruction),
        Option.new("AR Navigation", "Experience a whole new way to navigate your store.", "iphone", chapterSelect.PresentUnderConstruction),
        Option.new("Spatial Marketing", "Discover a new way to market to your customers anywhere in store.", "megaphone.fill", chapterSelect.PresentUnderConstruction),
    }
    
    OptionsDialog.new("Or explore something specific", true, Options, chapterSelect.StartAll):present(context)
end

function chapterSelect.StartAll()
    superflow = true
    closeButtonFunction = chapterSelect.TitleMenu
    
    local message = {
        "Welcome to the **HyperDemo**",
        "Showing everything the HyperSDK can offer **IKEA**",
        "Our **Maps**, **Location**, **Navigation** and **Spatial technologies** unlock value for you and your customers.",
        "Now let's get started with **maps**..."
    }

    local messageDialog = MessageDialog.new(message, chapterSelect.StartMaps)
    messageDialog:present(context)
end

function chapterSelect.StartMaps()
    closeButtonFunction = chapterSelect.TitleMenu

    local maps = loadModule("maps")
    maps.Start()
end

function chapterSelect.StartLocation()
    closeButtonFunction = chapterSelect.TitleMenu

    local maps = loadModule("maps")
    maps.StartLocation()
end

function chapterSelect.StartRouting()
    local routing = loadModule("routing")
    routing.Start()
end

function chapterSelect.PresentUnderConstruction()
    MessageDialog.new({"Under construction"}, Complete):present(context)
end

function chapterSelect.PresentEndScreen()
    MessageDialog.new({"**End of demo**\n\nCurrently this is the end of the demo, but there's still much more to come."}, Complete):present(context)
end

return chapterSelect

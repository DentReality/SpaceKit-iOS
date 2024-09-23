local routing = {}

function routing.Start()
    setFullscreen()
    routing.PresentIntro()

    disableFeature("arNavigation")
    disableFeature("gotIt")

    routing.PresentIntro()
end

function routing.PresentIntro() 
    ImageDialog.new(Resource.new("Routing1"), "The HyperSDK allows your customers to get from anywhere to anywhere…", routing.PresentPOI):present(context)
end

function routing.PresentPOI()
    ImageDialog.new(Resource.new("Routing2"), "…whether that’s the closest a point of interest…", routing.PresentSection):present(context)
end

function routing.PresentSection()
    ImageDialog.new(Resource.new("Routing3"), "…a large area like a product category section…", routing.PresentFixture):present(context)

end

function routing.PresentFixture()
    ImageDialog.new(Resource.new("Routing4"), "…or a product as a specific fixture in your store.", routing.PresentPickAProduct):present(context)
end

function routing.PresentPickAProduct()
    Destinations = {
        Destination.new("Decoration", "Section", "DEPT_004", Resource.new("")),
        Destination.new("Workspaces", "Section", "DEPT_012", Resource.new("")),
        Destination.new("Escalators", "Point of Interest", "POI_SUBTYPE_ESCALATOR", Resource.new("")),
    }

    function OnSelectDestination(index)
        addToList(Destinations[index]:getItemCode(), Destinations[index]:getDescription(), Destinations[index]:getImage())
        routing.PresentSelectedDestination()
    end

    DestinationsDialog.new(Destinations, "For now, let’s pick a destination to navigate to.", "Great, let’s go!", OnSelectDestination):present(context)
end

function routing.PresentSelectedDestination()
    setTop()
    MessageDialog.new({"Your selected destination appears in the infoView at the bottom of the screen…"}, routing.PresentReplacedWithYourOwn):present(context)
end

function routing.PresentReplacedWithYourOwn()
    MessageDialog.new({"…Which can be replaced with your own custom view to match your brand and style."}, routing.PresentRoute):present(context)
end

function routing.PresentRoute()
    Completion = function()
        setBottom()
        Dialog = MessageDialog.new({"You can see the route from your location to the destination by the blue path."}, routing.BranchOnHyperLocation)
        Dialog:present(context)
    end

    if hasRoute then
        Completion()
    else
        hide()
        Waiter.new("route", Completion):wait(context)
    end
end

function routing.BranchOnHyperLocation()
    if hasAccurateLocationEstimate then
        routing.PresentHyperAccurate()
    else
        routing.PresentHyperLocationGetsBetter()
    end
end

function routing.PresentHyperLocationGetsBetter()
    MessageDialog.new({"HyperLocation gets better the more you walk.", "So the direction readout prompts you to walk while accuracy is initially low."}, routing.PresentStartWalking):present(context)
end

function routing.PresentStartWalking()
    MessageDialog.new({"So, let’s start walking along the blue path to your destination!"}, routing.WaitForHyperLocation):present(context)
end

function routing.WaitForHyperLocation()
    Completion = function ()
        routing.PresentHyperAccurate()
    end

    if hasAccurateLocationEstimate then
        Completion()
    else
        hide()
        Waiter.new("accurateLocationEstimate", Completion):wait(context)
    end
end

function routing.PresentHyperAccurate()
    setTop()
    MessageDialog.new({"HyperLocation is now HyperAccurate!"}, routing.PresentDirectionsReadout):present(context)
end

function routing.PresentDirectionsReadout()
    MessageDialog.new({"Which means the directions readout will give turn by turn updates of the route."}, routing.PresentNotFarNow):present(context)
end

function routing.PresentNotFarNow()
    setBottom()
    MessageDialog.new({"Not far now, let’s keep walking to your destination."}, routing.WaitForArrived):present(context)
end

function routing.WaitForArrived()
    Completion = function()
        routing.PresentWhenYoureClose()
    end

    if hasArrived then
        Completion()
    else
        hide()
        Waiter.new("arrived", Completion):wait(context)
    end
end

function routing.PresentWhenYoureClose()
    setTop()
    MessageDialog.new({"When you’re close to your destination the directions readout will highlight…"}, routing.PresentArrivedButton):present(context)
end

function routing.PresentArrivedButton()
    MessageDialog.new({"…and the 'Got it' button will highlight as well, to tick off that item."}, routing.PresentNowYouveArrived):present(context)
end

function routing.PresentNowYouveArrived()
    enableFeature("gotIt")

    TaskDialog = TaskDialog.new("So now you’ve arrived at the item, tap 'Got it'.", "Tap 'Got it'", routing.PresentSummary)
    TaskDialog:present(context)
    
    CompleteFunction = function()
        TaskDialog:complete()
    end
    
    Waiter.new("gotIt", CompleteFunction):wait(context)
end

function routing.PresentSummary()
    setFullscreen()
    MessageDialog.new({"**Routing Summary**", "Hyper let’s your users navigate to POIs, product sections and specific fixtures from anywhere in your store.", "Guide your user’s along their route with the route path, directions read out and your own custom infoView."}, routing.PresentQA):present(context)
end

function routing.PresentQA()
    local questions = loadQuestions("routing")
    QADialog.new("Got a question about routing?", questions, routing.End):present(context)
    enableFeature("arNavigation")
end

function routing.End()
    local chapterSelect = loadModule("chapterSelect")
    chapterSelect.PresentEndScreen()
end

return routing
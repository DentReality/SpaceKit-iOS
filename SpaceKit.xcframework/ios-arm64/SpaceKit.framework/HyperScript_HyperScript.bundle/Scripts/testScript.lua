function Demo()
    print("Test script started")
end

function TestEnableFeature(feature)
    enableFeature(feature)
end

function TestDisableFeature(feature)
    disableFeature(feature)
end

function TestGlobal()
    return hasLocationEstimate
end

function TestWaiter()
    CompleteFunction = function()
        complete()
    end
    
    Waiter.new("locationEstimate", CompleteFunction):wait(context)
end

function TestLoadModule(message)
    local module = loadModule("testModule")
    return module.TestFunction(message)
end
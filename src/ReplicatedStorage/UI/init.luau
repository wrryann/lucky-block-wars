return function()
    for _, ModuleScript in script:GetDescendants() do
        if not ModuleScript:IsA("ModuleScript") then continue end

        local Module = require(ModuleScript)
        if Module.Init then
            Module.Init()
        end
            
    end
end
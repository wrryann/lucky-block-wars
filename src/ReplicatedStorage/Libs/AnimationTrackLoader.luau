return {
    Load = function(
        Character,
        animation: Animation,
        Play: boolean?,
        looped: boolean?,
        priority: Enum.AnimationPriority?,
        TransitionTime: number?
    )
        if Play == nil then Play = true end
        local animationTrack
        if Character then
            local humanoid = Character:FindFirstChild("Humanoid")
            if humanoid then
                animationTrack = humanoid:LoadAnimation(animation)
                animationTrack.Priority = priority or Enum.AnimationPriority.Action2
                animationTrack.Looped = looped or false
                if Play then 
                    animationTrack:Play(TransitionTime or 0)
                end
                return animationTrack
            end
        end

        return animationTrack
    end,
} 
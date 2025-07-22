local LoaderHandler = {}
----
local tweenservice = game:GetService('TweenService')

function LoaderHandler:fade(f, startTransparency, endTransparency, duration)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local goal = { BackgroundTransparency = endTransparency }
	local tween = tweenservice:Create(
		f, 
		TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		goal)
	tween:Play()
	tween.Completed:Wait()
end

return LoaderHandler
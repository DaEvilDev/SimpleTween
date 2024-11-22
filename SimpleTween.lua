--[[
	A simple module specifically made to improve the experience of TweenService

	@author TheEvilDeveloper
	@author https://github.com/DaEvilDev
	@author https://www.roblox.com/users/1668387468/profile
	@version 1.1
	@created 2022/09/23
	@updated 2024/11/23
]]

local SimpleTween = {}
SimpleTween.__index = SimpleTween

local tweenService: TweenService = game:GetService("TweenService")

local function getButtonTweenInfo(duration: number): TweenInfo
	return TweenInfo.new(
		duration,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.Out,
		0,
		false,
		0
	)
end

local function getBaseTweenInfo(duration: number): TweenInfo
	return TweenInfo.new(
		duration,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.Out,
		0,
		false,
		0
	)
end

local function createTween(self, instance: Instance, tweenInfo: TweenInfo, propertyTable: {[string]: any}, callback: (any)?): Tween
	for index: number, tween: Tween in ipairs(self.tweens) do
		if tween.Instance == instance then
			tween:Cancel()
			table.remove(self.tweens, index)
			break
		end
	end

	local properties: {[string]: any} = {}
	for property: string, value: any in pairs(propertyTable) do
		local success, currentValue = pcall(function()
			return instance[property]
		end)

		if success and currentValue ~= nil and currentValue ~= value then
			properties[property] = value
		end
	end

	if next(properties) == nil then
		return nil
	end

	local tween = tweenService:Create(instance, tweenInfo, properties)
	table.insert(self.tweens, tween)
	tween:Play()

	tween.Completed:Once(function(playbackState: Enum.PlaybackState)
		local index = table.find(self.tweens, tween)
		if index then
			table.remove(self.tweens, index)
			tween:Destroy()
		end

		if playbackState == Enum.PlaybackState.Cancelled then return end
		
		if typeof(callback) == "function" then
			callback()
		end
	end)

	return tween
end

--[[ 
<p><strong>GetTweens:</strong> Retrieves all active tweens managed by the SimpleTween object.</p>
<em>Parameters:</em>
<code>None</code>
<em>Returns:</em>
<code>{Tween}</code>: Table of active tweens.
]]
function SimpleTween:GetTweens(): {Tween}
	return self.tweens
end

--[[ 
<p><strong>CancelTweens:</strong> Cancels all active tweens managed by the SimpleTween object.</p>
<em>Parameters:</em>
<code>None</code>
<em>Returns:</em>
<code>nil</code>: This function does not return a value.
]]
function SimpleTween:CancelTweens(): nil
	for _, tween: Tween in pairs(self.tweens) do
		tween:Cancel()
	end
end

--[[ 
<p><strong>PauseTweens:</strong> Pauses all active tweens managed by the SimpleTween object.</p>
<em>Parameters:</em>
<code>None</code>
<em>Returns:</em>
<code>nil</code>: This function does not return a value.
]]
function SimpleTween:PauseTweens(): nil
	for _, tween: Tween in pairs(self.tweens) do
		tween:Pause()
	end
end
	
--[[ 
<p><strong>ResumeTweens:</strong> Resumes all paused tweens managed by the SimpleTween object.</p>
<em>Parameters:</em>
<code>None</code>
<em>Returns:</em>
<code>nil</code>: This function does not return a value.
]]
function SimpleTween:ResumeTweens(): nil
	for _, tween: Tween in pairs(self.tweens) do
		tween:Play()
	end
end

--[[ 
<p><strong>SingleTween:</strong> Creates and starts a tween for a single instance.</p>
<em>Parameters:</em>
<code>instance</code>: The instance to tween.
<code>propertyTable</code>: Property-value pairs to tween.
<code>duration</code>: Duration of the tween (seconds).
<code>callback</code>: (Optional) Function executed after the tween finishes.
<em>Returns:</em>
<code>Tween</code>: The created tween object.
]]
function SimpleTween:SingleTween(instance: Instance, propertyTable: {[string]: any}, duration: number, callback: (any)?): Tween
	return createTween(self, instance, getBaseTweenInfo(duration), propertyTable, callback)
end

--[[ 
<p><strong>MultipleTween:</strong> Creates tweens for multiple instances. The callback is executed once after the first tween completes.</p>
<em>Parameters:</em>
<code>instances</code>: Table of instances to tween.
<code>propertyTable</code>: Property-value pairs to tween.
<code>duration</code>: Duration of each tween (seconds).
<code>callback</code>: (Optional) Function executed after the first tween finishes.
<em>Returns:</em>
<code>{Tween}</code>: Table of created tween objects.
]]
function SimpleTween:MultipleTween(instances: {Instance}, propertyTable: {[string]: any}, duration: number, callback: (any)?): {Tween}
	local tweens: {Tween} = {}
	local callbackHooked: boolean = false

	for _, instance: Instance in pairs(instances) do
		local getCallback: (any)? = callbackHooked == false and callback or nil
		callbackHooked = true

		local tween = createTween(self, instance, getBaseTweenInfo(duration), propertyTable, getCallback)
		table.insert(tweens, tween)
	end

	return tweens
end

--[[ 
<p><strong>CustomSingleTween:</strong> Creates and starts a tween for a single instance using custom <code>TweenInfo</code>.</p>
<em>Parameters:</em>
<code>instance</code>: The instance to tween.
<code>propertyTable</code>: Property-value pairs to tween.
<code>tweenInfo</code>: Custom tween configuration.
<code>callback</code>: (Optional) Function executed after the tween finishes.
<em>Returns:</em>
<code>Tween</code>: The created tween object.
]]
function SimpleTween:CustomSingleTween(instance: Instance, propertyTable: {[string]: any}, tweenInfo: TweenInfo, callback: (any)?): Tween
	return createTween(self, instance, tweenInfo, propertyTable, callback)
end

--[[ 
<p><strong>CustomMultipleTween:</strong> Creates tweens for multiple instances using custom <code>TweenInfo</code>. The callback is executed once after the first tween completes.</p>
<em>Parameters:</em>
<code>instances</code>: Table of instances to tween.
<code>propertyTable</code>: Property-value pairs to tween.
<code>tweenInfo</code>: Custom tween configuration.
<code>callback</code>: (Optional) Function executed after the first tween finishes.
<em>Returns:</em>
<code>{Tween}</code>: Table of created tween objects.
]]
function SimpleTween:CustomMultipleTween(instances: {Instance}, propertyTable: {[string]: any}, tweenInfo: TweenInfo, callback: (any)?): {Tween}
	local tweens: {Tween} = {}
	local callbackHooked: boolean = false

	for _, instance: Instance in pairs(instances) do
		local getCallback: (any)? = callbackHooked == false and callback or nil
		callbackHooked = true

		local tween = createTween(self, instance, tweenInfo, propertyTable, getCallback)
		table.insert(tweens, tween)
	end

	return tweens
end

--[[ 
<p><strong>GuiPosition:</strong> Animates the position of a GUI object.</p>
<em>Parameters:</em>
<code>guiObject</code>: The GUI object whose position will be animated.
<code>position</code>: The target position (UDim2).
<code>duration</code>: Duration of the animation (seconds).
<code>callback</code>: (Optional) Function executed after the animation finishes.
<em>Returns:</em>
<code>Tween</code>: The created tween object.
]]
function SimpleTween:GuiPosition(object: GuiObject, position: UDim2, duration: number, callback: (any)?): Tween
	return createTween(self, object, getBaseTweenInfo(duration), {Position = position}, callback)
end

--[[ 
<p><strong>GuiSize:</strong> Animates the size of a GUI object.</p>
<em>Parameters:</em>
<code>guiObject</code>: The GUI object whose size will be animated.
<code>size</code>: The target size (UDim2).
<code>duration</code>: Duration of the animation (seconds).
<code>callback</code>: (Optional) Function executed after the animation finishes.
<em>Returns:</em>
<code>Tween</code>: The created tween object.
]]
function SimpleTween:GuiSize(object: GuiObject, size: UDim2, duration: number, callback: (any)?): Tween
	return createTween(self, object, getBaseTweenInfo(duration), {Size = size}, callback)
end

--[[
<p><strong>GuiButton:</strong> Adds a visual shrinking effect to a GUI button when clicked.</p>
<em>Parameters:</em>
<code>guiButton</code>: The GUI button to animate.
<code>callback</code>: (Optional) Function executed after the animation finishes.
<em>Returns:</em>
<code>nil</code>: This function does not return a value.
<em>Note:</em>
If the button contains a GUI Object named "Content", It will be tweened instead of the GUI button.
]]
function SimpleTween:GuiButton(button: GuiButton, callback: (any)?): nil
	button.Active = false
	
	local content: GuiObject = button:FindFirstChild("Content") and button.Content or button
	local size: UDim2 = content.Size

	createTween(self, content, getButtonTweenInfo(0.125), {Size = UDim2.fromScale(size.X.Scale / 1.2, size.Y.Scale / 1.2)}, function()
		createTween(self, content, getButtonTweenInfo(0.125), {Size = size}, function()
			button.Active = true
		end)
	end)
end

--[[ 
<p><strong>GuiPosition:</strong> Animates the position of a GUI object.</p>
<em>Parameters:</em>
<code>guiObject</code>: The GUI object whose position will be animated.
<code>position</code>: The target position (UDim2).
<code>tweenInfo</code>: Custom tween configuration.
<code>callback</code>: (Optional) Function executed after the animation finishes.
<em>Returns:</em>
<code>Tween</code>: The created tween object.
]]
function SimpleTween:CustomGuiPosition(object: GuiObject, position: UDim2, tweenInfo: TweenInfo, callback: (any)?): Tween
	return createTween(self, object, tweenInfo, {Position = position}, callback)
end

--[[
<p><strong>CustomGuiSize:</strong> Animates the size of a GUI object.</p>
<em>Parameters:</em>
<code>guiObject</code>: The GUI object whose size will be animated.
<code>position</code>: The target size (UDim2).
<code>tweenInfo</code>: Custom tween configuration.
<code>callback</code>: (Optional) Function executed after the animation finishes.
<em>Returns:</em>
<code>Tween</code>: The created tween object.
]]
function SimpleTween:CustomGuiSize(object: GuiObject, size: UDim2, tweenInfo: TweenInfo, callback: (any)?): Tween
	return createTween(self, object, tweenInfo, {Size = size}, callback)
end

--[[ 
<p><strong>new:</strong> Creates a new SimpleTween object to manage tweens.</p>
<em>Parameters:</em>
<code>None</code>
<em>Returns:</em>
<code>SimpleTween</code>: A new instance of the SimpleTween class.
]]
function SimpleTween.new()
	local self = setmetatable({}, SimpleTween)
	
	self.tweens = {}
		
	return self
end

return SimpleTween

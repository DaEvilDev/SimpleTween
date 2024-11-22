![SimpleTween](https://github.com/user-attachments/assets/80386a54-0479-4920-b2c0-d606785658a7)

A simple Roblox module specifically designed to enhance the experience of using Roblox's TweenService. With `SimpleTween`, you can easily manage single or multiple tweens, including GUI-specific animations, with improved functionality, custom TweenInfo, and built-in control options.

---

## **About**

`SimpleTween` takes Roblox's TweenService to the next level, offering:
- **Easy Management:** Automatically handles creation, cleanup, and control of tweens.
- **Batch Tweens:** Simplifies tweening multiple objects at once with a single call.
- **Custom TweenInfo Support:** Allows more control over tween behavior with custom easing styles and durations.
- **GUI Support:** Includes specialized functions for tweening GUI object sizes and positions.
- **Callback Integration:** Supports custom callback functions that execute when tweens finish naturally.

---

## **Constructor**

### `SimpleTween.new()`
**Creates a new `SimpleTween` object to manage tweens.**  
- **Returns:** A `SimpleTween` instance.

```lua
local SimpleTween = require(script.SimpleTween)
local tweenController = SimpleTween.new()
```

---

## **Control Functions**

### `SimpleTween:CancelTweens()`
**Cancels all active tweens managed by this instance.**  
This immediately stops the tweens and removes them from memory.

---

### `SimpleTween:PauseTweens()`
**Pauses all active tweens managed by this instance.**  
Use this function to temporarily halt tweens without canceling them.

---

### `SimpleTween:ResumeTweens()`
**Resumes all paused tweens managed by this instance.**  
Call this function to continue paused tweens.

---

## **Tween Creation Functions**

### `SimpleTween:SingleTween(instance: Instance, propertyTable: {[string]: any}, duration: number, callback: (any)?)`
**Creates and starts a tween for a single instance.**  
- **Parameters:**
  - `instance`: The object to tween.
  - `propertyTable`: A dictionary of properties to tween.
  - `duration`: The duration of the tween in seconds.
  - `callback`: (Optional) A function to execute when the tween ends naturally.
- **Returns:** The created `Tween` object.

---

### `SimpleTween:MultipleTween(instances: {Instance}, propertyTable: {[string]: any}, duration: number, callback: (any)?)`
**Creates and starts tweens for multiple instances.**  
- **Parameters:**
  - `instances`: A table of objects to tween.
  - `propertyTable`: A dictionary of properties to tween.
  - `duration`: The duration of the tween in seconds.
  - `callback`: (Optional) A function to execute when **all** tweens finish naturally.
- **Returns:** A table of created `Tween` objects.

---

## **GUI-Specific Functions**

### `SimpleTween:GuiSize(object: GuiObject, size: UDim2, duration: number, callback: (any)?)`
**Tweens the size of a GUI object.**  
- **Parameters:**
  - `object`: The GUI object to tween.
  - `size`: The target size as a UDim2 value.
  - `duration`: The duration of the tween in seconds.
  - `callback`: (Optional) A function to execute when the tween ends naturally.

---

### `SimpleTween:GuiPosition(object: GuiObject, position: UDim2, duration: number, callback: (any)?)`
**Tweens the position of a GUI object.**  
- **Parameters:** Same as `GuiSize`, but for the object's position.

---

## **Custom TweenInfo Functions**

### `SimpleTween:CustomSingleTween(instance: Instance, propertyTable: {[string]: any}, tweenInfo: TweenInfo, callback: (any)?)`
**Creates a single tween with custom TweenInfo.**  
- **Parameters:** Same as `SingleTween`, but uses a `TweenInfo` object instead of `duration`.

---

### `SimpleTween:CustomMultipleTween(instances: {Instance}, propertyTable: {[string]: any}, tweenInfo: TweenInfo, callback: (any)?)`
**Creates multiple tweens with custom TweenInfo.**  
- **Parameters:** Same as `MultipleTween`, but uses a `TweenInfo` object instead of `duration`.

---

## **GUI Custom TweenInfo Functions**

### `SimpleTween:CustomGuiSize(object: GuiObject, size: UDim2, tweenInfo: TweenInfo, callback: (any)?)`
**Tweens the size of a GUI object with custom TweenInfo.**  
- **Parameters:** Same as `GuiSize`, but uses a `TweenInfo` object instead of `duration`.

---

### `SimpleTween:CustomGuiPosition(object: GuiObject, position: UDim2, tweenInfo: TweenInfo, callback: (any)?)`
**Tweens the position of a GUI object with custom TweenInfo.**  
- **Parameters:** Same as `GuiPosition`, but uses a `TweenInfo` object instead of `duration`.

---

## **Examples**

### **Basic Single Tween**
```lua
local SimpleTween = require(script.SimpleTween)
local tweenController = SimpleTween.new()

local part = workspace.Part

-- Tween the transparency of a part over 2 seconds
tweenController:SingleTween(part, {Transparency = 1}, 2, function()
    print("Part is now transparent!")
end)
```

---

### **Tweening Multiple Objects**
```lua
local parts = workspace:GetChildren() -- All parts in the workspace
local propertyTable = {Color = Color3.fromRGB(255, 0, 0)} -- Change color to red
local duration = 3 -- Duration in seconds

local multipleTween = tweenController:MultipleTween(parts, propertyTable, duration, function()
    print("All parts are now red!")
end)
```

---

### **Tweening GUI Elements**
```lua
local SimpleTween = require(script.SimpleTween)
local tweenController = SimpleTween.new()

local button = script.Parent.Button -- A GUI button

-- Tween the button's size
tweenController:GuiSize(button, UDim2.new(0.5, 0, 0.5, 0), 1, function()
    print("Button size tween complete!")
end)
```

---

### **Custom TweenInfo Example**
```lua
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
tweenController:CustomSingleTween(workspace.Part, {Position = Vector3.new(0, 20, 0)}, tweenInfo, function()
    print("Bounce tween complete!")
end)
```

---

### **Pausing, Resuming, and Canceling Tweens**
```lua
local tween = tweenController:SingleTween(workspace.Part, {Transparency = 1}, 5)

task.wait(2)
tween:Pause() -- Pause the tween after 2 seconds
print("Tween paused!")

task.wait(1)
tween:Play() -- Resume the tween
print("Tween resumed!")

-- Cancel all active tweens
tweenController:CancelTweens()
print("All tweens canceled!")
```

---

## **Contributing**

Feel free to submit issues or suggest improvements for `SimpleTween`! Contributions are welcome, and we’re always looking to improve functionality or add new features.

---

Let me know if you’d like any further refinements!

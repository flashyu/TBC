--[[
Name: LibStickyFrames-1.0
Revision: $Rev: 73254 $
Author(s): Toadkiller,Cladhaire,Tuller,Shadowed,JoshBorke,rophy123,Tekkub
Website: http://www.wowace.com/wiki/LibStickyFrames-1.0
Description: A library to manage snappy dragging & sticking of frames across multiple mods.
Dependencies: None
--]]

local MAJOR_VERSION = "LibStickyFrames-1.0"
local MINOR_VERSION = "$Revision: 73254 $"

--[[
A library to manage snappy dragging & sticking of frames across multiple mods.

=The vision:=
Many mods have invisible display areas or otherwise draggable frames that I need to lay out in my UI so that they do not overlap & thus can exist in harmony.  All mods with such frames will one day use this lib to accomplish the following:
* When I start dragging a bar around in Bartender3 or AutoBar, or the raid warnings frames from Deadly Boss Mods, BigWigs or other display frames from Quartz, SCT, etc. then all these frames go green & red and so on & I can see exactly where I can drag to & thus snap to or stick to so I can lay out my interface with or without overlap as I desire.
* Once the sticking code goes in it is even more beautiful since I can just drag a few frames around at that point without destroying my careful layout or getting hosed with a ui scale change...
* Since the dragging interface is standard, I am not uselessly trying ctrl-alt-shift-left&right-button drag just to move some frame around.
* All these hard to access frames suddenly become easily accesible.

=Design goals:=
* A consistent drag experience across implementing mods.
* Snapping & sticking to all registered frames + select Blizzard frames.
* Visibility & Labeling of all frames of interest while dragging (except for the Blizzard frames?)
* Private Clusters
** Private Clusters stick only to themselves.
** Private Clusters have a supplied or calculated clusterFrame which participates in general sticking.
* Grouped Frames
** Groups of frames that are stuck together can be dragged by dragging any member of the group
* Consistent interface for all these operations, including modifier keys for sticking or not snapping or unsticking etc.

=Implemented Features:=
* Enhanced StartMoving().
* Allows you to register frames in your mod to snap-to or stick-to when moving a frame around.
* Snapping & Sticking is relative to frames of all registered mods.
* There is a StickyMode that is set via stickyModeFunc and LibStickyFrames:StickyMode()
* For all participating frames in StickyMode:
** Frames are colored so they can be seen using standard colors in LibStickyFrames.Color*
** Highlights them a more intense color on mouseover
** If ctrl is held down sticking is performed in addition to the snap
** Snapping and sticking can be to some select Blizzard frames

=Planned Features:=
* There is a dragging mode that for all participating frames:
** Provides callbacks for right clicking with / without modifiers
** If ctrl is held down sticking is performed in addition to the snap
*** Sticking is to the regular snap-to target with the target having some (pink? sticking color + icon?) feedback
*** Sticking feedback adds "(Sticked To: <frameName>)" to the dragged frames label.
*** Sticking targets are colored (pink?) and an icon indicates the side sticked to?
** Provides a default cycle on left click between these states:
*** Green: shown, enabled
*** Blue: hidden
*** Red: disabled
** Perhaps the cycle is done via providing a table of callbacks with associated colors.  Green, Red, Blue have the given meanings & default colors for consistency then.
* Cluster sticking support:
** Register a set of frames to an arbitrary key value.
** Add privateLabel which if nill means stick to anything else with nil.  Otherwise docking is restricted to only frames with that privateLabel label.  So essentially it functions as a namespace.
** Add a virtual frame setting that can be calculated from the group passed in or by the mod itself so that a cluster of stuff from say a pitbull frame for example can dock as a whole using its outline & not randomly placed frames inside it.
* Drag & Click interface:
** Dragging.  Snapping is on by default.  Shift disables Snapping.  Sticking is disabled by default. Ctrl enables sticking. Whole group dragging is on by default. Alt disables whole group dragging.
*** Drag: Move a frame or grouped frames.  Snapping to eligible frames. Sticking is disabled.
*** Shift-Drag: Move a frame or grouped frames.  Snapping is disabled. Sticking is disabled.
*** Ctrl-Drag: Move a frame or grouped frames.  Sticking is done to eligible frames.
*** Alt-Drag: Move a frame (within a group).  Snapping to eligible frames. Sticking is disabled.  If frame is currently stuck its offsets relative to its parent are adjusted.
*** Alt-Shift-Drag: Move a frame (within a group).  Snapping is disabled. Sticking is disabled.  If frame is currently stuck its offsets relative to its parent are adjusted.
*** Alt-Ctrl-Drag: Move a frame (within a group).  Snapping to eligible frames. Sticking is enabled.  If frame is currently stuck it can be reparented.
** Clicking
*** Ctrl-Click: Unsticks a frame, parent becomes UIParent.  It's children stay stuck to it
*** Right-Click: Mod dependent.  Ideally this opens config UI for that frame etc.
*** Unmodified Left-Click: access for cycling through some basic frame settings (for example: shown, hidden, disabled)

=Unimplemented Features:=
* The center sticky spots: left right top bottom & center.  Offsets for outside those.
* Callbacks to manage the drags, highligthing, cycling, sticking.
* Grouping: any set of stuck frames can be moved as a whole by dragging any of its member frames
* Fine movement controls for a selected frame or perhaps just the hovered over frame (say temporary arrow keys + modifiers for 1 or SNAP_RANGE_DEFAULT pixel or grid movement)

=Example Usage=
 <OnLoad>
  this:RegisterForDrag("LeftButton")
  local myStickyInfo = {
   frameList = {frame1, frame2, frameN},
   left = 0,
   top = 0,
   right = 0,
   bottom = 0,
  }
  LibStickyFrames:Register("MyAddonName", myStickyInfo)
 </OnLoad>
 <OnDragStart>
  LibStickyFrames:StartMoving(this, myStickFunc)
 </OnDragStart>
 <OnDragStop>
  LibStickyFrames:StopMoving(this)
  LibStickyFrames:AnchorFrame(this)
 </OnDragStop>

=Origin of the Species=
This is based on code from:
[http://www.wowinterface.com/downloads/info4674-StickyFrames.html StickyFrames] by Cladhaire.
[http://www.wowwiki.com/LegoBlock LegoBlock] by Tekkub & JoshBorke.
FlyPaper by Tuller.
All mushed together in a terrible transporter accident producing the thing otherwise known as LibStickyFrames by Toadkiller.
--]]


do
	local LIBSTICKYFRAMES_MAJOR, LIBSTICKYFRAMES_MINOR = "LibStickyFrames-1.0", 1
	local LibStickyFrames = LibStub:NewLibrary(LIBSTICKYFRAMES_MAJOR, LIBSTICKYFRAMES_MINOR)
	local _G = getfenv(0)

	if LibStickyFrames then
		-- List of frames, indexed by stickyInfoName.
		LibStickyFrames.stickyInfoList = {
--[[
-- Removing these for now as they just cause confusion.  Client mods can add them themselves if needed or apropriate.
			Blizzard = {
				frameList = {
					_G["MainMenuBarArtFrame"],
					_G["CharacterMicroButton"],
				},
			},
			ChatFrames = {
				frameList = {
					_G["ChatFrame1"],
					_G["ChatFrameMenuButton"],
				},
				left = 25,
				right = 25,
			},
			MainMenuBar = {
				frameList = {
					_G["MainMenuBar"],
				},
				left = 7,
				right = 40,
			},
--]]
		}

		-- Table to temporarily hold any existing OnUpdate scripts.
		LibStickyFrames.scripts = {}

		-- Snap range in pixels.  not saved, but mods can provide an interface to change it
		LibStickyFrames.SNAP_RANGE_DEFAULT = 5
		LibStickyFrames.snapRange = LibStickyFrames.SNAP_RANGE_DEFAULT

		-- Key to hold down for sticking.  Set to IsShiftKeyDown, IsControlKeyDown or IsAltKeyDown functions.
		LibStickyFrames.IsStickKeyDown = IsControlKeyDown

		-- Key to hold down for no snapping.  Set to IsShiftKeyDown, IsControlKeyDown or IsAltKeyDown functions.
		LibStickyFrames.IsSnapDisableKeyDown = IsShiftKeyDown

		-- Default color values to use.
		LibStickyFrames.ColorHidden = {r = 1, g = 0, b = 0, a = 0.5}
		LibStickyFrames.ColorEnabled = {r = 0, g = 1, b = 0, a = 0.5}
		LibStickyFrames.ColorDisabled = {r = 0, g = 0, b = 1, a = 0.5}

		-- More intense colors while mouse is hovering over a frame
		LibStickyFrames.ColorHiddenHover = {r = 1, g = 0, b = 0, a = 0.8}
		LibStickyFrames.ColorEnabledHover = {r = 0, g = 1, b = 0, a = 0.8}
		LibStickyFrames.ColorDisabledhover = {r = 0, g = 0, b = 1, a = 0.8}

		-- Color for sticking target (while IsStickKeyDown)
		LibStickyFrames.ColorStickTarget = {r = 1, g = 0, b = 1, a = 0.5}
		LibStickyFrames.ColorStickTargetHover = {r = 1, g = 0, b = 1, a = 0.8}


		--[[
		LibStickyFrames:Register() - Sets the snap & stick frames for a mod

		stickyInfo: A table containing the following
		{
			frameList: 	An integer indexed list of frames that dragged frames should try to
						snap or stick to for your mod.  These do not have to have anything special done to them,
						and they do not really even need to exist.  Include the
						moving frame in this list, it will be ignored.

						{WatchDogFrame_player, WatchDogFrame_party1, .. WatchDogFrame_party4}

			left:		If your frame has a transparent border around the entire frame
						(think backdrops with borders).  This can be used to fine tune the
						edges when you are stickying groups.  Refers to any offset on the
						LEFT edge of the frame being moved.
			top:		same
			right:		same
			bottom:		same

			privateCluster:		String - Frames in a privateCluster can only stick to other frames with the same privateCluster label
								Default is nil to stick to other frames with none specified.
			clusterFrame:		A frame for frames not in the privateLabel to stick to.
								For example Unitframe componenets can be in a private privateLabel but clusterFrame can be their minimal outline.
								Individual Unitframes can then stick togeter without overlap via their clusterFrame.
			adjustClusterFrame:	default nil
								true: LibStickyFrames adjusts clusterFrame to be the minimal boundsRect of the frames in frameList

			funcSelf:			Optional self to pass to stickTargetFunc, cycleFunc
			funcPassValue:		Optional value to pass to stickTargetFunc, cycleFunc

			stickTargetFunc:	Callback function for sticking feedback
								stickTargetFunc([funcSelf, ]stickToFrame, isStickTarget[, funcPassValue])
								stickToFrame:	The frame that needs a StickTarget feedback change
								isStickTarget:	True to display feedback for stick target, nil to stop displaying target feedback

			cycleFunc:			Callback function for left click cycling through frame settings.  For example enabled & shown, hidden, disabled.
								stickTargetFunc([funcSelf][, funcPassValue])
								isStickTarget: True to display feedback for stick target, false to stop displaying feedback

			stickyModeFunc:		stickyModeFunc([funcSelf, ]true | false[, funcPassValue])
								true: Enable stickyMode for your mod
								false: Disable stickyMode for your mod
								Pass in one stickyModeFunc for your mod & handle multiple calls with no actual value change.
		}

		You are responsible for the stickyInfo passed in.
		A new stickyInfo overwrites the old one.
		If you keep a reference to stickyInfo you can adjust it outside of LibStickyFrames
		If you have frames with different border offsets or stickFuncs, pass in multiple stickyInfos with "myModName1", "myModName2" etc.
		--]]
		function LibStickyFrames:Register(stickyInfoName, stickyInfo)
			self.stickyInfoList[stickyInfoName] = stickyInfo
		end


		--[[
		LibStickyFrames:StickyMode(stickyMode) - Set Sticky Mode to be on or off.  All mods that supplied a stickyModeFunc are called.

		stickyMode:	nil or false to turn off StickyMode, true to turn on StickyMode
		--]]
		function LibStickyFrames:StickyMode(stickyMode)
			if (stickyMode == false) then
				stickyMode = nil
			end
			if (self.stickyMode ~= stickyMode) then
				self.stickyMode = stickyMode
				for stickyInfoName, stickyInfo in pairs(self.stickyInfoList) do
					if (stickyInfo.stickyModeFunc) then
						if (stickyInfo.funcSelf) then
							stickyInfo.stickyModeFunc(stickyInfo.funcSelf, stickyMode, stickyInfo.funcPassValue)
						else
							stickyInfo.stickyModeFunc(stickyMode, stickyInfo.funcPassValue)
						end
					end
				end
			end
		end


		--[[
		LibStickyFrames:StartMoving() - Sets a custom OnUpdate for the frame so it follows
		the mouse and snaps to the frames you specify

		frame:	 		The frame we want to move.  Typically "this"

		stickFunc:		Callback function for sticking.  nil to disable sticking
						stickFunc([stickSelf,] frame, point, stickToFrame, stickToPoint, stickToX, stickToY [, stickPassValue])
							frame:			The frame that was being dragged
							point:			The point on frame that is sticking
							stickToFrame:	The frame to stick to
							stickToPoint:	The point on stickToFrame to stick to
							stickToX:		Horizontal offset relative to stickToPoint
							stickToY:		Vetical offset relative to stickToPoint

		stickSelf:		Optional self to pass to stickFunc

		stickPassValue:	Optional value to pass to stickFunc
		--]]
		function LibStickyFrames:StartMoving(frame, stickFunc, stickSelf, stickPassValue)
			local x, y = GetCursorPosition()
			local aX, aY = frame:GetCenter()
			local aS = frame:GetEffectiveScale()
			self.stickFunc = stickFunc
			self.stickSelf = stickSelf
			self.stickPassValue = stickPassValue

			aX, aY = aX*aS, aY*aS
			local xOffset, yOffset = (aX - x), (aY - y)
			self.scripts[frame] = frame:GetScript("OnUpdate")
			frame:SetScript("OnUpdate", self:GetUpdateFunc(frame, xOffset, yOffset))
		end


		--[[
		This stops the OnUpdate, leaving the frame at its last position.  This will
		leave it anchored to UIParent.  You can call LibStickyFrames:AnchorFrame() to
		anchor it back "TOPLEFT" , "TOPLEFT" to the parent.
		--]]
		function LibStickyFrames:StopMoving(frame)
			-- Perform Sticking if requested
			if (self.point) then
				if (self.stickSelf) then
					self.stickFunc(self.stickSelf, frame, self.point, self.stickToFrame, self.stickToPoint, self.stickToX, self.stickToY, self.stickPassValue)
				else
					self.stickFunc(frame, self.point, self.stickToFrame, self.stickToPoint, self.stickToX, self.stickToY, self.stickPassValue)
				end
			end
			self.point = nil
			self.stickToFrame = nil
			self.stickToPoint = nil
			self.stickToX = nil
			self.stickToY = nil
			if (self.oldStickToFrame) then
				if (self.oldFuncSelf) then
					self.oldStickTargetFunc(self.oldFuncSelf, self.oldStickToFrame, nil, self.oldFuncPassValue)
				else
					self.oldStickTargetFunc(self.oldStickToFrame, nil, self.oldFuncPassValue)
				end
				self.oldStickTargetFunc = nil
				self.oldFuncSelf = nil
				self.oldStickToFrame = nil
				self.oldFuncPassValue = nil
			end

			frame:SetScript("OnUpdate", self.scripts[frame])
			self.scripts[frame] = nil
			self.stickFunc = nil
			self.stickSelf = nil
			self.stickPassValue = nil
		end


		--[[
		This can be called in conjunction with LibStickyFrames:StopMoving() to anchor the
		frame right back to the parent, so you can manipulate its children as a group
		(This is useful in WatchDog)
		--]]
		function LibStickyFrames:AnchorFrame(frame)
			local xA,yA = frame:GetCenter()
			local parent = frame:GetParent() or UIParent
			local xP,yP = parent:GetCenter()
			local sA,sP = frame:GetEffectiveScale(), parent:GetEffectiveScale()

			xP,yP = (xP*sP) / sA, (yP*sP) / sA

			local xo,yo = (xP - xA)*-1, (yP - yA)*-1

			frame:ClearAllPoints()
			frame:SetPoint("CENTER", parent, "CENTER", xo, yo)
		end


		--[[
		Convenience method to Stick
		frame:			The frame that was being dragged
		point:			The point on frame that is sticking
		stickToFrame:	The frame to stick to
		stickToPoint:	The point on stickToFrame to stick to
		--]]
		function LibStickyFrames:StickToFrame(frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
--AutoBar:Print("LibStickyFrames:StickToFrame frame " .. tostring(frame) .. " point " .. tostring(point) .. " stickToFrame " .. tostring(stickToFrame) .. " stickToPoint " .. tostring(stickToPoint) .. " stickToX " .. tostring(stickToX) .. " stickToY " .. tostring(stickToY))
			if (not frame or not stickToFrame or self:IsDependentOnFrame(stickToFrame, frame)) then
				return nil
			end

			if (not stickToX) then
				stickToX = 0
			end
			if (not stickToY) then
				stickToY = 0
			end

			frame:ClearAllPoints()
			frame:SetPoint(point, stickToFrame, stickToPoint, stickToX, stickToY)
		end




		--[[
		Internal Functions -- Do not call these.
		--]]


		--[[
		Returns an anonymous OnUpdate function for the frame in question.  Need
		to provide the frame, frameList along with the x and y offset (difference between
		where the mouse picked up the frame, and the insets (left,top,right,bottom) in the
		case of borders, etc.w
		--]]
		function LibStickyFrames:GetUpdateFunc(frame, xOffset, yOffset)
			return function()
				local x, y = GetCursorPosition()
				local s = frame:GetEffectiveScale()
				local stickyInfoList = self.stickyInfoList
				local IsSnapDisableKeyDown = LibStickyFrames.IsSnapDisableKeyDown

				x, y = x/s, y/s

				frame:ClearAllPoints()
				frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x + xOffset, y + yOffset)

				if (not IsSnapDisableKeyDown()) then
					for stickyInfoName, stickyInfo in pairs(stickyInfoList) do
						local frameList = stickyInfo.frameList
						for k, frameB in ipairs(frameList) do
							if frame ~= frameB then
								if self:Overlap(frame, frameB) then
									if self:SnapFrame(frame, frameB, stickyInfo) then
										break
									end
								end
							end
						end
					end
				end
			end
		end


		--[[
		Internal debug function.
		--]]
		function LibStickyFrames:debug(msg)
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00LibStickyFrames: |r"..tostring(msg))
		end


		--[[
		Determines the overlap between two frames.  Returns true if the frames
		overlap anywhere, or false if they do not.  Does not consider alpha on the edges of
		textures.
		--]]
		function LibStickyFrames:Overlap(frameA, frameB)
			local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale()
			return ((frameA:GetLeft()*sA) < (frameB:GetRight()*sB))
				and ((frameB:GetLeft()*sB) < (frameA:GetRight()*sA))
				and ((frameA:GetBottom()*sA) < (frameB:GetTop()*sB))
				and ((frameB:GetBottom()*sB) < (frameA:GetTop()*sA))
		end


		--[[
		This is called when finding an overlap between two sticky frames.  If frameA is near
		a sticky point of frameB, then it will snap to that point and return true.  If there
		is no sticky point collision, it returns false so we can test other frames for
		stickyness.
		--]]
		function LibStickyFrames:SnapFrame(frameA, frameB, stickyInfo)
			local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale()
			local xA, yA = frameA:GetCenter()
			local xB, yB = frameB:GetCenter()
			local hA, hB = frameA:GetHeight() / 2, ((frameB:GetHeight() * sB) / sA) / 2
			local wA, wB = frameA:GetWidth() / 2, ((frameB:GetWidth() * sB) / sA) / 2

			local left, top, right, bottom = stickyInfo.left or 0, stickyInfo.top or 0, stickyInfo.right or 0, stickyInfo.bottom or 0

			-- Lets translate B's coords into A's scale
			xB, yB = (xB*sB) / sA, (yB*sB) / sA

			local stickyAx, stickyAy = wA * 0.75, hA * 0.75
			local stickyBx, stickyBy = wB * 0.75, hB * 0.75

			-- Grab the points of each frame, for easier comparison
			local lA, tA, rA, bA = frameA:GetLeft(), frameA:GetTop(), frameA:GetRight(), frameA:GetBottom()
			local lB, tB, rB, bB = frameB:GetLeft(), frameB:GetTop(), frameB:GetRight(), frameB:GetBottom()

			local point, stickToPoint, stickToX, stickToY
			local snapRange = self.snapRange

			-- Translate into A's scale
			lB, tB, rB, bB = (lB * sB) / sA, (tB * sB) / sA, (rB * sB) / sA, (bB * sB) / sA

			-- If we are within snapRange pixels of the point of a sticky frame then snap to the point.
			if lA > (rB - stickyAx) then	-- Left stickyness
				if tA <= (tB + snapRange) and tA >= (tB - snapRange) then
					point = "TOPLEFT"
					stickToPoint = "TOPRIGHT"
					yA = (tB - hA)
				elseif bA <= (bB + snapRange) and bA >= (bB - snapRange) then
					point = "BOTTOMLEFT"
					stickToPoint = "BOTTOMRIGHT"
					yA = (bB + hA)
				else
					point = "LEFT"
					stickToPoint = "RIGHT"
				end

				-- Set the x sticky position
				xA = rB + (wA - left)
			elseif rA < (lB + stickyAx) then	-- Right stickyness
				if tA <= (tB + snapRange) and tA >= (tB - snapRange) then
					point = "TOPRIGHT"
					stickToPoint = "TOPLEFT"
					yA = (tB - hA)
				elseif bA <= (bB + snapRange) and bA >= (bB - snapRange) then
					point = "BOTTOMRIGHT"
					stickToPoint = "BOTTOMLEFT"
					yA = (bB + hA)
				else
					point = "RIGHT"
					stickToPoint = "LEFT"
				end

				-- Set the x sticky position
				xA = lB - (wA - right)
			elseif bA > (tB - stickyAy) then	-- Bottom stickyness
				if lA <= (lB + snapRange) and lA >= (lB - snapRange) then
					point = "BOTTOMLEFT"
					stickToPoint = "TOPLEFT"
					xA = (lB + wA)
				elseif rA >= (rB - snapRange) and rA <= (rB + snapRange) then
					point = "BOTTOMRIGHT"
					stickToPoint = "TOPRIGHT"
					xA = (rB - wA)
				else
					point = "BOTTOM"
					stickToPoint = "TOP"
				end

				-- Set the y sticky position
				yA = tB + (hA - bottom)
			elseif tA < (bB + stickyAy) then	-- Top stickyness
				if lA <= (lB + snapRange) and lA >= (lB - snapRange) then
					point = "TOPLEFT"
					stickToPoint = "BOTTOMLEFT"
					xA = (lB + wA)
				elseif rA >= (rB - snapRange) and rA <= (rB + snapRange) then
					point = "TOPRIGHT"
					stickToPoint = "BOTTOMRIGHT"
					xA = (rB - wA)
				else
					point = "TOP"
					stickToPoint = "BOTTOM"
				end

				-- Set the y sticky position
				yA = bB - (hA - bottom)
			end

			-- Snap to the found point
			if point then
				frameA:ClearAllPoints()
				frameA:SetPoint("CENTER", UIParent, "BOTTOMLEFT", xA, yA)

				-- Remember Sticking stuff
				if (self.IsStickKeyDown() and self.stickFunc) then
					self.point = point
					self.stickToFrame = frameB
					self.stickToPoint = stickToPoint
					self.stickToX = nil
					self.stickToY = nil
					if (self.oldStickToFrame and self.oldStickToFrame ~= frameB) then
--AutoBar:Print("LibStickyFrames:SnapFrame self.oldFuncSelf " .. tostring(self.oldFuncSelf) .. " self.oldStickToFrame " .. tostring(self.oldStickToFrame) .. " self.oldFuncPassValue " .. tostring(self.oldFuncPassValue))
						if (self.oldFuncSelf) then
							self.oldStickTargetFunc(self.oldFuncSelf, self.oldStickToFrame, nil, self.oldFuncPassValue)
						else
							self.oldStickTargetFunc(self.oldStickToFrame, nil, self.oldFuncPassValue)
						end
						self.oldStickTargetFunc = nil
						self.oldFuncSelf = nil
						self.oldStickToFrame = nil
						self.oldFuncPassValue = nil
					end
					if (stickyInfo.stickTargetFunc) then
--AutoBar:Print("LibStickyFrames:SnapFrame stickyInfo.funcSelf " .. tostring(stickyInfo.funcSelf) .. " stickyInfo.stickToFrame " .. tostring(stickyInfo.stickToFrame) .. " stickyInfo.funcPassValue " .. tostring(stickyInfo.funcPassValue))
						if (stickyInfo.funcSelf) then
							stickyInfo.stickTargetFunc(stickyInfo.funcSelf, frameB, true, stickyInfo.funcPassValue)
						else
							stickyInfo.stickTargetFunc(frameB, true, stickyInfo.funcPassValue)
						end
						self.oldStickTargetFunc = stickyInfo.stickTargetFunc
						self.oldFuncSelf = stickyInfo.funcSelf
						self.oldStickToFrame = frameB
						self.oldFuncPassValue = stickyInfo.funcPassValue
					end
				else
					self.point = nil
					self.stickToFrame = nil
					self.stickToPoint = nil
					self.stickToX = nil
					self.stickToY = nil
				end
				return true
			end
		end



		-- FLYPAPER
		-- Handles sticking frames to eachother using relative positioning
		-- credit to Tuller for this

		function LibStickyFrames:IsDependentOnFrame(frame, otherFrame)
			if (frame and otherFrame) then
				if (frame == otherFrame) then
					return true
				end

				local points = frame:GetNumPoints()
				for i = 1, points do
					local parent = select(2, frame:GetPoint(i))
					if (self:IsDependentOnFrame(parent, otherFrame)) then
						return true
					end
				end
			end

			return nil
		end

		--returns true if its actually possible to attach the two frames without error
		function LibStickyFrames:CanAttach(frame, otherFrame)
			if (not frame and not otherFrame) then
				return nil
			elseif (frame:GetWidth() == 0 or frame:GetHeight() == 0 or otherFrame:GetWidth() == 0 or otherFrame:GetHeight() == 0) then
				return nil
			elseif (self:IsDependentOnFrame(otherFrame, frame)) then
				return nil
			end

			return true
		end


		local function ReheadFrames(block, newHead)
			if( block == newHead ) then
				return
			end

			local origBlock = newHead or block
			block.headLB = origBlock

			if( frameLinks[block] ) then
				for frame in pairs(frameLinks[block]) do
					frame.headLB = origBlock
					reheadFrames(frame, origBlock)
				end
			end
		end

		-- We need to clean this up later, but it works fine for now.
		-- reverse the SetPoint connections (it's a silly linked list)
		-- means we can do it iteratively
		-- pass in the original node
		local function ReverseStick(block)
			local origblock = block
			-- if there is no next block then return
			if( not stickiedFrames[block] ) then
				return
			end
			local prevBlock = nil
			while( block ) do
				local nextBlock = stickiedFrames[block]
				--block.headLB = origblock

				stickiedFrames[block] = prevBlock
				-- if we have a nextBlock then
				if( nextBlock ) then
					-- remove the current block from the next block's list of attached
					-- blocks
					frameLinks[nextBlock][block] = nil
					-- add the next block to the current block's list of attached
					-- blocks
					frameLinks[block][nextBlock] = true
				end

				block:ClearAllPoints()
				prevBlock = block
				block = nextBlock

				if( prevBlock.stickPoint ) then
					local point = string_sub(prevBlock.stickPoint, 0, 1)
					if( point == "T" ) then
						prevBlock.stickPoint = "B" .. string_sub(prevBlock.stickPoint, 2)
					elseif( point == "B" ) then
						prevBlock.stickPoint = "T" .. string_sub(prevBlock.stickPoint, 2)
					elseif( point == "L" ) then
						prevBlock.stickPoint = "R" .. string_sub(prevBlock.stickPoint, 2)
					elseif( point == "R" ) then
						prevBlock.stickPoint = "L" .. string_sub(prevBlock.stickPoint, 2)
					else
						prevBlock.stickPoint = nil
					end
				end
			end

			block = prevBlock
			-- rehead all frames connected to this block (it was the previous head)
			reheadFrames(block, origblock)

			while( block ) do
				block:ClearAllPoints()
				local nextBlock = stickiedFrames[block]
				if( nextBlock ) then
					block.stickPoint = FlyPaper:StickToPoint(block, nextBlock, nextBlock.stickPoint, xOff, yOff)
				end
				block = nextBlock
			end
		end

	end
end


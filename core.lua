if not IsAddOnLoaded("FreeUI") and not IsAddOnLoaded("Aurora") then return end

local F, C = unpack(Aurora or FreeUI)

hooksecurefunc(mrp, "CreateBrowseFrame", function()
	local bg = CreateFrame("Frame", nil, MyRolePlayBrowseFrame)
	bg:SetPoint("TOPLEFT")
	bg:SetPoint("BOTTOMRIGHT")
	bg:SetFrameLevel(MyRolePlayBrowseFrame:GetFrameLevel()-1)
	F.CreateBD(bg)
	F.CreateSD(bg)

	MyRolePlayBrowseFrame:DisableDrawLayer("BACKGROUND")
	MyRolePlayBrowseFrame:DisableDrawLayer("BORDER")
	MyRolePlayBrowseFramePortraitFrame:Hide()
	MyRolePlayBrowseFrameTopBorder:Hide()
	MyRolePlayBrowseFrameTopRightCorner:Hide()
	MyRolePlayBrowseFrameInset:DisableDrawLayer("BORDER")
	MyRolePlayBrowseFrameInsetBg:Hide()

	F.ReskinTab(MyRolePlayBrowseFrameTab1)
	F.ReskinTab(MyRolePlayBrowseFrameTab2)

	MyRolePlayBrowseFramePortrait:Hide()

	F.ReskinClose(MyRolePlayBrowseFrameCloseButton)
	F.ReskinScroll(MyRolePlayBrowseFrameAScrollFrameScrollBar)
	F.ReskinScroll(MyRolePlayBrowseFrameBScrollFrameScrollBar)
end)

hooksecurefunc(mrp, "AddMRPTab", function()
	F.ReskinTab(CharacterFrameTab5)
	CharacterFrameTab5:SetText("Profile")
end)

hooksecurefunc(mrp, "CreateEditFrames", function()
	MyRolePlayMultiEditFrame:DisableDrawLayer("BORDER")
	MyRolePlayMultiEditFrameBg:Hide()
	MyRolePlayMultiEditFrameScrollFrameTop:Hide()
	MyRolePlayMultiEditFrameScrollFrameBottom:Hide()

	F.Reskin(MyRolePlayMultiEditFrameOK)
	F.Reskin(MyRolePlayMultiEditFrameCancel)
	F.Reskin(MyRolePlayMultiEditFrameInherit)
	F.Reskin(MyRolePlayComboEditFrameOK)
	F.Reskin(MyRolePlayComboEditFrameCancel)
	F.Reskin(MyRolePlayComboEditFrameInherit)
	F.Reskin(MyRolePlayCharacterFrame_NewProfileButton)
	F.Reskin(MyRolePlayCharacterFrame_RenProfileButton)
	F.Reskin(MyRolePlayCharacterFrame_DelProfileButton)
	F.Reskin(MyRolePlayEditFrameOK)
	F.Reskin(MyRolePlayEditFrameCancel)
	F.Reskin(MyRolePlayEditFrameInherit)

	F.CreateBD(MyRolePlayEditFrame.editbox, .25)

	MyRolePlayCharacterFrame_ProfileComboBox:SetPoint("TOP", CharacterFrameInset, "TOP", 0, 22)
	MyRolePlayCharacterFrame_ProfileComboBox.text:SetPoint("LEFT", MyRolePlayCharacterFrame_ProfileComboBox, "LEFT", 27, 2)

	local comboboxes = {"MyRolePlayCharacterFrame_ProfileComboBox", "MyRolePlayComboEditFrameComboBox"}
	for _, f in pairs(comboboxes) do
		local frame = _G[f]

		for i = 1, 3 do
			select(i, frame:GetRegions()):SetAlpha(0)
		end


		local down = _G[f.."_Button"] or _G[f.."Button"]
		down:SetSize(20, 20)
		down:ClearAllPoints()
		down:SetPoint("RIGHT", -18, 2)

		F.Reskin(down)

		local downtex = down:CreateTexture(nil, "OVERLAY")
		if IsAddOnLoaded("FreeUI") then
			downtex:SetTexture("Interface\\AddOns\\FreeUI\\media\\arrow-down-active")
		else
			downtex:SetTexture("Interface\\AddOns\\Aurora\\arrow-down-active")
		end
		downtex:SetSize(8, 8)
		downtex:SetPoint("CENTER")
		downtex:SetVertexColor(1, 1, 1)

		local bg = CreateFrame("Frame", nil, frame)
		bg:SetPoint("TOPLEFT", 16, -4)
		bg:SetPoint("BOTTOMRIGHT", -18, 8)
		F.CreateBD(bg, 0)

		local tex = frame:CreateTexture(nil, "BACKGROUND")
		tex:SetPoint("TOPLEFT", 17, -5)
		tex:SetPoint("BOTTOMRIGHT", -19, 9)
		tex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
		tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)
	end

	F.ReskinScroll(MyRolePlayMultiEditFrameScrollFrameScrollBar)
end)

hooksecurefunc(mrp, "CreateOptionsPanel", function()
	F.ReskinCheck(MyRolePlayOptionsPanel_Enable)
	F.ReskinCheck(MyRolePlayOptionsPanel_MRPButton)
	F.ReskinCheck(MyRolePlayOptionsPanel_RPChatName)
	F.ReskinCheck(MyRolePlayOptionsPanel_Biog)
	F.ReskinCheck(MyRolePlayOptionsPanel_FormAC)
	F.ReskinCheck(MyRolePlayOptionsPanel_EquipAC)
	F.ReskinDropDown(MyRolePlayOptionsPanel_TTStyle)
	F.ReskinDropDown(MyRolePlayOptionsPanel_HeightUnit)
	F.ReskinDropDown(MyRolePlayOptionsPanel_WeightUnit)
end)

local function reskinHeader(c, field)
	for i = 1, field:GetNumChildren() do
		local f = select(i, field:GetChildren())
		if not f.reskinned then
			F.CreateBD(f.h, 0)
			f.h.SetBackdrop = F.dummy

			F.CreateGradient(f.h)

			f.h.fs:SetPoint("TOPLEFT", f.h, "TOPLEFT", 0, 1)

			if f.sep then
				f.sep:SetAlpha(0)
			end

			f.reskinned = true
		end
	end
end

hooksecurefunc(mrp, "CreateCFpfield", reskinHeader)
hooksecurefunc(mrp, "CreateBFpfield", reskinHeader)

local strsub, format, select = strsub, format, select

local RAID_CLASS_COLORS_CODE = setmetatable( {}, { __index = function( table, key )
	table[ key ] = C.classcolours[ key ] and format( "|cff%02x%02x%02x", C.classcolours[ key ].r * 255, C.classcolours[ key ].g * 255, C.classcolours[ key ].b * 255 ) or ""
	return table[ key ]
end } )

local RPEVENTS = {
	["CHAT_MSG_SAY"] = true,
	["CHAT_MSG_EMOTE"] = true,
	["CHAT_MSG_TEXT_EMOTE"] = true,
	["CHAT_MSG_YELL"] = true,
}

local function mrp_GetColoredName( event, message, sender, language, arg4, arg5, arg6, arg7, arg8, arg9, arg10, lineid, guid )
	if mrpSaved.Options.ShowRPNamesInChat and RPEVENTS[ event ] and sender and sender ~= UNKNOWN and msp.char[ sender ].supported and msp.char[ sender ].time.NA and mrp.DisplayChat.NA( msp.char[ sender ].field.NA ) ~= "" and mrp.DisplayChat.NA( msp.char[ sender ].field.NA ) ~= sender then
		if ChatTypeInfo[ strsub( event, 10 ) or "" ] and ChatTypeInfo[ strsub( event, 10 ) or "" ].colorNameByClass and guid ~= "" then
			return format( "%s%s|r", RAID_CLASS_COLORS_CODE[ ( select( 2, GetPlayerInfoByGUID( guid ) ) ) ], mrp.DisplayChat.NA( msp.char[ sender ].field.NA ) )
		else
			return mrp.DisplayChat.NA( msp.char[ sender ].field.NA )
		end
	else
		return mrp_Prehook_GetColoredName( event, message, sender, language, arg4, arg5, arg6, arg7, arg8, arg9, arg10, lineid, guid )
	end
end

function mrp:HookChatName()
	mrp_Prehook_GetColoredName = GetColoredName
	GetColoredName = mrp_GetColoredName
end

function mrp:UnhookChatName()
	GetColoredName = mrp_Prehook_GetColoredName
end

hooksecurefunc(mrp, "CreateMRPButton", function()
	local MyRolePlayButton = MyRolePlayButton

	MyRolePlayButton:SetNormalTexture("Interface\\Icons\\INV_Misc_Book_07")
	MyRolePlayButton:SetHighlightTexture("")
	MyRolePlayButton:SetPushedTexture("Interface\\Icons\\INV_Misc_Book_07")
	MyRolePlayButton:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
	MyRolePlayButton:GetPushedTexture():SetTexCoord(.08, .92, .08, .92)
	F.CreateBG(MyRolePlayButton)

	if FreeUI then
		MyRolePlayButton:ClearAllPoints()
		MyRolePlayButton:SetScript("OnShow", function(self)
			self:SetPoint("LEFT", oUF_FreeTarget, "RIGHT", 5, 0)
		end)

		MyRolePlayButton:SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				mrp:Show(mrp:UnitNameWithRealm("target"))
			end
		end)
	end
end)
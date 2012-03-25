if not IsAddOnLoaded("FreeUI") and not IsAddOnLoaded("Aurora") then return end

local F = unpack(Aurora or FreeUI)

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

	F.CreateTab(MyRolePlayBrowseFrameTab1)
	F.CreateTab(MyRolePlayBrowseFrameTab2)

	MyRolePlayBrowseFramePortrait:Hide()

	F.ReskinClose(MyRolePlayBrowseFrameCloseButton)
	F.ReskinScroll(MyRolePlayBrowseFrameAScrollFrameScrollBar)
	F.ReskinScroll(MyRolePlayBrowseFrameBScrollFrameScrollBar)

	select(2, MyRolePlayBrowseFrameAScrollFrameScrollBar:GetRegions()):Hide()
	select(2, MyRolePlayBrowseFrameBScrollFrameScrollBar:GetRegions()):Hide()
	MyRolePlayBrowseFrameAScrollFrameScrollBarThumbTexture:Hide()
	MyRolePlayBrowseFrameBScrollFrameScrollBarThumbTexture:Hide()
	MyRolePlayBrowseFrameAScrollFrameScrollBarThumbTexture.bg:Hide()
	MyRolePlayBrowseFrameBScrollFrameScrollBarThumbTexture.bg:Hide()
end)

hooksecurefunc(mrp, "AddMRPTab", function()
	F.CreateTab(CharacterFrameTab5)
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
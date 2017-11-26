/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(ord("O"))) {v_drawForm = !v_drawForm;}

if (v_drawForm)
{
x = oCamera.v_nullPosX;
y = oCamera.v_nullPosY + 70;

var tmp_c;
tmp_c = true;

if (v_lastSelectedIndex != -1) {if (v_menuItems[v_lastSelectedIndex, 2] > 4) {tmp_c = false;}}

if (v_selectionDone)
{
	v_layoutW = lerp(v_layoutW, 600, 0.1);
	v_layoutH = lerp(v_layoutH, 400, 0.1);
}
else if (tmp_c)
{
	v_layoutW = lerp(v_layoutW, 230, 0.1);
	v_layoutH = lerp(v_layoutH, 210, 0.1);
}


u = libUtilityDrawForm(x, y, v_layoutW, v_layoutH, v_formAlpha);
libDrawMenu(x + 8, y + 10, v_menuItems, v_formAlpha, false);

draw_text(mouse_x, mouse_y, v_menuAlpha); 

if (v_menuReady)
{
	v_menuAlpha = lerp(v_menuAlpha, 1, 0.1);
}
else
{
	v_menuAlpha = lerp(v_menuAlpha, 0, 0.1);
}

if (v_menuAlpha > 0.05 && v_lastSelectedIndex != -1)
{
	time++;
	if ((v_menuItems[v_lastSelectedIndex, 2] - 30) / 150 > 0.05)
	{
		var xSet, tmp_alpha, tmp_yoffset;
		xSet = -160 + 160 * (v_menuItems[v_lastSelectedIndex, 2] / 180);
		tmp_alpha = max(min(((v_menuItems[v_lastSelectedIndex, 2] - 30) / 150), v_formAlpha), 0);
		tmp_yoffset = 64;
		#region Status
		if (v_lastSelectedIndex == 0)
		{	
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_sprite_part(oInventory.v_inventorySprite, 0, 117, 144, 16, 16, x + 156 + xSet,y + 20);
			draw_sprite_part(oInventory.v_inventorySprite, 0, 133, 144, 16, 16, x + 450 + xSet,y + 20);
		
			var tmp_stringRest;
			tmp_stringRest = "";
		
			if (oHUD.v_playerSkillPointsAttributes > 0) {tmp_stringRest = " (" + _sc("+" + string(oHUD.v_playerSkillPointsAttributes), c_lime) + ")";}
		
			// Draw status
			draw_text_colored(x + 16 + xSet,y + 53, "Attributes" + tmp_stringRest, -1, fntPixelBig, c_black);
			draw_line_width(x + 15+ xSet, y + 72, x + 150+ xSet, y + 72, 2);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
		
			for (var i = 0; i < array_length_1d(v_statusAttributes); i++)
			{			
				if (tmp_stringRest != "")
				{
					var tmp_color;
					tmp_color = c_white;
				
					if (point_in_rectangle(mouse_x, mouse_y, x + 17 + xSet + 20 + 140 , y + 80 + i * 16 + 1, x + 17 + xSet + 20 + 140 + 8, y + 80 + i * 16 + 15))
					{
						tmp_color = c_lime;	
						cpStatusMenuAssignPointAttribute(v_statusAttributes[i], false);
					
						if (mouse_check_button_pressed(mb_left))
						{
							oHUD.v_playerProperty[v_statusAttributes[i]]++;
							oHUD.v_playerSkillPointsAttributes--;
							cpStatusMenuAssignPointAttribute(v_statusAttributes[i], true);
						}
					}
				
					draw_text_colored(x + 17 + xSet + 20 + 140, y + 80 + i * 16, "+", -1, fntPixelSmall, tmp_color);	
				}
			
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
				z = libUtilityPropertyToString(v_statusAttributes[i]);
				draw_text_colored(x + 17 + xSet + 20, y + 80 + i * 16, z[0] + ": ", -1, fntPixelLess, c_black);
			
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
				draw_text_colored(x + 17 + xSet + 20 + 110, y + 80 + i * 16, _sc(string(oHUD.v_playerPropertyTotal[v_statusAttributes[i]] + v_propertyTemp[v_statusAttributes[i]]), c_white), -1, fntPixelLess, c_white);
			
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			
				draw_sprite_ext(sElements, 4 + i, x + xSet + 8 + 16, y + 88  + i * 16, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			}
		
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			fnt(fntPixelBig);
			draw_text(x + 16+ xSet, y + 53  + 220, "Condition");
			draw_line_width(x + 15+ xSet, y + 72 + 220, x + 150+ xSet, y + 72 + 220, 2);
			fnt(fntPixel);
		
			var tmp_color, tmp_dif;
			tmp_color = c_white;
			tmp_dif = "";		
			if (v_propertyTemp[e_inventoryProperties.valHp] != 0) {tmp_color = c_lime; tmp_dif = "(" + _sc("+" + string(v_propertyTemp[e_inventoryProperties.valMaxHp]), c_lime) + ")";}

			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 17 + xSet + 20, y + 80 + 220, "Health" + ": ", -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 17 + xSet + 20 + 80, y + 80 + 220,  _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valHp] + v_propertyTemp[e_inventoryProperties.valHp]), tmp_color)  + "/" + _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valMaxHp] + v_propertyTemp[e_inventoryProperties.valHp]), tmp_color) + tmp_dif, -1, fntPixelLess, c_black);

			tmp_dif = "";		
			tmp_color = c_white;
			if (v_propertyTemp[e_inventoryProperties.valMp] != 0) {tmp_color = c_lime; tmp_dif = "(" + _sc("+" + string(v_propertyTemp[e_inventoryProperties.valMaxMp]), c_lime) + ")";}
		
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 17 + xSet + 20, y + 80 + 220 + 16, "Mana" + ": ", -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 17 + xSet + 20 + 80, y + 80 + 220 + 16, _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valMp] + v_propertyTemp[e_inventoryProperties.valMp]), tmp_color)  + "/" + _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valMaxMp] + v_propertyTemp[e_inventoryProperties.valMaxMp]), tmp_color) + tmp_dif, -1, fntPixelLess, c_black);
		
			tmp_dif = "";	
			tmp_color = c_white;
			if (v_propertyTemp[e_inventoryProperties.valSp] != 0) {tmp_color = c_lime; tmp_dif = "(" + _sc("+" + string(v_propertyTemp[e_inventoryProperties.valMaxSp]), c_lime) + ")";}

			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 17 + xSet + 20, y + 80 + 220 + 32, "Stamina" + ": ", -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 17 + xSet + 20 + 80, y + 80 + 220 + 32, _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valSp] + v_propertyTemp[e_inventoryProperties.valSp]), tmp_color)  + "/" + _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valMaxSp] + v_propertyTemp[e_inventoryProperties.valMaxSp]), tmp_color) + tmp_dif, -1, fntPixelLess, c_black);		
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
		
			draw_sprite_ext(sElements, 14, x + 17 + xSet + 8, y + 80 + 220 + 8, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
			draw_sprite_ext(sElements, 15, x + 17 + xSet + 8, y + 80 + 220 + 8 + 16, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
			draw_sprite_ext(sElements, 16, x + 17 + xSet + 8, y + 80 + 220 + 8 + 32, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
		
			var tmp_stringRest;
			tmp_stringRest = "";
		
			if (oHUD.v_playerSkillPointsAbilities > 0) {tmp_stringRest = " (" + _sc("+" + string(oHUD.v_playerSkillPointsAbilities), c_lime) + ")";}
		
			draw_text_colored(x + 16 + 200+ xSet, y + 53, "Abilities" + tmp_stringRest, -1, fntPixelBig, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_line_width(x + 15 + 200+ xSet, y + 72, x + 150 + 200+ xSet, y + 72, 2);
			fnt(fntPixel);	
		
			alg("center");
			var tmp_color, tmp_color2;
			tmp_color = c_black;
			tmp_color2 = c_black;
		
			if (point_in_rectangle(mouse_x, mouse_y, x + 15 + 200+ xSet, y + 72, x + 15 + 200+ xSet + 70, y + 72 + 30))
			{
				if (v_currentAbility != 0)
				{
					tmp_color = c_white;	
				
					if (mouse_check_button_pressed(mb_left))
					{
						v_currentAbility--;	
					}
				}
			}
		
			if (point_in_rectangle(mouse_x, mouse_y, x + 15 + 200+ xSet + 71, y + 72, x + 15 + 200+ xSet + 140, y + 72 + 30))
			{
				if (v_currentAbility < array_length_1d(v_statusAbility) - 1)
				{
					tmp_color2 = c_white;	
				
					if (mouse_check_button_pressed(mb_left))
					{
						v_currentAbility++;	
					}
				}
			}
		
			var tmp_text1 = _sc("< ", tmp_color) + string(v_statusAbility[v_currentAbility]) + _sc(" >", tmp_color2);
		
			draw_text_colored(x + 15 + 160+ xSet - string_width(libUtilityParseTextColored(tmp_text1, fntPixel)) / 2 + 110, y + 72 + 16, tmp_text1, -1, fntPixel, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			alg();
		
			var tmp_addIndex;
			tmp_addIndex = 0;
		
			if (v_currentAbility == 0) {tmp_addIndex = 17;}
			if (v_currentAbility == 1) {tmp_addIndex = 29;}
		
			for (var i = 0; i < array_length_2d(v_statusAbilitySub, v_currentAbility); i++)
			{
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
				z = libUtilityPropertyToString(v_statusAbilitySub[v_currentAbility, i]);
				draw_text_colored(x + 17 + xSet + 20 + 200, y + 80 + 20 + i * 16, z[0] + ": ", -1, fntPixelLess, c_black);	
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
				draw_text_colored(x + 17 + xSet + 20 + 200 + 120, y + 80 + 20 + i * 16, _sc(string(oHUD.v_playerPropertyTotal[v_statusAbilitySub[v_currentAbility, i]]), c_white), -1, fntPixelLess, c_black);	
			
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
				draw_sprite_ext(sElements, tmp_addIndex + i, x + 25 + 200 + xSet, y + 80 + 28 + i * 16, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
			
				if (oHUD.v_playerSkillPointsAbilities > 0)
				{
					tmp_color = c_white;
				
					if (point_in_rectangle(mouse_x, mouse_y, x + 17 + xSet + 20 + 200 + 120 + 30, y + 80 + 20 + i * 16, x + 17 + xSet + 20 + 200 + 120 + 30 + 10, y + 80 + 20 + i * 16 + 12))
					{
						tmp_color = c_lime;	
					
						if (mouse_check_button_pressed(mb_left))
						{
							oHUD.v_playerSkillPointsAbilities--;
							oHUD.v_playerProperty[v_statusAbilitySub[v_currentAbility, i]]++;
						}
					}
				
					draw_text_colored(x + 17 + xSet + 20 + 200 + 120 + 30, y + 80 + 20 + i * 16, "+", -1, fntPixelSmall, tmp_color);	
				
				}
			}
	
		
		
			fnt(fntPixelBig);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text(x + 16 + 200+ xSet, y + 53 + 220, "Resiliences");
			draw_line_width(x + 15 + 200+ xSet, y + 72 + 220, x + 150 + 200+ xSet, y + 72 + 220, 2);
			fnt(fntPixel);	
		
			var tmp_dif2, tmp_dif3, tmp_dif4, tmp_color2, tmp_color3, tmp_color4;
			tmp_dif = "";	
			tmp_dif2 = "";
			tmp_dif3 = "";
			tmp_dif4 = "";
			tmp_color = c_white;
			tmp_color2 = c_white;
			tmp_color3 = c_white;
			tmp_color4 = c_white;
			if (v_propertyTemp[e_inventoryProperties.valResistEarth] != 0) {tmp_color = c_lime; tmp_dif = " (" + _sc("+" + string(v_propertyTemp[e_inventoryProperties.valResistEarth]), c_lime) + ")";}
			if (v_propertyTemp[e_inventoryProperties.valResistFire] != 0) {tmp_color2 = c_lime; tmp_dif2 = " (" + _sc("+" + string(v_propertyTemp[e_inventoryProperties.valResistFire]), c_lime) + ")";}
			if (v_propertyTemp[e_inventoryProperties.valResistAir] != 0) {tmp_color3 = c_lime; tmp_dif3 = " (" + _sc("+" + string(v_propertyTemp[e_inventoryProperties.valResistAir]), c_lime) + ")";}
			if (v_propertyTemp[e_inventoryProperties.valResistWater] != 0) {tmp_color4 = c_lime; tmp_dif4 = " (" + _sc("+" + string(v_propertyTemp[e_inventoryProperties.valResistWater]), c_lime) + ")";}


			// <earth, fire, air, water>		
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet, y + 80 + 220, _sc("Taurus: ", c_orange), -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet + 80, y + 80 + 220, _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valResistEarth]), tmp_color) + tmp_dif, -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet, y + 80 + 220 + 16, _sc("Scorpio: ", c_red), -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet + 80, y + 80 + 220 + 16, _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valResistFire]), tmp_color2) + tmp_dif2, -1, fntPixelLess, c_black);		
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet, y + 80 + 220 + 32, _sc("Libra: ", make_color_rgb(230,230,250)), -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet + 80, y + 80 + 220 + 32, _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valResistAir]), tmp_color3)  + tmp_dif3, -1, fntPixelLess, c_black);		
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet, y + 80 + 220 + 48, _sc("Pisces: ", make_color_rgb(135,206,250)), -1, fntPixelLess, c_black);
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
			draw_text_colored(x + 20 + 17+ 200 + xSet + 80, y + 80 + 220 + 48, _sc(string(oHUD.v_playerPropertyTotal[e_inventoryProperties.valResistWater]), tmp_color4) + tmp_dif4, -1, fntPixelLess, c_black);		
			clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
		
			draw_sprite_ext(sElements, 0, x + 25+ 200 + xSet, y + 88 + 220, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
			draw_sprite_ext(sElements, 1, x + 25+ 200 + xSet, y + 88 + 220 + 16, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
			draw_sprite_ext(sElements, 3, x + 25+ 200 + xSet, y + 88 + 220 + 32, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
			draw_sprite_ext(sElements, 2, x + 25+ 200 + xSet, y + 88 + 220 + 48, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
	
			fnt(fntPixelBig);
			draw_text(x + 16 + 400+ xSet, y + 53, "Statistics");
			draw_line_width(x + 15 + 400+ xSet, y + 72, x + 150 + 400+ xSet, y + 72, 2);
			fnt(fntPixel);	
		
			for (var i = 0; i < array_length_1d(v_statusStatictics); i++)
			{
				var tmp_suffix;
				tmp_suffix = "";
			
				if (i == 4) {tmp_suffix = "%";}
				if (i == 5) {tmp_suffix = "x ";}
			
				var tmp_color, tmp_dif;
				tmp_color = c_white;
				tmp_dif = "";		
				if (v_propertyTemp[v_statusStatictics[i]] != 0) {tmp_color = c_lime; tmp_dif = "(" + _sc("+" + string(v_propertyTemp[v_statusStatictics[i]]), c_lime) + ")";}

			
				z = libUtilityPropertyToString(v_statusStatictics[i]);
				draw_text_colored(x + 20 + 17+ 400 + xSet, y + 80 + i * 16, z[0] + ": ", -1, fntPixelLess, c_black);			
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));			
				draw_text_colored(x + 20 + 17+ 400 + xSet + 130, y + 80 + i * 16, _sc(string(oHUD.v_playerPropertyTotal[v_statusStatictics[i]] + v_propertyTemp[v_statusStatictics[i]]) + tmp_suffix, tmp_color) + tmp_dif, -1, fntPixelLess, c_black);			
				clr(-1, max(((v_menuItems[0, 2] - 30) / 150), 0));
				draw_sprite_ext(sElements, 21 + i, x + 25+ 400 + xSet, y + 88 + i * 16, 0.45, 0.45, 0, c_white, max(((v_menuItems[0, 2] - 30) / 150)));
			}
		
			fnt(fntPixelBig);
			draw_text(x + 16 + 400+ xSet, y + 53 + 220, "Edges");
			draw_line_width(x + 15 + 400+ xSet, y + 72 + 220, x + 150 + 400+ xSet, y + 72 + 220, 2);
			fnt(fntPixel);	

		}
		#endregion
		#region Grimoire
		if (v_lastSelectedIndex == 1)
		{				
			clr(-1, tmp_alpha);				
			draw_sprite_part(oInventory.v_inventorySprite, 0, 117, 144, 16, 16, x + 156 + xSet, y + 20);
			draw_sprite_part(oInventory.v_inventorySprite, 0, 133, 144, 16, 16, x + 450 + xSet, y + 20);
			
			if (v_spellSelected != -1)
			{
				v_alphaImage = lerp(v_alphaImage, 1, 0.1);
				
				var tmp_xO;
				tmp_xO = 64 - v_alphaImage * 64;
				
				clr(-1, tmp_alpha);
				fnt(fntPixelBig);
				draw_text(x + xSet + 220 - tmp_xO, y + tmp_yoffset + 34, oHUD.v_playerSpell[g_spellList[| v_spellSelected], 0]);
				draw_line_width(x + xSet + 220 - tmp_xO, y + tmp_yoffset + 52, x + xSet + 250 - tmp_xO + 350, y + tmp_yoffset + 52, 2);
				
				fnt(fntPixelLess);
				tmp_callY = draw_text_colored(x + xSet + 220 - tmp_xO, y + tmp_yoffset + 60, oHUD.v_playerSpell[g_spellList[| v_spellSelected], 2], 300, fntPixelLess, c_black);
				clr(-1, tmp_alpha);
				draw_text_colored(x + xSet + 220 - tmp_xO, tmp_callY + 24, "Mana cost: " + _sc(string(oHUD.v_playerSpellStaticstics[g_spellList[| v_spellSelected], 1]), c_aqua), 300, fntPixelLess, c_black);
				clr(-1, tmp_alpha);
				
				var tmp_index;
				tmp_index = 0;
				
				fnt();
				draw_text(x + xSet + 220 - tmp_xO, tmp_callY + 60, "Statistics:");
				draw_line_width(x + xSet + 220 - tmp_xO, tmp_callY + 77, x + xSet + 420 - tmp_xO - 30, tmp_callY + 77, 2);
				
				// Render statistics
				for (var i = 4; i < array_length_2d(oHUD.v_playerSpellStaticstics, g_spellList[| v_spellSelected]) - 1; i += 4)
				{
					clr(-1, tmp_alpha);
					draw_text_colored(x + xSet + 220 - tmp_xO, tmp_callY + 90 + tmp_index * 20, string(oHUD.v_playerSpellStaticstics[g_spellList[| v_spellSelected], i]) + ": ", 300, fntPixelLess, c_black);	
					clr(-1, tmp_alpha);
					draw_text_colored(x + xSet + 220 - tmp_xO + 150, tmp_callY + 90 + tmp_index * 20, _sc(string(oHUD.v_playerSpellStaticstics[g_spellList[| v_spellSelected], i + 1]), c_white) + _sc(string(oHUD.v_playerSpellStaticstics[g_spellList[| v_spellSelected], i + 3]), c_white), 300, fntPixelLess, c_black);	
					 
					tmp_index++;
				}
				
				fnt();
				clr(-1, tmp_alpha);
				draw_text(x + xSet + 220 - tmp_xO + 220, tmp_callY + 60, "Enchancements:");
				draw_line_width(x + xSet + 220 - tmp_xO + 220, tmp_callY + 77, x + xSet + 420 - tmp_xO + 220 - 30, tmp_callY + 77, 2);
				
				
				// Render upgrades
				var tmp_hit;
				tmp_hit = -1;				
				tmp_index = 0;
				for (var i = 0; i < array_length_2d(oHUD.v_playerSpellUpgrade, g_spellList[| v_spellSelected]); i += 8)
				{
					clr(-1, tmp_alpha);
					draw_text_colored(x + xSet + 220 - tmp_xO + 220, tmp_callY + 90 + tmp_index * 24, string(oHUD.v_playerSpellUpgrade[g_spellList[| v_spellSelected], i]) + " (" + string(oHUD.v_playerSpellUpgrade[g_spellList[| v_spellSelected], i + 1]) + "/" + string(oHUD.v_playerSpellUpgrade[g_spellList[| v_spellSelected], i + 2]) + ")", -1, fntPixelLess, c_black);						
					
					if (point_in_rectangle(mouse_x, mouse_y, x + xSet + 220 - tmp_xO + 220, tmp_callY + 90 + tmp_index * 24, x + xSet + 220 - tmp_xO + 400, tmp_callY + 90 + tmp_index * 20 + 20))
					{
						tmp_hit = i;
						v_lastHitSpell = i;
					}

					tmp_index++;
				}
				
				if (tmp_hit != -1) {v_detailAlpha = lerp(v_detailAlpha, 1, 0.1);}
				else {v_detailAlpha = lerp(v_detailAlpha, 0, 0.1);}
				
				if (v_detailAlpha > 0.05)
				{
					clr(c_black, min(v_formAlpha, v_detailAlpha, tmp_alpha));
					draw_text_colored(x + xSet + 220 - 20 + 20 * v_detailAlpha, tmp_callY + 60 + 170, string(oHUD.v_playerSpellUpgrade[g_spellList[| v_spellSelected], v_lastHitSpell + 5]), 300, fntPixelLess, c_black);						
	
				}
				
			}
			
			clr(-1, tmp_alpha);		
			for (var i = 0; i < 10; i++)
			{			
				clr(-1, tmp_alpha / 2);	
				draw_roundrect_ext(x + xSet + 8, y + i * 32 + tmp_yoffset + 32, x + 196 + xSet, y + 26 + i * 32 + tmp_yoffset + 32, 2, 2, false);	
				clr(-1, tmp_alpha);	
				draw_roundrect_ext(x + xSet + 8, y + i * 32 + tmp_yoffset + 32, x + 196 + xSet, y + 26 + i * 32 + tmp_yoffset + 32, 2, 2, true);			
				draw_roundrect_ext(x + xSet + 8, y + i * 32 + tmp_yoffset + 32, x + 40 + xSet, y + 26 + i * 32 + tmp_yoffset + 32, 2, 2, true);			
				
				var tmp_name;
				if (ds_list_size(g_spellList) > i)
				{
					tmp_name = oHUD.v_playerSpell[g_spellList[| i], 0];
				}
				else {tmp_name = "???";}
				
				draw_text_colored(x + xSet + 44, y + i * 32 + tmp_yoffset + 36, tmp_name, -1, fntPixelLess, c_white);
				clr(-1, tmp_alpha / 2);		
				
				if (tmp_name != "???")
				{
					clr(-1, tmp_alpha);	
					draw_sprite_stretched(sSpells, oHUD.v_playerSpell[g_spellList[| i], 1], x + xSet + 8, y + i * 32 + tmp_yoffset + 33, 33, 26); 	
				}
				
				if (point_in_rectangle(mouse_x, mouse_y, x + xSet + 8 + 32, y + i * 32 + tmp_yoffset + 32, x + 196 + xSet, y + 26 + i * 32 + tmp_yoffset + 32))
				{
					if (tmp_name != "???")
					{
						if (mouse_check_button_pressed(mb_left))
						{
							v_indexSelected = i;
							v_spellSelected = i;
						}
					}			
				}
				
				// Spell select
				if (point_in_rectangle(mouse_x, mouse_y, x + xSet + 8, y + i * 32 + tmp_yoffset + 32, x + 8 + 32 + xSet, y + 26 + i * 32 + tmp_yoffset + 32))
				{
					if (mouse_check_button_pressed(mb_left))
					{
						v_spellSelection = i;	
						oHUD.tmp_selW = 34;
						oHUD.tmp_selH = 26;
						oHUD.tmp_selWT = 40;
						oHUD.tmp_selHT = 40;
						
					}
				}
			}
		}
		#endregion
		#region Talents
		if (v_lastSelectedIndex == 2)
		{
			clr(-1, tmp_alpha);				
			draw_sprite_part(oInventory.v_inventorySprite, 0, 117, 144, 16, 16, x + 156 + xSet, y + 20);
			draw_sprite_part(oInventory.v_inventorySprite, 0, 133, 144, 16, 16, x + 450 + xSet, y + 20);

			// Render branches head
			var tmp_w;
			tmp_w = ((v_layoutW) / 3);
			
			for (var i = 0; i < 3; i++)
			{
				alg("center");
				draw_text(x + xSet + (tmp_w * (i + 1)) - tmp_w / 2, y + 60, oHUD.v_playerTalentBranch[i]);
				alg();
				
				draw_line(x + xSet + tmp_w * (i), y, x + xSet + tmp_w * (i), y + 200);
				draw_text(x + xSet + tmp_w * (i), y + 200, string(x + xSet + tmp_w * (i)));
			}
		}
		#endregion
	}
	
	for (var i = 0; i < mcInventoryProperties; i++)
	{
		v_propertyTemp[i] = 0;	
	}
}

clr();
}

#region HUD Logic posthandler		
if (mouse_check_button_released(mb_left))
{				
	if (v_hotslot != -1)
	{
		if (v_originalSlot != -1 && oHUD.v_hotbar[v_hotslot, 0] != -1)
		{												
			oHUD.v_hotbar[v_originalSlot, 0] = oHUD.v_hotbar[v_hotslot, 0];
			oHUD.v_hotbar[v_originalSlot, 1] = oHUD.v_hotbar[v_hotslot, 1];
						
			oHUD.v_hotbar[v_hotslot, 0] = tmp_index1;
			oHUD.v_hotbar[v_hotslot, 1] = tmp_index2;	
						
			oHUD.v_hotbar[v_hotslot, 2] = 0;
			oHUD.v_hotbar[v_originalSlot, 2] = 0;
		}
		else
		{
			oHUD.v_hotbar[v_hotslot, 0] = 0;
			oHUD.v_hotbar[v_hotslot, 1] = g_spellList[| v_spellSelection];	
			if (v_originalSlot != -1) {oHUD.v_hotbar[v_originalSlot, 0] = -1;}
			oHUD.v_hotbar[v_hotslot, 2] = 0;						
		}					
	}
				
	v_indexSelected = -1;	
	v_originalSlot = -1;
	v_spellSelection = -1;
}
			
if (mouse_check_button_released(mb_left))
{
	for (var i = 0; i < 10; i++)
	{
		oHUD.v_hotbar[i, 2] = 0;			
	}
}
#endregion
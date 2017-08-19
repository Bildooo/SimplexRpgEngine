
var tmp_alpha;
tmp_alpha = min(v_formAlpha, v_formExtAlpha);

alg("center")
fnt(fntPixelBig);
clr(-1, tmp_alpha);
draw_text(v_formBaseMaxX + (v_slotOffsetX * v_slotsPerRow) / 2 + (v_slotSize * 4.5) + v_formExtAlpha * (v_slotSize / 2), v_drawStartY + 16, __("Crafting"));
fnt();
alg();

// Draw selection menu
for (var i = 0; i < array_height_2d(v_craftingForms); i++)
{
	for (var j = 0; j < 6; j++)
	{
		var tmp_textureX, tmp_textureY;
			
		if (v_craftingForms[i, 4])
		{
			tmp_textureX = 633;
			tmp_textureY = 24;
				
			if (j == 0) {tmp_textureX = 633;}
			else if (j == 5) {tmp_textureX = 716;}
			else {tmp_textureX = 675;}
		}
		else
		{
			tmp_textureY = 426;
			tmp_textureX = 550;
				
			if (j == 0) {tmp_textureX = 550;}
			else if (j == 5) {tmp_textureX = 633;}
			else {tmp_textureX = 592;}
		}
			
		if (tmp_alpha > 0.02) {draw_sprite_part_ext(v_inventorySprite, 0, tmp_textureX, tmp_textureY, 40, 28, v_formBaseMaxX + v_slotSize + (j * 40) + v_formExtAlpha * (v_slotSize / 2), v_drawStartY + 48 + (30 * i) - v_craftingForms[i, 3], 1, 1, c_white, min(tmp_alpha, v_craftingForms[i, 2]));}
	}
		
	var tmp_fadeAlpha;
	tmp_fadeAlpha = 1;
		
	if (!v_craftingForms[i, 4]) 
	{
		tmp_fadeAlpha = 0.3;
		draw_sprite_part_ext(v_inventorySprite, 0, 552, 457, 13, 17, v_formBaseMaxX + v_slotSize + (3 * 40) + v_formExtAlpha * (v_slotSize / 2), v_drawStartY + 52 + (30 * i) - v_craftingForms[i, 3], 1, 1, c_white, min(tmp_alpha, v_craftingForms[i, 2]));		
	}
		
	alg("center");
	clr(-1, min(tmp_alpha, v_craftingForms[i, 2], tmp_fadeAlpha));
	if (tmp_alpha > 0.02) {draw_text(v_formBaseMaxX + v_slotSize + v_formExtAlpha * (v_slotSize / 2) + 40 * 3 + v_craftingForms[i, 1], v_drawStartY + 60 + (30 * i) - v_craftingForms[i, 3], v_craftingForms[i, 0]);}
	clr();
	alg();
		
	if (point_in_rectangle(mouse_x, mouse_y, v_formBaseMaxX + v_slotSize + v_formExtAlpha * (v_slotSize / 2), v_drawStartY + 48 + (30 * i) - v_craftingForms[i, 3], v_formBaseMaxX + v_slotSize + v_formExtAlpha * (v_slotSize / 2) + 6 * 40, v_drawStartY + 48 + (30 * i) + 24 - v_craftingForms[i, 3]) && v_craftingForms[i, 4])
	{
		if (v_selectedForm != i && v_craftingForms[i, 2] >= 0.98 && v_subformAlpha <= 0.05) {v_craftingForms[i, 1] = min(lerp(v_craftingForms[i, 1], 18, 0.1), 16);} 
		else {v_craftingForms[i, 1] = max(lerp(v_craftingForms[i, 1], -2, 0.1), 0);}
			
		if (mouse_check_button_pressed(mb_left))
		{
			if (v_selectedForm == -1) {v_selectedForm = i; v_selectedLastForm = v_selectedForm;}
			else {if (i == v_selectedForm) {v_selectedForm = -1;}}
		}
	}
	else {v_craftingForms[i, 1] = max(lerp(v_craftingForms[i, 1], -2, 0.1), 0);}
		
	if (v_selectedForm != -1)
	{
		if (v_selectedForm != i && v_subformAlpha <= 0.05)
		{
			v_craftingForms[i, 2] = max(lerp(v_craftingForms[i, 2], -0.2, 0.1), 0);
			v_craftingForms[i, 3] = lerp(v_craftingForms[i, 3], 0, 0.1);
		}
		else if (v_selectedForm == i && v_subformAlpha <= 0.05)
		{
			v_craftingForms[i, 3] = min(lerp(v_craftingForms[i, 3], 30 * (i + 0.5) + 2, 0.1), 30 * (i + 0.5));
		}
	}
	else if (v_subformAlpha <= 0.05)
	{
		v_craftingForms[i, 3] = lerp(v_craftingForms[i, 3], 0, 0.1);
		if (v_craftingForms[i, 3] < 1) {v_craftingForms[i, 2] = min(lerp(v_craftingForms[i, 2], 1.2, 0.1), 1);}
	}
}

// Draw selected subform
if (v_selectedForm != -1 && v_craftingForms[v_selectedForm, 3] >= 30 * (v_selectedForm + 0.5)) {v_subformAlpha = lerp(v_subformAlpha, 1, 0.1);}
else {v_subformAlpha = lerp(v_subformAlpha, 0, 0.1);}

// Item crafting

if (v_selectedLastForm == 0 && v_subformAlpha > 0.05)
{
	var tmp_drawX, tmp_drawY, tmp_sx, tmp_sy, tmp_slotsRenderedNow, tmp_currentRow, tmp_offsetHelp;
	tmp_drawX = v_formBaseMaxX + v_slotSize + v_subformAlpha * (v_slotSize / 2) + 8;
	tmp_drawY = v_drawStartY + 108;
	tmp_sx = tmp_drawX;
	tmp_sy = tmp_drawY;
	tmp_slotsRenderedNow = 0;
	tmp_currentRow = 0;
	tmp_offsetHelp = oHUD.v_hudSlotX;
	
	clr(-1, min(v_subformAlpha, tmp_alpha));
	for (var i = 0; i < 24; i++)
	{
		if (tmp_currentRow == 0)
		{
			if (tmp_slotsRenderedNow == 0)
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp, oHUD.v_hudSlotY, 38, 38, tmp_drawX, tmp_drawY);
			}
			else if (tmp_slotsRenderedNow == 6 - 1)
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp + 76, oHUD.v_hudSlotY, 38, 38, tmp_drawX, tmp_drawY);		
			}
			else
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp + 38, oHUD.v_hudSlotY, 38, 38, tmp_drawX, tmp_drawY);
			}
		}
		else if (tmp_currentRow == 3)
		{
			if (tmp_slotsRenderedNow == 0)
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp, oHUD.v_hudSlotY + 76, 38, 38, tmp_drawX, tmp_drawY);
			}
			else if (tmp_slotsRenderedNow == 6 - 1)
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp + 76, oHUD.v_hudSlotY + 76, 38, 38, tmp_drawX, tmp_drawY);		
			}
			else
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp + 38, oHUD.v_hudSlotY + 76, 38, 38, tmp_drawX, tmp_drawY);
			}
		}
		else
		{
			if (tmp_slotsRenderedNow == 0)
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp, oHUD.v_hudSlotY + 38, 38, 38, tmp_drawX, tmp_drawY);
			}
			else if (tmp_slotsRenderedNow == 6 - 1)
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp + 76, oHUD.v_hudSlotY + 38, 38, 38, tmp_drawX, tmp_drawY);		
			}
			else
			{
				draw_sprite_part(v_inventorySprite, 0, tmp_offsetHelp + 38, oHUD.v_hudSlotY + 38, 38, 38, tmp_drawX, tmp_drawY);
			}
		}
		
		tmp_slotsRenderedNow++;
		if (tmp_slotsRenderedNow >= 6)
		{		
			tmp_drawX = tmp_sx;
			tmp_drawY += (v_slotSize + 6);
			tmp_slotsRenderedNow = 0;
			tmp_currentRow++;
		}
		else
		{
			tmp_drawX += (v_slotSize + 6);
		}	
	}
	
	// Draw fulltext search
	if (!surface_exists(v_searchSurface)) {v_searchSurface = surface_create(400, 32);}
	if (v_carretTimer > 0) {v_carretTimer--;} else {v_carretTimer = 60; v_carret = !v_carret;}
	
	var tmp_carret;
	tmp_carret = "";
	
	if (v_carret) {tmp_carret = "|";}
	
	clr(-1, min(v_subformAlpha / 2, tmp_alpha));	
	draw_rectangle(tmp_sx, tmp_sy - 26, tmp_sx + 230, tmp_sy - 4, false);
	
	if (point_in_rectangle(mouse_x, mouse_y, tmp_sx, tmp_sy - 26, tmp_sx + 230, tmp_sy - 4))
	{
		if (mouse_check_button_pressed(mb_left))
		{
			v_searchActive = !v_searchActive;
			if (v_searchActive) {keyboard_string = v_searchText;}
		}
	}
	
	clr(c_white, min(v_subformAlpha, tmp_alpha));
	alg("center");
	fnt(fntPixelSmall);
	if (string_width(v_searchText) >= 225) {fnt(fntPixelTiny);}
	
	surface_set_target(v_searchSurface);
	draw_clear_alpha(c_white, 0);
	draw_text(200, 16, v_searchText);
	alg();
	if (v_carret && v_searchActive) {draw_text(200 + string_width(v_searchText) / 2, 8, "|");}
	surface_reset_target();
	
	draw_surface_part(v_searchSurface, v_searchSurfaceX - 115, 0, 235, 32, tmp_sx, tmp_sy - 32);
	
	v_searchSurfaceX = lerp(v_searchSurfaceX, v_searchSurfaceTarX, 0.1);
	
	if (v_searchActive)
	{
		oHUD.v_keyboardClickedUI = true;
		if (keyboard_check(vk_anykey)) 
		{
			v_carretTimer = 60;
			v_carret = true;
		
			if (string_length(keyboard_string) < 48 || keyboard_lastkey == vk_backspace)
			{
				v_searchText = keyboard_string; 
				if (string_width(v_searchText) >= 210) {v_searchSurfaceTarX = 200 - 115 + (string_width(keyboard_string) / 2);}
			}
			else {keyboard_string = v_searchText;}
		}
	}
}
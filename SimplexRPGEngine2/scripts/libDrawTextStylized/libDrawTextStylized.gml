/// @function libDrawTextStylized(x, y, text, alpha, centered, roundedCorners)
/// @desc Draws target text using colored formating with shadow
/// @arg {int} x X
/// @arg {int} y Y
/// @arg {string} text Text to draw
/// @arg {int} alpha Draw alpha
/// @arg {bool} centered Wheather to center text
/// @arg {bool} roundedCorners Wheather to round corners

var tmp_text, tmp_x, tmp_y, tmp_textClean, tmp_alpha, tmp_center, tmp_xo, tmp_yo, tmp_xo2, tmp_yo2, tmp_rc;
tmp_text = "";
tmp_x = x;
tmp_y = y;
tmp_alpha = 1;
tmp_center = true;
tmp_xo = 0;
tmp_yo = 0;
tmp_xo2 = 0;
tmp_yo2 = 0;
tmp_rc = 20;

if (argument_count > 0) {tmp_x = argument[0];}
if (argument_count > 1) {tmp_y = argument[1];}
if (argument_count > 2) {tmp_text = argument[2];}
if (argument_count > 3) {tmp_alpha = argument[3];}
if (argument_count > 4) {tmp_center = argument[4];}
if (argument_count > 5) {tmp_rc = argument[5];}

clr();
fnt(fntPixel);
tmp_textClean = libUtilityParseTextColored(tmp_text, fntPixel);

if (tmp_center) {tmp_xo = string_width(tmp_textClean) / 2; tmp_yo = string_height(tmp_textClean) / 2;}
else {tmp_xo2 = string_width(tmp_textClean); tmp_yo2 = string_height(tmp_textClean);}

clr(-1, tmp_alpha / 2);
draw_roundrect_ext(tmp_x - tmp_xo - 8, tmp_y - tmp_yo, tmp_x + tmp_xo + 8 + tmp_xo2, tmp_y + tmp_yo + 4 + tmp_yo2, tmp_rc, tmp_rc, false);

clr(-1, tmp_alpha);
draw_text_colored(tmp_x - tmp_xo, tmp_y - tmp_yo + 3, tmp_text, -1, fntPixel);
clr();
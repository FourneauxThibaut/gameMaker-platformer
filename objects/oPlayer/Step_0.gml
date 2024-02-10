#region Player Input
key_left = keyboard_check(ord("Q"))
key_right = keyboard_check(ord("D"))
key_jump = keyboard_check_pressed(vk_space)
key_jump_held = keyboard_check(vk_space)
#endregion

#region Player Movement
// -1 is left, 0 is nothing, 1 is right
var dir = key_right - key_left;
hsp += dir*accel;

if (dir == 0) 
{
	if (hsp < 0) 
	{
		hsp = min(hsp + decel, 0);
	}
	else
	{
		hsp = max(hsp - decel, 0);
	}
}

hsp = clamp(hsp, -max_hsp, max_hsp);

vsp += grav;

//ground jump
if (jumpbuffer > 0 )
{
	jumpbuffer--
	if (key_jump) 
	{
		jumpbuffer = 0
		vsp = jumpspeed;
	}
}

if (vsp < 0) && (!key_jump_held)
{
	vsp = max(vsp, -3)	
}

vsp = clamp(vsp, -max_vsp, max_vsp);
#endregion

#region Collision

//horizontal collision
if (place_meeting(x + hsp, y, oBlock))
{
	var onepixel = sign(hsp);
	while (!place_meeting(x + hsp, y, oBlock)) x += onepixel;
	hsp = 0;
}

x += hsp;

//vertical collision
if (place_meeting(x, y + vsp, oBlock))
{
	var onepixel = sign(vsp);
	while (!place_meeting(x, y + onepixel, oBlock)) y += onepixel;
	vsp = 0;
}

y += vsp;
#endregion

#region Status

onground = place_meeting(x, y + groundbuffer, oBlock);
if (onground) jumpbuffer = 10;

#endregion

#region Animation

//adjust sprite
image_speed = 1

if (hsp != 0) image_xscale = sign(hsp);

if (! onground)
 { 
	 if (vsp > 0) 
	 {
		sprite_index = sPlayerFall;
	 }
	 else
	 {
		sprite_index = sPlayerJump;
	 }
 }
 else 
 {
	 if (hsp != 0)
	 {
		 sprite_index = sPlayerRun;
	 }
	 else 
	 {
		 sprite_index = sPlayer;
	 }
 }
#endregion

#region dev
if (keyboard_check_pressed(vk_enter)) game_restart();
#endregion
shader_type canvas_item;
uniform vec3 replacement_color:source_color;
void fragment() {
	vec3 color_without_green = COLOR.rgb * vec3(1,0,1); //take green away of each pixel
	float amount_of_rb = length(color_without_green); //take how much of rb is in each pixel
	float rb_mask = step(0.5,amount_of_rb); //if amount of rb met, fixates to white, hence a mask of black (green) white (rb)
	vec3 retained_color = COLOR.rgb * rb_mask; //for each pixel apply the mask (green will be black = 0)
	float g_mask = 1.0 - rb_mask; //now its the opposite, mask of black (rb) and white (green)
	float masked_to_green = g_mask * COLOR.g; //now by applying the mask to the green channel holds all values with green (remember white is 1).
	//by multiplying we get the "shade" for each pixel that has green on it with the color of replacement
	vec3 masked_replacement_color = replacement_color * masked_to_green;
	//and now by adding that shade to the retained (remember that in retained black is 0) we get our final result of the masks
	vec3 final_color =retained_color + masked_replacement_color;
	COLOR.rgb = final_color;
}

//Made with spider LLM
shader_type canvas_item;

// Získáme obraz pod naším UI
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Původní přepínač pro inverzi zrcadla
uniform bool is_inverted = false;

// NOVÉ: Posuvník od 0.0 (vypnuto) do např. 0.05 (silné motání)
uniform float dizziness_intensity : hint_range(0.0, 0.1) = 0.0; 

// NOVÉ: Rychlost motání (jak rychle se vlní obraz)
uniform float time_speed = 2.0;

void fragment() {
    vec2 suv = SCREEN_UV;
    
    // 1. Zrcadlení (Inverze osy X)
    if (is_inverted) {
        suv.x = 1.0 - suv.x; 
    }
    
    // 2. Vlnění / Motání hlavy
    // Využijeme built-in proměnnou TIME.
    // Osu X vlníme na základě pozice Y a času. Osu Y vlníme na základě X a času.
    float wave_x = sin(TIME * time_speed + suv.y * 10.0) * dizziness_intensity;
    float wave_y = cos(TIME * time_speed + suv.x * 10.0) * dizziness_intensity;
    
    // Přičteme vlnění k aktuálním souřadnicím
    suv += vec2(wave_x, wave_y);
    
    // 3. Vykreslíme výsledný zkroucený pixel
    COLOR = texture(screen_texture, suv);
}
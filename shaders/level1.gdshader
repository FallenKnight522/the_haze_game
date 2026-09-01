//Made by spider.llm
shader_type canvas_item;

// Snímá aktuální výstup enginu (co hráč vidí)
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Posuvník strachu (0.0 = klid, 1.0 = maximální strach)
uniform float fear_intensity : hint_range(0.0, 1.0) = 0.0;

// Rychlost, jakou se barvy střídají
uniform float shift_speed = 0.5;

// Pomocná funkce enginu pro převod RGB (Červená-Zelená-Modrá) na HSV (Odstín-Sytost-Jas)
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// Pomocná funkce pro převod HSV zpět na viditelné RGB
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
    // 1. Získáme původní barvu z obrazovky
    vec4 original_color = texture(screen_texture, SCREEN_UV);
    
    // 2. Převedeme ji na HSV profil, abychom mohli manipulovat jen s čistým odstínem
    vec3 hsv = rgb2hsv(original_color.rgb);
    
    // 3. Rotujeme odstín (hsv.x) pomocí zabudované proměnné TIME.
    // Tím přirozeně projíždíme celé spektrum (žlutá, oranžová, červená, fialová...).
    hsv.x += TIME * shift_speed;
    hsv.x = fract(hsv.x); // Udrží hodnotu odstínu v rozmezí 0.0 až 1.0
    
    // 4. Převedeme zrotovanou barvu zpět
    vec3 shifted_color = hsv2rgb(hsv);
    
    // 5. Smícháme (mix) původní a narušenou barvu. 
    // Pokud je fear_intensity 0, vidíme jen původní hru. 
    // Násobič 0.4 na konci určuje, jak moc se obraz celkově zabarví při MAXIMÁLNÍM strachu (aby to nebylo rušivé, ale jen lehce zvrácené).
    COLOR.rgb = mix(original_color.rgb, shifted_color, fear_intensity * 0.4);
    COLOR.a = original_color.a;
}
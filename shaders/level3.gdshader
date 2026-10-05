shader_type canvas_item;
// made by Spider.LLM
// --- UI Parametry viditelné v Inspectoru ---
uniform float strachomira : hint_range(0.0, 1.0) = 0.0; // Aktuální stav Strachomíry

// Barvy mlhy (řidší vs. hustší)
uniform vec4 fog_color_thin : source_color = vec4(0.9, 0.95, 1.0, 1.0); // Světlá, ledově bílá (řídká mlha)
uniform vec4 fog_color_dense : source_color = vec4(0.2, 0.3, 0.5, 1.0); // Tmavší, chladná modrá (hustá mlha)

uniform float fog_speed = 0.2; // Rychlost převalování mlhy
uniform float edge_creep = 0.5; // Jak moc se mlha drží okrajů při nízkém strachu

// Generátor náhodných hodnot (Noise)
vec2 random(vec2 uv) {
    uv = vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}

// Perlinův šum
float noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(dot(random(i + vec2(0.0,0.0)), f - vec2(0.0,0.0)),
                   dot(random(i + vec2(1.0,0.0)), f - vec2(1.0,0.0)), u.x),
               mix(dot(random(i + vec2(0.0,1.0)), f - vec2(0.0,1.0)),
                   dot(random(i + vec2(1.0,1.0)), f - vec2(1.0,1.0)), u.x), u.y);
}

// Fraktální šum pro realistickou, vrstvenou mlhu
float fbm(vec2 uv) {
    float f = 0.0;
    mat2 m = mat2(vec2(1.6,  1.2), vec2(-1.2,  1.6));
    f += 0.5000 * noise(uv); uv = m * uv;
    f += 0.2500 * noise(uv); uv = m * uv;
    f += 0.1250 * noise(uv); uv = m * uv;
    f += 0.0625 * noise(uv); uv = m * uv;
    return f + 0.5;
}

void fragment() {
    // Posouvání mlhy v čase
    vec2 uv = UV * 3.0; // Měřítko (hustota cárů mlhy)
    vec2 movement = vec2(TIME * fog_speed, TIME * (fog_speed * 0.5));
    
    // Výpočet samotné textury mlhy (hodnota od 0.0 do 1.0)
    float noise_val = fbm(uv + movement + fbm(uv - movement));
    
    // Vinětace (ztmavení/zamlžení okrajů). Střed je na souřadnici 0.5, 0.5.
    float dist_from_center = distance(UV, vec2(0.5, 0.5));
    
    // Čím vyšší Strachomíra, tím víc mlha pohlcuje celý střed
    float fog_mask = smoothstep(1.0 - strachomira, (1.0 - strachomira) - edge_creep, dist_from_center);
    
    // Finální intenzita mlhy v daném pixelu (kombinace šumu, masky a strachu)
    float fog_intensity = noise_val * max(fog_mask, strachomira);
    
    // Oříznutí průhlednosti, aby mlha nebyla nikdy absolutně neprůhledná
    float alpha = clamp(fog_intensity, 0.0, 0.95);
    
    // MÍCHÁNÍ BAREV (Klíčová změna)
    // Funkce mix() plynule přechází mezi fog_color_thin a fog_color_dense
    // na základě toho, jak "hustý" (noise_val) je daný pixel mlhy.
    // smoothstep(0.3, 0.7, noise_val) zajistí, že přechod mezi bílou a modrou bude hezky měkký.
    vec4 final_color = mix(fog_color_thin, fog_color_dense, smoothstep(0.3, 0.7, noise_val));
    
    // Vykreslení pixelu (barva + celková průhlednost vynásobená Strachomírou)
    COLOR = vec4(final_color.rgb, alpha * strachomira);
}
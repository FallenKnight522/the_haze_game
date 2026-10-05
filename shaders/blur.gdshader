shader_type canvas_item;
//Made by spider.LLM
// Parametr pro AnimationPlayer (0.0 je ostrý obraz, 5.0 a více je totální šmouha)
uniform float blur_amount : hint_range(0.0, 10.0) = 0.0; 

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Pokud je rozostření vypnuté, šetříme výkon a vykreslíme čistý obraz
    if (blur_amount <= 0.01) {
        COLOR = texture(screen_texture, SCREEN_UV);
    } else {
        vec4 color = vec4(0.0);
        
        // Zjistíme, jakou úroveň detailu (LOD) použijeme. Zastropujeme to na hodnotě 4.0, 
        // aby obraz nezačal kostičkovat.
        float lod = min(blur_amount, 4.0);
        
        // Vypočítáme, jak moc se mají pixely "rozpít" do stran (Smudge efekt)
        float spread = blur_amount * 0.005; 
        
        // Vzorkujeme obrazovku na 9 různých místech kolem aktuálního pixelu
        // a výsledky sečteme. Tím vznikne efekt těžké šmouhy.
        color += textureLod(screen_texture, SCREEN_UV + vec2(-spread, -spread), lod);
        color += textureLod(screen_texture, SCREEN_UV + vec2(0.0, -spread), lod);
        color += textureLod(screen_texture, SCREEN_UV + vec2(spread, -spread), lod);
        
        color += textureLod(screen_texture, SCREEN_UV + vec2(-spread, 0.0), lod);
        color += textureLod(screen_texture, SCREEN_UV, lod) * 2.0; // Střed má mírně vyšší váhu
        color += textureLod(screen_texture, SCREEN_UV + vec2(spread, 0.0), lod);
        
        color += textureLod(screen_texture, SCREEN_UV + vec2(-spread, spread), lod);
        color += textureLod(screen_texture, SCREEN_UV + vec2(0.0, spread), lod);
        color += textureLod(screen_texture, SCREEN_UV + vec2(spread, spread), lod);
        
        // Zprůměrujeme 10 vzorků (9 + 1 za dvojitou váhu středu)
        COLOR = color / 10.0;
    }
}
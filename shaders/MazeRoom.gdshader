//Made with spider LLM
shader_type canvas_item;

// Vezmeme "fotku" aktuální obrazovky
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Posuvník určující sílu rozostření (0.0 = normální obraz, vyšší číslo = silný rozklad)
uniform float aberration_amount : hint_range(0.0, 0.1) = 0.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // Získáme posun z našeho parametru
    float shift = aberration_amount;
    
    // Přečteme pixely pod UI, ale pro každou barvu se podíváme kousek jinam:
    // Červená barva (r) se posune doprava (uv.x + shift)
    float r = texture(screen_texture, vec2(uv.x + shift, uv.y)).r;
    
    // Zelená barva (g) se posune doleva (uv.x - shift)
    float g = texture(screen_texture, vec2(uv.x - shift, uv.y)).g;
    
    // Modrá barva (b) se posune dolů (uv.y - shift)
    float b = texture(screen_texture, vec2(uv.x, uv.y - shift)).b;
    
    // Složíme barvy zpět do jednoho výsledného pixelu (1.0 na konci je plná neprůhlednost/Alpha)
    COLOR = vec4(r, g, b, 1.0);
}
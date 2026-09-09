shader_type canvas_item;
//made by spider LLm
// --- PARAMETRY (Objeví se v Inspectoru) ---
uniform sampler2D eye_texture : filter_nearest; // Tvá textura oka (Sprite Sheet)
uniform int h_frames = 9; // Počet snímků animace vedle sebe na obrázku
uniform vec2 grid_size = vec2(16.0, 9.0); // Mřížka (doporučuji poměr stran monitoru)
uniform float edge_margin : hint_range(0.0, 0.5) = 0.15; // Jak široká je periferie
uniform float fear_level : hint_range(0.0, 1.0) = 0.0; // Kolik očí se má objevit
uniform float animation_speed = 6.0; // Rychlost mrkání

// Generátor náhodných čísel pro každou buňku mřížky
float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
    // 1. Zjistíme, ve které buňce mřížky pixel leží
    vec2 cell = floor(UV * grid_size);
    vec2 cell_uv = fract(UV * grid_size); // UV souřadnice uvnitř samotné buňky

    // 2. Výpočet vzdálenosti buňky od středu obrazovky (0.5, 0.5)
    vec2 cell_center = (cell + vec2(0.5)) / grid_size;
    float dist_x = abs(cell_center.x - 0.5);
    float dist_y = abs(cell_center.y - 0.5);

    // 3. Je tato buňka na okraji obrazovky?
    bool is_edge = (dist_x > (0.5 - edge_margin)) || (dist_y > (0.5 - edge_margin));

    if (!is_edge) {
        COLOR = vec4(0.0); // Uprostřed obrazovky je čisto a průhledno
    } else {
        // Vygenerujeme fixní náhodné číslo pro tuto buňku
        float rand_val = random(cell);

        // Pokud je strach příliš malý, oko zde zůstane skryté
        if (rand_val > fear_level) {
            COLOR = vec4(0.0);
        } else {
            // 4. Animace: Vypočítáme aktuální snímek podle času a náhodného offsetu
            // (rand_val * 10.0 zajistí, že všechna oči neblikají přesně nastejno)
            float current_frame = floor(mod(TIME * animation_speed + rand_val * 10.0, float(h_frames)));

            // Úprava UV souřadnic tak, aby četly jen aktuální snímek ze Sprite Sheetu
            vec2 sprite_uv = cell_uv;
            sprite_uv.x = (sprite_uv.x + current_frame) / float(h_frames);

            // Vykreslení pixelu oka
            vec4 tex_color = texture(eye_texture, sprite_uv);
            
            // Zachováme průhlednost samotného obrázku oka
            COLOR = tex_color;
        }
    }
}
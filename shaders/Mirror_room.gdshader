//Made by Spider LLM
shader_type canvas_item;

// Intenzita strachu (0.0 = normální odraz, 1.0 = maximální šílenství Spirály)
uniform float fear_intensity : hint_range(0.0, 1.0) = 0.0;

// Síla zakřivení (Jak moc se končetiny a prostor stočí do spirály)
uniform float twist_strength = 4.0;

void fragment() {
    // Vezmeme standardní souřadnice textury zrcadla (od 0.0 do 1.0)
    vec2 uv = UV;
    
    // 1. Přesuneme střed souřadnic do geometrického středu zrcadla
    vec2 centered_uv = uv - vec2(0.5);
    
    // 2. Převedeme na polární souřadnice (úhel a vzdálenost od středu)
    float dist = length(centered_uv);
    float angle = atan(centered_uv.y, centered_uv.x);
    
    // 3. Efekt Spirály: Čím dále od středu pixel je, tím více se jeho úhel stočí.
    // Násobíme to Strachomírou, takže při strachu 0 se nestane vůbec nic.
    float twist_amount = dist * twist_strength * fear_intensity;
    angle += twist_amount;
    
    // 4. Převedeme zkroucený úhel zpět na standardní X/Y souřadnice
    vec2 twisted_uv = vec2(cos(angle), sin(angle)) * dist;
    
    // Přesuneme střed zpět do levého horního rohu
    twisted_uv += vec2(0.5);
    
    // 5. Vykreslíme zrcadlo. 
    // Používáme zabudovanou proměnnou TEXTURE, která obsahuje tvůj SubViewport odraz.
    COLOR = texture(TEXTURE, twisted_uv);
}
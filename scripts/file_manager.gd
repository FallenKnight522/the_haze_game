extends Node2D
@onready var text_window: CanvasLayer = %Text_window
 

##Made by Spider.LLM
func extrah_zip(jmeno_souboru) -> void:
	# 1. Zjištění bezpečné systémové cesty do složky "Stažené" v OS hráče
	var slozka_stazene = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
	var cilova_cesta = slozka_stazene + "/" + jmeno_souboru
	
	# 2. Otevření virtuálního ZIPu uvnitř zabalené hry (read mode)
	var zdrojovy_soubor = FileAccess.open("res://Data/" + jmeno_souboru, FileAccess.READ)
	
	if zdrojovy_soubor == null:
		push_error("Zdrojový soubor ve hře neexistuje!")
		return
		
	# 3. Načtení všech syrových dat (bajtů) do bezpečné paměti RAM
	var binarni_data = zdrojovy_soubor.get_buffer(zdrojovy_soubor.get_length())
	zdrojovy_soubor.close()
	
	# 4. Vytvoření nového souboru na fyzickém disku hráče (write mode)
	var cilovy_soubor = FileAccess.open(cilova_cesta, FileAccess.WRITE)
	
	if cilovy_soubor == null:
		# Zde může dojít k zablokování antivirem
		text_window.force_text("((Pokud to nejde spravit, napište autorovy hry))")
		text_window.force_text("Might be due to antivirus")
		text_window.force_text("Cannot access your Downloads file")
		return
		
	# 5. Okamžitý zápis celého bloku dat
	cilovy_soubor.store_buffer(binarni_data)
	cilovy_soubor.close()
	text_window.force_text("the_haze: File " + jmeno_souboru +" downloaded succesfully")
	


# Variables correspondientes a los directorios del proyecto
DATA_DIR = data
OUTPUT_DIR = output
SRC_DIR = src

# El $@ captura el objetivo (en este caso el número)
%:
	$(MAKE) run CONGRESS_NUMBER=$@

# Ejecutar el trabajo completo
# Run the whole project
# Validar que el número de congreso esté presente
run:
	@if [ -z "$(CONGRESS_NUMBER)" ]; then \
		echo "Error: Congress number is required. Usage: make <congress_number>"; \
		exit 1; \
	else \
		echo "Usando número de congreso: $(CONGRESS_NUMBER)"; \
		bash $(SRC_DIR)/main.sh $(CONGRESS_NUMBER); \
	fi

clean:
	rm -f $(DATA_DIR)/congress_info.xml
	rm -f $(DATA_DIR)/congress_members_info.xml
	rm -f $(DATA_DIR)/congress_data.xml
	rm -f $(OUTPUT_DIR)/congress_page.html

setup:
	mkdir -p $(DATA_DIR) $(OUTPUT_DIR)

all: setup clean run


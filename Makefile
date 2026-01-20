DOC_DIR = docs
BUILD_DIR = build
INDEX = $(DOC_DIR)/index.adoc
DATA_DIR = data
SCRIPTS_DIR = scripts
GENERATED_DIR = $(DOC_DIR)/generated

all: requirements changelog html pdf

requirements:
	ruby $(SCRIPTS_DIR)/process_requirements.rb
	mkdir -p $(DOC_DIR)/assets
	cp -R $(DATA_DIR)/assets/* $(DOC_DIR)/assets/

check-assets:
	# validation is built-in to the processing script
	ruby $(SCRIPTS_DIR)/process_requirements.rb

changelog:
	ruby $(SCRIPTS_DIR)/generate_changelog.rb

html:
	bundle exec asciidoctor -D $(BUILD_DIR) $(INDEX)

pdf:
	bundle exec asciidoctor-pdf -D $(BUILD_DIR) -a pdf-theme=default -r ./scripts/polyfill.rb $(INDEX)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(GENERATED_DIR)

deps:
	bundle install

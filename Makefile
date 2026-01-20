DOC_DIR = docs
BUILD_DIR = build
INDEX = $(DOC_DIR)/index.adoc
DATA_DIR = data
SCRIPTS_DIR = scripts
GENERATED_DIR = $(DOC_DIR)/generated

all: requirements changelog html pdf

requirements:
	ruby $(SCRIPTS_DIR)/process_requirements.rb

changelog:
	ruby $(SCRIPTS_DIR)/generate_changelog.rb

html:
	bundle exec asciidoctor -D $(BUILD_DIR) $(INDEX)

pdf:
	bundle exec asciidoctor-pdf -D $(BUILD_DIR) -a pdf-theme=default $(INDEX)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(GENERATED_DIR)

deps:
	bundle install

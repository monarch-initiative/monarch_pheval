# This includes all the preprocessing not directly related to the PhEval Running

EXOMISER_VERSION				:=	13.1.0
PHENOTYPE_VERSION				:=	2309


.PHONY: download
download: download-exomiser download-phenotype

.PHONY: download-exomiser
download-exomiser: $(RUNNERS_DIR)/exomiser-$(EXOMISER_VERSION)

$(TMP_DATA)/exomiser-cli-$(EXOMISER_VERSION)-distribution.zip:
	mkdir -p $(TMP_DATA)
	wget https://github.com/exomiser/Exomiser/releases/download/$(EXOMISER_VERSION)/exomiser-cli-$(EXOMISER_VERSION)-distribution.zip -O $@

$(RUNNERS_DIR)/exomiser-$(EXOMISER_VERSION): $(TMP_DATA)/exomiser-cli-$(EXOMISER_VERSION)-distribution.zip
	mkdir -p $(RUNNERS_DIR)
	unzip $< -d $(RUNNERS_DIR)
	mv $(RUNNERS_DIR)/exomiser-cli-$(EXOMISER_VERSION) $(RUNNERS_DIR)/exomiser-$(EXOMISER_VERSION)
	cp $(RUNNERS_DIR)/configurations/exomiser-$(EXOMISER_VERSION).config.yaml $(RUNNERS_DIR)/exomiser-$(EXOMISER_VERSION)/config.yaml
	cp $(RUNNERS_DIR)/configurations/preset-exome-analysis.yml $(RUNNERS_DIR)/exomiser-$(EXOMISER_VERSION)/

.PHONY: download-phenotype
download-phenotype: $(PHENOTYPE_DIR)/$(PHENOTYPE_VERSION)_hg19.sha256 $(PHENOTYPE_DIR)/$(PHENOTYPE_VERSION)_hg38.sha256 $(PHENOTYPE_DIR)/$(PHENOTYPE_VERSION)_phenotype.sha256
	mkdir -p $(TMP_DATA)
	mkdir -p $(PHENOTYPE_DIR)

$(PHENOTYPE_DIR)/$(PHENOTYPE_VERSION)_%.sha256: $(TMP_DATA)/$(PHENOTYPE_VERSION)_%.zip
	unzip $< -d $(PHENOTYPE_DIR)

$(TMP_DATA)/$(PHENOTYPE_VERSION)%.zip:
	wget https://data.monarchinitiative.org/exomiser/latest/$(PHENOTYPE_VERSION)$*.zip -O $@

.PHONY: clean
clean:
	rm -rf $(RUNNERS_DIR) $(TMP_DATA)

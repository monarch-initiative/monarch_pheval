# This includes all the preprocessing not directly related to the PhEval Running

EXOMISER_VERSIONS				:=	13.2.1 13.3.0
PHENOTYPE_VERSIONS				:=	2302 2309


.PHONY: setup
setup: download-exomiser download-phenotype

.PHONY: download-exomiser
download-exomiser: $(addprefix $(RUNNERS_DIR)/exomiser-,$(EXOMISER_VERSIONS))

$(TMP_DATA)/exomiser-cli-%-distribution.zip:
	mkdir -p $(TMP_DATA)
	wget https://github.com/exomiser/Exomiser/releases/download/$*/exomiser-cli-$*-distribution.zip -O $@

$(RUNNERS_DIR)/exomiser-%: $(TMP_DATA)/exomiser-cli-%-distribution.zip
	mkdir -p $(RUNNERS_DIR)
	unzip $< -d $(RUNNERS_DIR)
	mv $(RUNNERS_DIR)/exomiser-cli-$* $(RUNNERS_DIR)/exomiser-$*
	cp $(RUNNERS_DIR)/configurations/preset-exome-analysis.yml $(RUNNERS_DIR)/exomiser-$*/

.PHONY: download-phenotype
download-phenotype: $(addprefix $(PHENOTYPE_DIR)/,$(addsuffix _hg19.sha256,$(PHENOTYPE_VERSIONS))) $(addprefix $(PHENOTYPE_DIR)/,$(addsuffix _hg38.sha256,$(PHENOTYPE_VERSIONS))) $(addprefix $(PHENOTYPE_DIR)/,$(addsuffix _phenotype.sha256,$(PHENOTYPE_VERSIONS)))

$(PHENOTYPE_DIR)/%.sha256: $(TMP_DATA)/phenogeno_%.zip
	unzip $< -d $(PHENOTYPE_DIR)

$(TMP_DATA)/phenogeno_%.zip:
	mkdir -p $(PHENOTYPE_DIR)
	mkdir -p $(TMP_DATA)
	wget https://data.monarchinitiative.org/exomiser/data/$*.zip -O $@

.PHONY: clean
clean:
	rm -rf $(RUNNERS_DIR) $(TMP_DATA)

# This includes all the preprocessing not directly related to the PhEval Running

PHENOTYPE_VERSIONS		:=	2309 2402
EXOMISER_VERSIONS		:=	13.3.0 14.0.0

.PHONY: pheval
pheval:
	$(MAKE) setup
	$(MAKE) download-phenotype
	$(MAKE) prepare-inputs
	$(MAKE) prepare-corpora
	$(MAKE) pheval-run
	#$(MAKE) pheval-report


.PHONY: setup

setup: $(ROOT_DIR)/Makefile


.PHONY: download
downloads: download-phenotype download-exomiser download-phen2gen download-gado

.PHONY: download-phenotype
download-phenotype: $(addprefix $(PHENOTYPE_DIR)/,$(addsuffix _hg19.sha256,$(PHENOTYPE_VERSIONS))) $(addprefix $(PHENOTYPE_DIR)/,$(addsuffix _hg38.sha256,$(PHENOTYPE_VERSIONS))) $(addprefix $(PHENOTYPE_DIR)/,$(addsuffix _phenotype.sha256,$(PHENOTYPE_VERSIONS)))

$(PHENOTYPE_DIR)/%.sha256: $(TMP_DATA)/phenogeno_%.zip
	unzip $< -d $(PHENOTYPE_DIR)

$(TMP_DATA)/phenogeno_%.zip:
	mkdir -p $(PHENOTYPE_DIR)
	mkdir -p $(TMP_DATA)
	wget https://data.monarchinitiative.org/exomiser/data/$*.zip -O $@

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


.PHONY: download-phen2gen
download-phen2gen: $(RUNNERS_DIR)/Phen2Gene
$(RUNNERS_DIR)/Phen2Gene:
	mkdir -p $(RUNNERS_DIR)
	cd $(RUNNERS_DIR)
	git clone https://github.com/WGLab/Phen2Gene.git $@
	yes "$@" | bash $@/setup.sh


.PHONY: download-gado
download-gado: $(RUNNERS_DIR)/gado
$(RUNNERS_DIR)/gado:
	mkdir -p $@
	wget "https://filesender.surf.nl/download.php?token=a315dd96-6ab1-414a-bb7d-f8e76551756e&files_ids=24854169" -O $@/gado.1.0.4.tar.gz
	tar -zxvf $@/gado.1.0.4.tar.gz -C $@
	wget https://molgenis26.gcc.rug.nl/downloads/genenetwork/v2.1/genenetwork_bonf_spiked.zip -O $@/genenetwork_bonf_spiked.zip
	unzip $@/genenetwork_bonf_spiked.zip -d $@
	wget https://molgenis26.gcc.rug.nl/downloads/genenetwork/v2.1/predictions_auc_bonf.txt -O $@/predictions_auc_bonf.txt
	wget https://molgenis26.gcc.rug.nl/downloads/genenetwork/v2.1/hpo_prediction_genes.txt -O $@/hpo_prediction_genes.txt
	wget https://molgenis26.gcc.rug.nl/downloads/genenetwork/v2.1/hp.obo -O $@/hp.obo

$(TMP_DATA)/all_phenopackets/all_phenopackets.zip:
	mkdir -p $(TMP_DATA)/all_phenopackets/
	wget https://github.com/monarch-initiative/phenopacket-store/releases/download/0.1.21/all_phenopackets.zip -O $@
	unzip $@ -d $(ROOT_DIR)/$(shell dirname $@)/
	mkdir -p $(TMP_DATA)/all_phenopackets/unpacked_phenopackets
	find $(TMP_DATA)/all_phenopackets/ -iname *.json ! -path "$(TMP_DATA)/all_phenopackets/unpacked_phenopackets/*" -exec mv {} $(TMP_DATA)/all_phenopackets/unpacked_phenopackets \;

.PHONY: clean
clean:
	rm -rf $(RUNNERS_DIR) $(TMP_DATA)
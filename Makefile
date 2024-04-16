MAKEFLAGS 				+= --warn-undefined-variables
SHELL 					:= bash
.DEFAULT_GOAL			:= help
URIBASE					:=	http://purl.obolibrary.org/obo
TMP_DATA				:=	data/tmp
ROOT_DIR				:=	$(shell pwd)
PHENOTYPE_DIR			:= $(ROOT_DIR)/data/phenotype
RUNNERS_DIR				:= $(ROOT_DIR)/runners
NAME					:= $(shell python -c 'import tomli; print(tomli.load(open("pyproject.toml", "rb"))["tool"]["poetry"]["name"])')
VERSION					:= $(shell python -c 'import tomli; print(tomli.load(open("pyproject.toml", "rb"))["tool"]["poetry"]["version"])')
SEMSIM_BASE_URL			:= https://storage.googleapis.com/data-public-monarchinitiative/semantic-similarity/latest
EXOMISER_VERSIONS		:=	13.3.0 14.0.0


help: info
	@echo ""
	@echo "help"
	@echo "make setup -- this runs the download and extraction of genomic, phenotypic and runners data"
	@echo "make pheval -- this runs the entire pipeline including setup, corpus preparation and pheval run"
	@echo "make help -- show this help"
	@echo ""

info:
	@echo "Project: $(NAME)"
	@echo "Version: $(VERSION)"

.PHONY: prepare-inputs


prepare-inputs: configurations/default-13.3.0/config.yaml





configurations/default-13.3.0/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_hg19  || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/







prepare-inputs: configurations/default-14.0.0/config.yaml





configurations/default-14.0.0/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	cp -rf $(PHENOTYPE_DIR)/2402_phenotype $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype
	cp $(RUNNERS_DIR)/configurations/exomiser-14.0.0-2402_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -L $(ROOT_DIR)/$(shell dirname $@)/2402_hg19  || ln -s $(PHENOTYPE_DIR)/2402_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2402_hg38 || ln -s $(PHENOTYPE_DIR)/2402_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype || ln -s $(RUNNERS_DIR)/exomiser-14.0.0/* $(ROOT_DIR)/$(shell dirname $@)/







prepare-inputs: configurations/default-1.0.1/config.yaml





configurations/default-1.0.1/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/
	cp $(RUNNERS_DIR)/configurations/gado-1.0.1.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml







prepare-inputs: configurations/default-1.2.3/config.yaml





configurations/default-1.2.3/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/
	cp $(RUNNERS_DIR)/configurations/phen2gene-1.2.3.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml







.PHONY: prepare-corpora


$(TMP_DATA)/semsim/%.tsv:
	mkdir -p $(TMP_DATA)/semsim/
	wget $(SEMSIM_BASE_URL)/$*.tsv -O $@


results/run_data.txt:
	touch $@

results/gene_rank_stats.svg: results/run_data.txt
	pheval-utils benchmark-comparison -r $< -o $(ROOT_DIR)/$(shell dirname $@)/results --gene-analysis -y bar_cumulative
	mv $(ROOT_DIR)/gene_rank_stats.svg $@

.PHONY: pheval-report
pheval-report: results/gene_rank_stats.svg


results/default-13.3.0/results.yml: configurations/default-13.3.0/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/default-13.3.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: results/default-13.3.0/results.yml

results/default-14.0.0/results.yml: configurations/default-14.0.0/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/default-14.0.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 14.0.0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: results/default-14.0.0/results.yml

results/default-1.2.3/results.yml: configurations/default-1.2.3/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/default-1.2.3 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner phen2genephevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 1.2.3 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: results/default-1.2.3/results.yml

results/default-1.0.1/results.yml: configurations/default-1.0.1/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/default-1.0.1 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner gadophevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 1.0.1 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: results/default-1.0.1/results.yml
corpora/lirical/default/corpus.yml:
	test -d $(ROOT_DIR)/corpora/lirical/default/ || mkdir -p $(ROOT_DIR)/corpora/lirical/default/

	test -L $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz
	pheval-utils create-spiked-vcfs \
	 --template-vcf-path $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz  \
	 --phenopacket-dir=$(ROOT_DIR)/corpora/lirical/default/phenopackets \
	 --output-dir $(ROOT_DIR)/corpora/lirical/default/vcf
	touch $@


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
	mkdir -p $@
	cd $@
	git clone https://github.com/WGLab/Phen2Gene.git $@
	bash $@/setup.sh


.PHONY: pheval
pheval:
	$(MAKE) prepare-inputs
	$(MAKE) prepare-corpora
	$(MAKE) pheval-run
	$(MAKE) pheval-report

include ./resources/custom.Makefile

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

help: info
	@echo ""
	@echo "help"
	@echo "make pheval -- this runs the entire pipeline including corpus preparation and pheval run"
	@echo "make semsim -- generate all configured similarity profiles"
	@echo "make semsim-shuffle -- generate new ontology terms to the semsim process"
	@echo "make semsim-scramble -- scramble semsim profile"
	@echo "make semsim-convert -- convert all semsim profiles into exomiser SQL format"
	@echo "make semsim-ingest -- takes all the configured semsim profiles and loads them into the exomiser databases"

	@echo "make clean -- removes corpora and pheval results"
	@echo "make help -- show this help"
	@echo ""

info:
	@echo "Project: $(NAME)"
	@echo "Version: $(VERSION)"

.PHONY: prepare-inputs
prepare-inputs: configurations/exomiser-13.1.0-2309_phenotype/config.yaml

configurations/exomiser-13.1.0-2309_phenotype/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	ln -s $(RUNNERS_DIR)/exomiser-13.1.0/* $(ROOT_DIR)/$(shell dirname $@)/




.PHONY: prepare-corpora


results/exomiser-13.1.0/lirical-scrambled-0-2309_phenotype/results.yml: configurations/exomiser-13.1.0-2309_phenotype/config.yaml corpora/lirical/scrambled-0/corpus.yml
	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.1.0-2309_phenotype \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/scrambled-0 \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.1.0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@

.PHONY: run-exomiser-13.1.0-lirical-scrambled-0

run-exomiser-13.1.0-lirical-scrambled-0-2309_phenotype:
	$(MAKE) results/exomiser-13.1.0/lirical-scrambled-0-2309_phenotype/results.yml


pheval-run: run-exomiser-13.1.0-lirical-scrambled-0-2309_phenotype


results/exomiser-13.1.0/lirical-scrambled-0.5-2309_phenotype/results.yml: configurations/exomiser-13.1.0-2309_phenotype/config.yaml corpora/lirical/scrambled-0.5/corpus.yml
	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.1.0-2309_phenotype \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/scrambled-0.5 \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.1.0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@

.PHONY: run-exomiser-13.1.0-lirical-scrambled-0.5

run-exomiser-13.1.0-lirical-scrambled-0.5-2309_phenotype:
	$(MAKE) results/exomiser-13.1.0/lirical-scrambled-0.5-2309_phenotype/results.yml


pheval-run: run-exomiser-13.1.0-lirical-scrambled-0.5-2309_phenotype


results/exomiser-13.1.0/lirical-scrambled-0.7-2309_phenotype/results.yml: configurations/exomiser-13.1.0-2309_phenotype/config.yaml corpora/lirical/scrambled-0.7/corpus.yml
	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.1.0-2309_phenotype \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/scrambled-0.7 \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.1.0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@

.PHONY: run-exomiser-13.1.0-lirical-scrambled-0.7

run-exomiser-13.1.0-lirical-scrambled-0.7-2309_phenotype:
	$(MAKE) results/exomiser-13.1.0/lirical-scrambled-0.7-2309_phenotype/results.yml


pheval-run: run-exomiser-13.1.0-lirical-scrambled-0.7-2309_phenotype







corpora/lirical/scrambled-0/corpus.yml: corpora/lirical/default/corpus.yml $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz
	test -d $(ROOT_DIR)/corpora/lirical/scrambled-0/ || mkdir -p $(ROOT_DIR)/corpora/lirical/scrambled-0/
	test -L $(ROOT_DIR)/corpora/lirical/scrambled-0/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/scrambled-0/template_exome_hg19.vcf.gz

	pheval-utils create-spiked-vcfs \
	 --template-vcf-path $(ROOT_DIR)/corpora/lirical/scrambled-0/template_exome_hg19.vcf.gz  \
	 --phenopacket-dir=$(shell dirname $<)/phenopackets \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)/vcf

	test -d $(shell dirname $@)/phenopackets || mkdir -p $(shell dirname $@)/phenopackets
	pheval-utils scramble-phenopackets \
	 --scramble-factor 0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)/phenopackets \
	 --phenopacket-dir=$(shell dirname $<)/phenopackets

	touch $@

prepare-corpora: corpora/lirical/scrambled-0/corpus.yml


corpora/lirical/scrambled-0.5/corpus.yml: corpora/lirical/default/corpus.yml $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz
	test -d $(ROOT_DIR)/corpora/lirical/scrambled-0.5/ || mkdir -p $(ROOT_DIR)/corpora/lirical/scrambled-0.5/
	test -L $(ROOT_DIR)/corpora/lirical/scrambled-0.5/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/scrambled-0.5/template_exome_hg19.vcf.gz

	pheval-utils create-spiked-vcfs \
	 --template-vcf-path $(ROOT_DIR)/corpora/lirical/scrambled-0.5/template_exome_hg19.vcf.gz  \
	 --phenopacket-dir=$(shell dirname $<)/phenopackets \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)/vcf

	test -d $(shell dirname $@)/phenopackets || mkdir -p $(shell dirname $@)/phenopackets
	pheval-utils scramble-phenopackets \
	 --scramble-factor 0.5 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)/phenopackets \
	 --phenopacket-dir=$(shell dirname $<)/phenopackets

	touch $@

prepare-corpora: corpora/lirical/scrambled-0.5/corpus.yml


corpora/lirical/scrambled-0.7/corpus.yml: corpora/lirical/default/corpus.yml $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz
	test -d $(ROOT_DIR)/corpora/lirical/scrambled-0.7/ || mkdir -p $(ROOT_DIR)/corpora/lirical/scrambled-0.7/
	test -L $(ROOT_DIR)/corpora/lirical/scrambled-0.7/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/scrambled-0.7/template_exome_hg19.vcf.gz

	pheval-utils create-spiked-vcfs \
	 --template-vcf-path $(ROOT_DIR)/corpora/lirical/scrambled-0.7/template_exome_hg19.vcf.gz  \
	 --phenopacket-dir=$(shell dirname $<)/phenopackets \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)/vcf

	test -d $(shell dirname $@)/phenopackets || mkdir -p $(shell dirname $@)/phenopackets
	pheval-utils scramble-phenopackets \
	 --scramble-factor 0.7 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)/phenopackets \
	 --phenopacket-dir=$(shell dirname $<)/phenopackets

	touch $@

prepare-corpora: corpora/lirical/scrambled-0.7/corpus.yml




corpora/lirical/no_phenotype/corpus.yml: $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz
	echo "error $@ needs to be configured manually" && false




.PHONY: pheval
pheval:
	$(MAKE) prepare-inputs
	$(MAKE) prepare-corpora
	$(MAKE) pheval-run

include ./resources/custom.Makefile

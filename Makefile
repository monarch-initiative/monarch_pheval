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
	@echo "make setup -- this runs the download and extraction of genomic, phenotypic and runners data"
	@echo "make pheval -- this runs the entire pipeline including setup, corpus preparation and pheval run"
	@echo "make help -- show this help"
	@echo ""

info:
	@echo "Project: $(NAME)"
	@echo "Version: $(VERSION)"

.PHONY: prepare-inputs
prepare-inputs: configurations/exomiser-13.2.1-2302_phenotype/config.yaml

configurations/exomiser-13.2.1-2302_phenotype/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/
	
	cp -rf $(PHENOTYPE_DIR)/2302_phenotype $(ROOT_DIR)/$(shell dirname $@)/2302_phenotype
	cp $(RUNNERS_DIR)/configurations/exomiser-13.2.1-2302_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -L $(ROOT_DIR)/$(shell dirname $@)/2302_hg19  || ln -s $(PHENOTYPE_DIR)/2302_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2302_hg38 || ln -s $(PHENOTYPE_DIR)/2302_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2302_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.2.1/* $(ROOT_DIR)/$(shell dirname $@)/



prepare-inputs: configurations/exomiser-13.3.0-2302_phenotype/config.yaml

configurations/exomiser-13.3.0-2302_phenotype/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/
	
	cp -rf $(PHENOTYPE_DIR)/2302_phenotype $(ROOT_DIR)/$(shell dirname $@)/2302_phenotype
	cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2302_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -L $(ROOT_DIR)/$(shell dirname $@)/2302_hg19  || ln -s $(PHENOTYPE_DIR)/2302_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2302_hg38 || ln -s $(PHENOTYPE_DIR)/2302_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2302_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/



prepare-inputs: configurations/exomiser-13.2.1-2309_phenotype/config.yaml

configurations/exomiser-13.2.1-2309_phenotype/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/
	
	cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	cp $(RUNNERS_DIR)/configurations/exomiser-13.2.1-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_hg19  || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.2.1/* $(ROOT_DIR)/$(shell dirname $@)/



prepare-inputs: configurations/exomiser-13.3.0-2309_phenotype/config.yaml

configurations/exomiser-13.3.0-2309_phenotype/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/
	
	cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_hg19  || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -L $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/



.PHONY: prepare-corpora

results/run_data.txt:
	touch $@

results/gene_rank_stats.svg: results/run_data.txt
	pheval-utils benchmark-comparison -r $< -o results --gene-analysis -y bar_cumulative


.PHONY: pheval-report
pheval-report: results/gene_rank_stats.svg


results/exomiser-13.2.1/lirical-default-2302_phenotype/results.yml: configurations/exomiser-13.2.1-2302_phenotype/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.2.1-2302_phenotype \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.2.1 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo $(ROOT_DIR)/corpora/lirical/default/phenopackets	$(ROOT_DIR)/$(shell dirname $@) >> results/run_data.txt


.PHONY: pheval-run
pheval-run: results/exomiser-13.2.1/lirical-default-2302_phenotype/results.yml

results/exomiser-13.3.0/lirical-default-2302_phenotype/results.yml: configurations/exomiser-13.3.0-2302_phenotype/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-2302_phenotype \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo $(ROOT_DIR)/corpora/lirical/default/phenopackets	$(ROOT_DIR)/$(shell dirname $@) >> results/run_data.txt


.PHONY: pheval-run
pheval-run: results/exomiser-13.3.0/lirical-default-2302_phenotype/results.yml

results/exomiser-13.2.1/lirical-default-2309_phenotype/results.yml: configurations/exomiser-13.2.1-2309_phenotype/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.2.1-2309_phenotype \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.2.1 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo $(ROOT_DIR)/corpora/lirical/default/phenopackets	$(ROOT_DIR)/$(shell dirname $@) >> results/run_data.txt


.PHONY: pheval-run
pheval-run: results/exomiser-13.2.1/lirical-default-2309_phenotype/results.yml

results/exomiser-13.3.0/lirical-default-2309_phenotype/results.yml: configurations/exomiser-13.3.0-2309_phenotype/config.yaml corpora/lirical/default/corpus.yml


	rm -rf $(ROOT_DIR)/$(shell dirname $@)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)
	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-2309_phenotype \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(ROOT_DIR)/$(shell dirname $@)

	touch $@
	echo $(ROOT_DIR)/corpora/lirical/default/phenopackets	$(ROOT_DIR)/$(shell dirname $@) >> results/run_data.txt


.PHONY: pheval-run
pheval-run: results/exomiser-13.3.0/lirical-default-2309_phenotype/results.yml
corpora/lirical/default/corpus.yml:
	test -d $(ROOT_DIR)/corpora/lirical/default/ || mkdir -p $(ROOT_DIR)/corpora/lirical/default/

	test -L $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz
	pheval-utils create-spiked-vcfs \
	 --template-vcf-path $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz  \
	 --phenopacket-dir=$(ROOT_DIR)/corpora/lirical/default/phenopackets \
	 --output-dir $(ROOT_DIR)/corpora/lirical/default/vcf
	touch $@


.PHONY: pheval
pheval:
	$(MAKE) prepare-inputs
	$(MAKE) prepare-corpora
	$(MAKE) pheval-run
	$(MAKE) pheval-report

include ./resources/custom.Makefile

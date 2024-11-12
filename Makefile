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



help: info
	@echo ""
	@echo "help"
	@echo "make setup -- this runs the download and extraction of genomic, phenotypic and runners data"
	@echo "make pheval -- this runs pheval pipeline corpus preparation and run"
	@echo "make all -- this runs the entire pipeline including setup, corpus preparation and pheval run"
	@echo "make help -- show this help"
	@echo ""

info:
	@echo "Project: $(NAME)"
	@echo "Version: $(VERSION)"

.PHONY: prepare-inputs






configurations/exomiser-13.3.0/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/













configurations/exomiser-14.0.0/config.yaml:
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype || cp -rf $(PHENOTYPE_DIR)/2402_phenotype $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-14.0.0-2402_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_hg19 || ln -s $(PHENOTYPE_DIR)/2402_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_hg38 || ln -s $(PHENOTYPE_DIR)/2402_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2402_phenotype || ln -s $(RUNNERS_DIR)/exomiser-14.0.0/* $(ROOT_DIR)/$(shell dirname $@)/









SQL_DEPENDENCIES_exomiser-13.3.0-S01-lattice = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql 

configurations/exomiser-13.3.0-S01-lattice/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_exomiser-13.3.0-S01-lattice)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/exomiser-13.3.0-S01-lattice/config.yaml






SQL_DEPENDENCIES_exomiser-13.3.0-S02-equivalent = $(TMP_DATA)/semsim/phenio-equivalent-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-equivalent-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-equivalent-hp-zp.0.4.semsimian.sql 

configurations/exomiser-13.3.0-S02-equivalent/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_exomiser-13.3.0-S02-equivalent)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-equivalent-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-equivalent-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-equivalent-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/exomiser-13.3.0-S02-equivalent/config.yaml






SQL_DEPENDENCIES_exomiser-13.3.0-S03-flat = $(TMP_DATA)/semsim/phenio-flat-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-flat-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-flat-hp-zp.0.4.semsimian.sql 

configurations/exomiser-13.3.0-S03-flat/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_exomiser-13.3.0-S03-flat)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-flat-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-flat-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-flat-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/exomiser-13.3.0-S03-flat/config.yaml






SQL_DEPENDENCIES_exomiser-13.3.0-C1 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql 

configurations/exomiser-13.3.0-C1/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_exomiser-13.3.0-C1)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/exomiser-13.3.0-C1/config.yaml






SQL_DEPENDENCIES_exomiser-13.3.0-C2 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql 

configurations/exomiser-13.3.0-C2/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_exomiser-13.3.0-C2)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp-truncate.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/exomiser-13.3.0-C2/config.yaml






SQL_DEPENDENCIES_exomiser-13.3.0-C3 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql 

configurations/exomiser-13.3.0-C3/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_exomiser-13.3.0-C3)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/exomiser-13.3.0-C3/config.yaml






SQL_DEPENDENCIES_exomiser-13.3.0-C5 = $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql  $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql 

configurations/exomiser-13.3.0-C5/config.yaml: $(RUNNERS_DIR)/exomiser-13.3.0 $(SQL_DEPENDENCIES_exomiser-13.3.0-C5)
	mkdir -p $(ROOT_DIR)/$(shell dirname $@)/

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || cp -rf $(PHENOTYPE_DIR)/2309_phenotype $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype
	test -e $(ROOT_DIR)/$(shell dirname $@)/config.yaml || cp $(RUNNERS_DIR)/configurations/exomiser-13.3.0-2309_phenotype.config.yaml $(ROOT_DIR)/$(shell dirname $@)/config.yaml

	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg19 || ln -s $(PHENOTYPE_DIR)/2309_hg19 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_hg38 || ln -s $(PHENOTYPE_DIR)/2309_hg38 $(ROOT_DIR)/$(shell dirname $@)/
	test -e $(ROOT_DIR)/$(shell dirname $@)/2309_phenotype || ln -s $(RUNNERS_DIR)/exomiser-13.3.0/* $(ROOT_DIR)/$(shell dirname $@)/
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-hp.0.4.semsimian.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-mp-truncate.sql -user sa
 
	java -Xms128m -Xmx8192m -Dh2.bindAddress=127.0.0.1 -cp $(shell find $< -type f -name "h2*.jar") org.h2.tools.RunScript -url jdbc:h2:file:$(ROOT_DIR)/$(shell dirname $@)/2309_phenotype/2309_phenotype -script $(TMP_DATA)/semsim/phenio-monarch-hp-zp.0.4.semsimian.sql -user sa
 

.PHONY: semsim-ingest
semsim-ingest: configurations/exomiser-13.3.0-C5/config.yaml




.PHONY: prepare-corpora


$(TMP_DATA)/semsim/%.tsv:
	mkdir -p $(TMP_DATA)/semsim/
	wget $(SEMSIM_BASE_URL)/$*.tsv -O $@


$(TMP_DATA)/semsim/%.sql:
	mkdir -p $(TMP_DATA)/semsim/
	wget $(SEMSIM_BASE_URL)/$*.sql -O $@




$(ROOT_DIR)/results/exomiser-14.0.0-lirical-default/results.yml: configurations/exomiser-14.0.0/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-14.0.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 14.0.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-14.0.0-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-14.0.0/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-C1-lirical-default/results.yml: configurations/exomiser-13.3.0-C1/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-C1 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-C1-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0-C1/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0-C1/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0-C1/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-C2-lirical-default/results.yml: configurations/exomiser-13.3.0-C2/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-C2 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-C2-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0-C2/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0-C2/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0-C2/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-C3-lirical-default/results.yml: configurations/exomiser-13.3.0-C3/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-C3 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-C3-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0-C3/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0-C3/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0-C3/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-C5-lirical-default/results.yml: configurations/exomiser-13.3.0-C5/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-C5 \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-C5-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0-C5/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0-C5/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0-C5/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-S01-lattice-lirical-default/results.yml: configurations/exomiser-13.3.0-S01-lattice/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-S01-lattice \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-S01-lattice-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0-S01-lattice/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0-S01-lattice/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0-S01-lattice/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-S02-equivalent-lirical-default/results.yml: configurations/exomiser-13.3.0-S02-equivalent/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-S02-equivalent \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-S02-equivalent-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0-S02-equivalent/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0-S02-equivalent/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0-S02-equivalent/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-13.3.0-S03-flat-lirical-default/results.yml: configurations/exomiser-13.3.0-S03-flat/config.yaml corpora/lirical/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-13.3.0-S03-flat \
	 --testdata-dir $(ROOT_DIR)/corpora/lirical/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 13.3.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/lirical/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-13.3.0-S03-flat-lirical-default/results.yml




#$(ROOT_DIR)/results/exomiser-13.3.0-S03-flat/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-13.3.0-S03-flat/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-13.3.0-S03-flat/gene_rank_stats.svg



$(ROOT_DIR)/results/exomiser-14.0.0-phenopacket-store-default/results.yml: configurations/exomiser-14.0.0/config.yaml corpora/phenopacket-store/default/corpus.yml

	mkdir -p $(shell dirname $@)



	pheval run \
	 --input-dir $(ROOT_DIR)/configurations/exomiser-14.0.0 \
	 --testdata-dir $(ROOT_DIR)/corpora/phenopacket-store/default \
	 --runner exomiserphevalrunner \
	 --tmp-dir data/tmp/ \
	 --version 14.0.0 \
	 --output-dir $(shell dirname $@)

	touch $@
	echo -e "$(ROOT_DIR)/corpora/phenopacket-store/default/phenopackets\t$(ROOT_DIR)/$(shell dirname $@)" >> results/run_data.txt

.PHONY: pheval-run
pheval-run: $(ROOT_DIR)/results/exomiser-14.0.0-phenopacket-store-default/results.yml




#$(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg: $(ROOT_DIR)/results/exomiser-14.0.0/run_data.yaml
#	pheval-utils generate-benchmark-stats -r $<

#.PHONY: pheval-report
#pheval-report: $(ROOT_DIR)/results/exomiser-14.0.0/gene_rank_stats.svg




corpora/lirical/default/corpus.yml:
	test -d $(ROOT_DIR)/corpora/lirical/default/ || mkdir -p $(ROOT_DIR)/corpora/lirical/default/

	test -L $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz
	pheval-utils create-spiked-vcfs \
		--hg19-template-vcf $(ROOT_DIR)/corpora/lirical/default/template_exome_hg19.vcf.gz  \
		--phenopacket-dir=$(ROOT_DIR)/corpora/lirical/default/phenopackets \
		--output-dir $(ROOT_DIR)/corpora/lirical/default/vcf
	touch $@





corpora/lirical/small_version/corpus.yml:
	test -d $(ROOT_DIR)/corpora/lirical/small_version/ || mkdir -p $(ROOT_DIR)/corpora/lirical/small_version/

	test -L $(ROOT_DIR)/corpora/lirical/small_version/template_exome_hg19.vcf.gz || ln -s $(ROOT_DIR)/testdata/template_vcf/template_exome_hg19.vcf.gz $(ROOT_DIR)/corpora/lirical/small_version/template_exome_hg19.vcf.gz
	pheval-utils create-spiked-vcfs \
		--hg19-template-vcf $(ROOT_DIR)/corpora/lirical/small_version/template_exome_hg19.vcf.gz  \
		--phenopacket-dir=$(ROOT_DIR)/corpora/lirical/small_version/phenopackets \
		--output-dir $(ROOT_DIR)/corpora/lirical/small_version/vcf
	touch $@







corpora/phenopacket-store/default/corpus.yml: $(TMP_DATA)/all_phenopackets/all_phenopackets.zip
	mkdir -p corpora/phenopacket-store/default/phenopackets/
	pheval-utils prepare-corpus -p $(TMP_DATA)/all_phenopackets/unpacked_phenopackets --gene-analysis -g ensembl_id -o $(ROOT_DIR)/$(shell dirname $@)/
	touch $@
	#temporary
	touch $@




.PHONY: pheval
pheval:
	$(MAKE) prepare-inputs
	$(MAKE) prepare-corpora
	$(MAKE) pheval-run
	#$(MAKE) pheval-report

.PHONY: all
all:
	$(MAKE) setup
	$(MAKE) pheval

include ./resources/custom.Makefile

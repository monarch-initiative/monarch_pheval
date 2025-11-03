# Data Processing Report

## Directories
- **Data Directory:** `data`
- **Temporary Directory:** `data/tmp`

---

## Corpora

### Corpus: lirical (Variant: default)
- **Custom Variants:**
  - no_phenotype

### Corpus: lirical (Variant: small_version)
- **Custom Variants:**
  - no_phenotype

### Corpus: phenopacket-store (Variant: default)
- **Custom Variants:**
  - no_phenotype


---

## Configurations

### Default configuration for Exomiser 13
- **Configuration ID:** `exomiser-13.3.0`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

### Default configuration for Exomiser 14
- **Configuration ID:** `exomiser-14.0.0`
- **Tool:** exomiser (14.0.0)
- **Phenotype Database Version:** 2402

### S01 - Exomiser 13 with semantic similarity profiles (PHENIO Monarch), 0.4 threshold
- **Configuration ID:** `S01`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-monarch-hp-hp.0.4.semsimian.sql`
  - `phenio-monarch-hp-mp.0.4.semsimian.sql`
  - `phenio-monarch-hp-zp.0.4.semsimian.sql`
  

### S02 - Exomiser 13 with semantic similarity profiles (PHENIO Equivalent), 0.4 threshold
- **Configuration ID:** `S02`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-equivalent-hp-hp.0.4.semsimian.sql`
  - `phenio-equivalent-hp-mp.0.4.semsimian.sql`
  - `phenio-equivalent-hp-zp.0.4.semsimian.sql`
  

### S03 - Exomiser 13 with semantic similarity profiles (PHENIO Flat), 0.4 threshold
- **Configuration ID:** `S03`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-flat-hp-hp.0.4.semsimian.sql`
  - `phenio-flat-hp-mp.0.4.semsimian.sql`
  - `phenio-flat-hp-zp.0.4.semsimian.sql`
  

### S04 - Exomiser 13 with semantic similarity profiles (PHENIO Release), 0.4 threshold
- **Configuration ID:** `S04`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-release-hp-hp.0.4.semsimian.sql`
  - `phenio-release-hp-mp.0.4.semsimian.sql`
  - `phenio-release-hp-zp.0.4.semsimian.sql`
  

### C01 - Exomiser 13 with semantic similarity profiles (PHENIO Monarch), 0.4 threshold, only HP
- **Configuration ID:** `C01`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-monarch-hp-hp.0.4.semsimian.sql`
  - `phenio-monarch-hp-mp-truncate.sql`
  - `phenio-monarch-hp-zp-truncate.sql`
  

### C02 - Exomiser 13 with semantic similarity profiles (PHENIO Monarch), 0.4 threshold, only HP, MP
- **Configuration ID:** `C02`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-monarch-hp-hp.0.4.semsimian.sql`
  - `phenio-monarch-hp-mp.0.4.semsimian.sql`
  - `phenio-monarch-hp-zp-truncate.sql`
  

### C05 - Exomiser 13 with semantic similarity profiles (PHENIO Monarch), 0.4 threshold, only HP, ZP
- **Configuration ID:** `C05`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-monarch-hp-hp.0.4.semsimian.sql`
  - `phenio-monarch-hp-mp-truncate.sql`
  - `phenio-monarch-hp-zp.0.4.semsimian.sql`
  

### I01 - Exomiser 13 with semantic similarity profiles (PHENIO Monarch), 0.7 threshold
- **Configuration ID:** `I01`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-monarch-hp-hp.0.7.semsimian.sql`
  - `phenio-monarch-hp-mp.0.7.semsimian.sql`
  - `phenio-monarch-hp-zp.0.7.semsimian.sql`
  

### I02 - Exomiser 13 with semantic similarity profiles (PHENIO Monarch), 0.4 threshold, IC scores
- **Configuration ID:** `I02`
- **Tool:** exomiser (13.3.0)
- **Phenotype Database Version:** 2309

- **Preprocessing queries for phenotype database:**
  - `phenio-monarch-hp-hp.0.4.semsimian.ic.sql`
  - `phenio-monarch-hp-mp.0.4.semsimian.ic.sql`
  - `phenio-monarch-hp-zp.0.4.semsimian.ic.sql`
  
---

## Runs

### Default configuration for Exomiser 13 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `exomiser-13.3.0`
- **Corpus:** lirical (Variant: default)

### Default configuration for Exomiser 14 on LIRICAL Corpus
- **Tool:** exomiser (14.0.0)
- **Configuration Used:** `exomiser-14.0.0`
- **Corpus:** lirical (Variant: default)

### C01 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `C01`
- **Corpus:** lirical (Variant: default)

### C02 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `C02`
- **Corpus:** lirical (Variant: default)

### C05 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `C05`
- **Corpus:** lirical (Variant: default)

### S01 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S01`
- **Corpus:** lirical (Variant: default)

### S02 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S02`
- **Corpus:** lirical (Variant: default)

### S03 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S03`
- **Corpus:** lirical (Variant: default)

### S04 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S04`
- **Corpus:** lirical (Variant: default)

### I01 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `I01`
- **Corpus:** lirical (Variant: default)

### I02 on LIRICAL Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `I02`
- **Corpus:** lirical (Variant: default)

### Default configuration for Exomiser 13 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `exomiser-13.3.0`
- **Corpus:** phenopacket-store (Variant: default)

### Default configuration for Exomiser 14 on Phenopacket Store Corpus
- **Tool:** exomiser (14.0.0)
- **Configuration Used:** `exomiser-14.0.0`
- **Corpus:** phenopacket-store (Variant: default)

### C01 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `C01`
- **Corpus:** phenopacket-store (Variant: default)

### C02 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `C02`
- **Corpus:** phenopacket-store (Variant: default)

### C05 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `C05`
- **Corpus:** phenopacket-store (Variant: default)

### S01 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S01`
- **Corpus:** phenopacket-store (Variant: default)

### S02 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S02`
- **Corpus:** phenopacket-store (Variant: default)

### S03 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S03`
- **Corpus:** phenopacket-store (Variant: default)

### S04 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `S04`
- **Corpus:** phenopacket-store (Variant: default)

### I01 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `I01`
- **Corpus:** lirical (Variant: default)

### I02 on Phenopacket Store Corpus
- **Tool:** exomiser (13.3.0)
- **Configuration Used:** `I02`
- **Corpus:** lirical (Variant: default)

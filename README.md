# PRA2003 – Week 4: Bacteria per event in 5 million events

Counting bacterial strains per event in a sample of 5M events, with
statistical uncertainties from the sub-sampling method.

## Contents

1. [Overview](#1-overview)
2. [Files](#2-files)
3. [How to run](#3-how-to-run)
4. [The data](#4-the-data)
5. [Method](#5-method)
6. [Results](#6-results)
7. [Notes and limitations](#7-notes-and-limitations)

---

## 1. Overview

The goal this week is to measure the **average number of each bacterial
strain per event**, together with its **statistical uncertainty**, using
the entire sample of 5M events (10 files of 500K events each). The
uncertainties are calculated with the **sub-sampling method** from the
lecture.

Each strain appears as a normal (wild-type) form with a positive ID and a
mutant form with the same ID and a minus sign (for example E. coli WT = 211
and E. coli mutant = -211).

## 2. Files

| File | Purpose |
|---|---|
| `README.md` | Current file |
| `<Week4Sub_Sample.R>` | Counts every ID in each of the 10 data files and creates all of the sub-samples |
| `<Week4Analysis.R>` | Combines the 10 sub-samples and computes the final averages and uncertainties |
| `sub_sample_results.csv` | Output of part 1: count and average per ID for each file |
| `final_results.csv` | Output of part 2: final average ± uncertainty per ID |

The raw data files (`output-Set1.txt` … `output-Set10.txt`, about 800 MB
each) are **not** included in the repository due to their size. They
can be downloaded here --> https://surfdrive.surf.nl/files/index.php/s/7udCnWTk4yMUASD.

## 3. How to run

1. Put the 10 raw data files in the same folder as the scripts.
2. Run the scripts in order:

```bash
<command for part 1>   # reads the raw data, writes sub_sample_results.csv
<command for part 2>   # reads sub_sample_results.csv, writes final_results.csv
```

Part 2 only needs the CSV from part 1, so the final results can be
reproduced without the raw data files.

## 4. The data

- 10 files, each containing about 500K events (5M events in total).
- Each event starts with a header line (event number and number of
  bacteria), followed by one line per bacterium: three momentum components
  and the bacterial ID.
- The IDs of the 12 strains of interest are:

| ID | Strain | ID | Strain |
|---:|---|---:|---|
| 211 | E. coli WT | -211 | E. coli mutant |
| 321 | Bacillus subtilis WT | -321 | Bacillus subtilis mutant |
| 2212 | Pseudomonas aeruginosa WT | -2212 | Pseudomonas aeruginosa antibiotic-resistant |
| 3122 | Streptococcus pneumoniae | -3122 | Capsule-deficient S. pneumoniae |
| 3312 | Mycobacterium tuberculosis | -3312 | Drug-resistant M. tuberculosis |
| 3334 | Salmonella enterica | -3334 | Salmonella mutant |

The data contain further IDs that are not one of these 12 strains. They
appear as "Unknown" in `final_results.csv` and are not part of the result
below.

## 5. Method

The sub-sampling technique:

1. **Split** the sample into 10 sub-samples of similar size. Each data file
   (about 500K events) is one sub-sample.
2. **Analyse each sub-sample separately:** for every ID, compute the
   average number per event in that file.
3. **Central value:** the (weighted) average of the 10 sub-sample results.
4. **Statistical uncertainty:** the standard deviation of the 10
   sub-sample results.

The standard deviation describes how much the result varies from one
sub-sample of about 500K events to another. Only the statistical
uncertainty is quoted. No systematic uncertainty was evaluated, and since
the result is a number per event, it has no unit.

## 6. Results

Average number per event over the full sample, with the statistical
uncertainty from the spread of the 10 sub-samples:

| ID | Strain | Number per event (± stat.) |
|---:|---|---:|
| 211 | E. coli WT | 19.949 ± 0.033 |
| -211 | E. coli mutant | 19.917 ± 0.032 |
| 321 | Bacillus subtilis WT | 2.509 ± 0.005 |
| -321 | Bacillus subtilis mutant | 2.503 ± 0.006 |
| 2212 | Pseudomonas aeruginosa WT | 1.2080 ± 0.0019 |
| -2212 | Pseudomonas aeruginosa antibiotic-resistant | 1.1842 ± 0.0024 |
| 3122 | Streptococcus pneumoniae | 0.2766 ± 0.0011 |
| -3122 | Capsule-deficient S. pneumoniae | 0.2717 ± 0.0010 |
| 3312 | Mycobacterium tuberculosis | 0.03944 ± 0.00028 |
| -3312 | Drug-resistant M. tuberculosis | 0.03900 ± 0.00040 |
| 3334 | Salmonella enterica | 0.00119 ± 0.00004 |
| -3334 | Salmonella mutant | 0.00115 ± 0.00005 |

Uncertainties are rounded to 1–2 significant figures and the central values
to the same decimal place. The unrounded numbers are in
`final_results.csv`.

## 7. Notes and limitations

- **Meaning of the uncertainty.** The quoted uncertainty is the spread of
  one 500K-event sub-sample. The uncertainty of the average over all 10
  sub-samples is smaller by a factor of about √10 (the standard error of
  the mean).
- **Wild type vs mutant.** For each strain the wild type and the mutant
  have similar averages (for example E. coli: 19.949 vs 19.917). The counts
  of a wild type and its mutant come from the same events and can be
  correlated, so the uncertainty on their difference should not be
  obtained by simply adding the two uncertainties in quadrature. A
  difference should be computed within each sub-sample and the spread taken
  over those values.
- **Empty events.** <state here whether events with no bacteria were counted
  in the number of events, and the resulting total number of events>
- **Statistical only.** No systematic uncertainty was estimated.

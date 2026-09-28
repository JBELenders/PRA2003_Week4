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
| `<Week4Sub_Sampling.R>` | Counts every ID in each of the 10 data files, creating all of the sub-samples, which are outputted in a csv file as a list |
| `<Week4Analysis.R>` | Reads the list and computes the final averages and uncertainties |
| `sub_sample_results.csv` | Output of "Week4Sub_Sampling.R": count and average per ID for each file |
| `final_results.csv` | Output of "Week4Analysis.R": final average ± uncertainty per ID |

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
- Empty events are excluded from the average

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

New message from panos, which i still need to make sure to include on a later day
Dear all,

let me stress that the results that you are going to include in your updated README.md file should not contain only the average numbers per event for each ID together with their respective  uncertainties.

These numbers allow you to answer the question of whether you have an asymmetry between the normal bacteria and the mutation strains, the various molecule pairs or between particles and antiparticles (i.e. the initial question you had to answer). This answer, for every pair of IDs (e.g. 211 vs -211, 321 vs -321,...), should also be reported and should not be based on your feelings but on your numbers so make sure you argue why you answer the way you do.

You do have all the tools to answer this!
Best regards

Panos

### 6.1 Average count per event (5M events, 10 sub-samples)

| ID | Strain | Total count | Average / event | Uncertainty |
|---:|---|---:|---:|---:|
| 211 | E. coli WT | 92,126,688 | 19.9495 | ± 0.0327 |
| -211 | E. coli mutant | 91,977,542 | 19.9172 | ± 0.0319 |
| 321 | Bacillus subtilis WT | 11,587,227 | 2.50915 | ± 0.00477 |
| -321 | Bacillus subtilis mutant | 11,560,946 | 2.50346 | ± 0.00550 |
| 2212 | Pseudomonas aeruginosa WT | 5,578,693 | 1.20803 | ± 0.00190 |
| -2212 | P. aeruginosa antibiotic-resistant | 5,468,447 | 1.18416 | ± 0.00241 |
| 3122 | Streptococcus pneumoniae | 1,277,330 | 0.276599 | ± 0.00107 |
| -3122 | Capsule-deficient S. pneumoniae | 1,254,690 | 0.271696 | ± 0.000985 |
| 3312 | Mycobacterium tuberculosis | 182,139 | 0.0394412 | ± 0.000284 |
| -3312 | Drug-resistant M. tuberculosis | 180,104 | 0.0390005 | ± 0.000402 |
| 3334 | Salmonella enterica | 5,482 | 0.00118710 | ± 0.0000417 |
| -3334 | Salmonella mutant | 5,318 | 0.00115158 | ± 0.0000508 |

The data also contain 26 other IDs that are not one of the 12 strains. They
are listed as "Unknown" in `final_results.csv`.

### 6.2 Asymmetry: wild type vs mutant

| Pair | X - (-X) | n σ | Asymmetry A | Asymmetric? |
|---|---:|---:|---:|:---:|
| 211 vs -211 (E. coli) | 0.0323 ± 0.0457 | 0.71 | (0.08 ± 0.12)% | no |
| 321 vs -321 (B. subtilis) | 0.00569 ± 0.00728 | 0.78 | (0.11 ± 0.15)% | no |
| 2212 vs -2212 (P. aeruginosa) | 0.02387 ± 0.00307 | **7.78** | **(1.00 ± 0.13)%** | **yes** |
| 3122 vs -3122 (S. pneumoniae) | 0.00490 ± 0.00145 | **3.37** | **(0.89 ± 0.27)%** | **yes** |
| 3312 vs -3312 (M. tuberculosis) | 0.00044 ± 0.00049 | 0.90 | (0.56 ± 0.63)% | no |
| 3334 vs -3334 (Salmonella) | 0.000036 ± 0.000066 | 0.54 | (1.5 ± 2.8)% | no |

The averages of X and -X are in table 7.1.

#### The answer for each pair, and why

- **211 vs -211, E. coli: no asymmetry.**
  - The WT is 0.0323 per event higher, but the uncertainty on that
    difference is 0.0457, so the difference is only **0.71σ**.
  - A difference this size is expected from statistical fluctuations alone.
  - A = (0.08 ± 0.12)% is consistent with zero, so any real asymmetry is
    smaller than about **0.4%**.
- **321 vs -321, Bacillus subtilis: no asymmetry.**
  - The difference is **0.78σ**, and A = (0.11 ± 0.15)% is consistent with
    zero.
  - Any real asymmetry is smaller than about **0.5%**.
- **2212 vs -2212, Pseudomonas aeruginosa: yes, a clear asymmetry.**
  - The wild type is 0.0239 per event more common than the
    antibiotic-resistant strain.
  - That is **7.8σ**, far above the 3σ threshold, so it cannot be a
    statistical fluctuation.
  - A = **(1.00 ± 0.13)%**.
  - The wild type is also higher in **all 10** sub-samples.
- **3122 vs -3122, Streptococcus pneumoniae: yes, an asymmetry.**
  - The wild type is more common than the capsule-deficient strain by
    **3.37σ**, which is above the 3σ threshold.
  - A = **(0.89 ± 0.27)%**.
  - The wild type is higher in **all 10** sub-samples.
  - Because 3.37σ is only just above 3σ, this result is weaker than the one
    for Pseudomonas.
- **3312 vs -3312, Mycobacterium tuberculosis: no asymmetry.**
  - The difference is **0.90σ**, and A = (0.56 ± 0.63)% is consistent with
    zero.
  - With about 180,000 counts per strain, the data can only rule out
    asymmetries larger than about **2.5%**.
- **3334 vs -3334, Salmonella: no asymmetry.**
  - The difference is **0.54σ**.
  - With only about 5,400 counts per strain, A = (1.5 ± 2.8)% is very
    imprecise, so an asymmetry smaller than about **10%** cannot be ruled
    out.

### 6.3 Asymmetry: the other 12 particle/antiparticle pairs

The same test applied to the 12 other pairs of IDs in the data:

| Pair | X - (-X) | n σ | Asymmetry A | Asymmetric? |
|---|---:|---:|---:|:---:|
| 3212 vs -3212 | 0.00173 ± 0.00097 | 1.78 | (0.57 ± 0.32)% | no |
| 3222 vs -3222 | 0.00173 ± 0.00083 | 2.07 | (0.58 ± 0.28)% | no |
| 3112 vs -3112 | 0.00202 ± 0.00080 | 2.52 | (0.68 ± 0.27)% | no (but close) |
| 3322 vs -3322 | 0.00026 ± 0.00035 | 0.76 | (0.34 ± 0.45)% | no |
| 431 vs -431 | -0.00005 ± 0.00021 | 0.26 | (-0.23 ± 0.90)% | no |
| 531 vs -531 | 0.00002 ± 0.00007 | 0.32 | (1.3 ± 3.9)% | no |
| 4232 vs -4232 | 0.000003 ± 0.000042 | 0.07 | (0.2 ± 3.6)% | no |
| 4132 vs -4132 | 0.000008 ± 0.000045 | 0.17 | (0.7 ± 3.9)% | no |
| 5132 vs -5132 | 0.000014 ± 0.000020 | 0.70 | (14 ± 19)% | no |
| 5232 vs -5232 | -0.000002 ± 0.000017 | 0.13 | (-2 ± 16)% | no |
| 4332 vs -4332 | 0.000004 ± 0.000010 | 0.46 | (13 ± 31)% | no |
| 5332 vs -5332 | 0.0000006 ± 0.0000032 | 0.20 | (18 ± 86)% | no |

- **None of these 12 pairs reaches 3σ,** so none shows a significant
  asymmetry.
- **3112 vs -3112** is the closest, at 2.5σ. That is close, but not enough
  to claim an asymmetry.
- **The rarest pairs** (5132, 5232, 4332 and 5332, with 7–260 counts each)
  have such large uncertainties that they cannot show anything either way.

---



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

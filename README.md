# members-of-legal-profession-on-political-spectrum
# Members of the American Legal Profession on the Political Spectrum

Independent research project (Polygence, Sep. 2023 – Jan. 2025) reevaluating a Harvard-published study (Bonica, Chilton & Sen, 2014) on the political ideology of American lawyers, using more recent campaign-finance data. Presented at the Polygence Symposium and published in the Curieux Academic Journal.

## Overview

Uses the **DIME dataset** (Database on Ideology, Money, and Elections) — a comprehensive record of political campaign contributions by individuals and organizations from 1979–2022 — to examine how political ideology (measured via CFscore, a continuous liberal-to-conservative score) varies by gender, state, and donor type (individual lawyer vs. corporate/firm) within the legal profession.

## What the code does

### Data cleaning
- Loads the raw `lawyers.RData` contributor dataset
- Creates an `INDIV` flag distinguishing individual donors from corporate/firm donors based on contributor type
- Filters out contributors with unspecified gender for gender-based comparisons

### Analysis 1 — Ideology by gender and state
- Compares mean CFscore (political ideology) between male and female lawyers
- Narrows the comparison to California and Pennsylvania as two contrasting political climates
- Visualizes the distribution with boxplots, faceted by state

### Hypothesis testing
- **T-tests** comparing mean CFscore by gender within California and within Pennsylvania separately (both reject the null hypothesis of equal means — i.e., a statistically significant ideological difference between male and female lawyers in each state)
- **T-test** comparing mean CFscore between individual lawyers and corporate/firm donors overall
- **Chi-square test** comparing the distribution of donor gender between California and Pennsylvania

### Analysis 2 — Individuals vs. corporations
- Compares the ideology distribution (density plots) of individual lawyer donors vs. corporate/firm donors
- Compares donation amounts between individuals and corporations across four presidential election cycles (2008, 2012, 2016, 2020), reshaping and combining the data to visualize trends over time

## Key findings

- Female lawyers trend more liberal than male lawyers, and this gender gap is statistically significant within both California and Pennsylvania individually
- Individual donors skew more liberal on average than corporate/firm donors, who cluster closer to the political center
- Donation amounts from both individuals and corporations increased in the 2016 and 2020 cycles compared to 2008/2012, with corporations donating larger amounts overall

## Tools

R (dplyr, ggplot2, reshape2), t-tests, chi-square test

## Files

- `Analysis_4DEC.R` — initial exploration: data cleaning, individual/corporate donor split, early gender-based ideology comparison
- `Analysis_14DEC.R` — expanded analysis: state-by-state (CA/PA) gender comparison, hypothesis tests, individual vs. corporate comparison, multi-year donation trend analysis

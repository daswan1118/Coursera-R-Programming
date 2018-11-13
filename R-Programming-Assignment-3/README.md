---
output:
  html_document: default
  pdf_document: default
  word_document: default
---
# Coursera R Programming Week 4 Assignment

The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov) run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset essentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining whether hospitals should be fined for not providing high quality care to patients (see http://goo.gl/jAXFX for some background on this particular topic).



**1. Plot the 30-day mortality rates for heart attack**

Read the outcome data into R via the read.csv function and look at the first few rows.

**2. Finding the best hospital in a state**

Write a function called best that take two arguments: the 2-character abbreviated name of a state and an outcome name.

**3. Ranking hospitals by outcome in a state**

Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a state `state`, an outcome `outcome`, and the ranking of a hospital in that state for that outcome `num`.


**4. Ranking hospitals in all states**

Write a function called `rankall` that takes two arguments: an outcome name `outcome` and a hospital ranking `num`.
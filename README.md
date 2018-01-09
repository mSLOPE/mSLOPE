mSLOPE: Model-free Knockoffs for SLOPE-Adaptive Variable Selection with Controlled False Discovery Rate
------------------------------------------------------

1. Introduction
===============

Thank you for downloading the mSLOPE solver!  mSLOPE is a varriable selection procedure. mSLOPE is adaptive, computationally tractable
and control FDR at desired levels. It is designed to solve the following three problems: 

1. mSLOPE Problem:
   minimize  ||y - [x, x]B||_2  subject to  J_λ(x)

Where J_λ(x) is the ordered L1-norm, the augmented matrix [x,x] and vector y can be defined explicily, B is unknown.

2. FDR
==============

FDR = sum(B(s) == 0)/max(1,length(S)
where S is selected set of relevant features and B coefficient is selected using step 1.

3. Figures
==============

All figures are drawn using matlab. Data to draw figures are availabe in data folder. Each matlab file
draw one figure when you run it.

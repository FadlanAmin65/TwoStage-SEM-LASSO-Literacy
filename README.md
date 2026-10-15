## Spatial Regression on Literacy Rate in South Sulawesi with Least Absolute Shrinkage and Selection Operator using Coordinate Descent Algorithm
This repository contains R code for modeling the **Spatial Error Model (SEM)** combined with **LASSO (Coordinate Descent)** and **LARS (Least Angle Regression)**. The analysis focuses on literacy data from South Sulawesi.

## 📦 Packages
Make sure the following R packages are installed:
- `readxl`
- `regclass`
- `spdep`
- `glmnet`
- `spatialreg`
- `lmtest`
- `lars`
- `corrplot`

## 📂 Input Files
- `Data.xlsx` → main dataset (variables X1–X12 and Y).
- `Weight Matrix.xlsx` → spatial weight matrix (sheet: `Road-NS`).

## 🚀 Instructions
1. **Load Data**
   - Import `Data.xlsx` and scale variables (excluding identifiers).
   - Define variable names (X1–X12).

2. **Descriptive Statistics & Correlation**
   - Run `summary(datates)` for descriptive statistics.
   - Use `corrplot` to visualize correlations among variables.

3. **OLS & Diagnostics**
   - Fit OLS model: `lm(Y ~ ., data = datates.scaled)`.
   - Check multicollinearity with `VIF()`.
   - Test heteroskedasticity with `bptest()`.

4. **Spatial Effect Testing**
   - Load `Weight Matrix.xlsx` (sheet: `Road-NS`).
   - Build adjacency matrix and listw object.
   - Run `moran.test()` and `lm.RStests()` to check spatial dependence.

5. **Modeling**
   - **Baseline SEM**: `errorsarlm(Y ~ ., data = datates.scaled, listw = nb)`.
   - **SEM-LASSO (Coordinate Descent)**:
     - Transform variables with spatial filter.
     - Run `cv.glmnet()` to select variables.
     - Fit SEM-LASSO model with selected variables.
   - **SEM-LARS**:
     - Run `lars()` to select variables.
     - Fit SEM-LARS model with selected variables.

6. **Model Evaluation**
   - Compare AIC & BIC across models (`AIC()`, `BIC()`).
   - Generate predictions with `predict()`.
   - Evaluate accuracy using RMSE and MAE.

## 📊 Outputs
- Selected variables (LASSO & LARS).
- Model summaries (coefficients, significance).
- Evaluation metrics: AIC, BIC, RMSE, MAE.
- Correlation plots.

-----------
## SEM-LASSO with Different Spatial Weight Matrices

This script demonstrates the application of **Spatial Error Model (SEM)** combined with **LASSO regression** under three different spatial weighting schemes: **Road Access Weight**, **Inverse Distance Weighting (IDW)**, and **Queen contiguity**.

## 📦 Dependencies
Required R packages:
- `readxl`
- `regclass`
- `spdep`
- `glmnet`
- `spatialreg`
- `lmtest`
- `lars`

## 📂 Input Files
- `Data.xlsx` → main dataset (variables X1–X12 and Y).
- `Weight Matrix.xlsx` → spatial weight matrices with sheets:
  - `Road-NS` → road access weight
  - `IDW` → inverse distance weighting
  - `Queen` → queen contiguity

## 🚀 Instructions
1. **Load Data**
   - Import `Data.xlsx` and scale variables (excluding identifiers).
   - Define variable names (X1–X12).

2. **Road Network SEM-LASSO**
   - Load `Weight Matrix.xlsx` (sheet: `Road-NS`).
   - Build adjacency matrix and listw object.
   - Fit baseline SEM (`errorsarlm`).
   - Transform variables with spatial filter.
   - Run LASSO (`cv.glmnet`) to select variables.
   - Fit SEM-LASSO model with selected variables.
   - Evaluate using AIC, BIC, RMSE, MAE.

3. **IDW SEM-LASSO**
   - Load `Weight Matrix.xlsx` (sheet: `IDW`).
   - Repeat the same modeling steps as above.
   - Compare selected variables and evaluation metrics.

4. **Queen SEM-LASSO**
   - Load `Weight Matrix.xlsx` (sheet: `Queen`).
   - Repeat the same modeling steps.
   - Compare results with Road and IDW weighting schemes.

## 📊 Outputs
- Selected variables for each weighting scheme.
- Model summaries (coefficients, significance).
- Evaluation metrics: AIC, BIC, RMSE, MAE.
- Comparative performance across Road, IDW, and Queen matrices.

## 📜 Notes
The raw dataset used in this study originates from the official Badan Pusat Statistik (BPS) South Sulawesi. Due to licensing and access restrictions, the dataset cannot be redistributed directly through this repository. Interested readers may request access to the data from BPS or download it independently via the official portal:

https://bps.go.id

We provide full instructions in the README on how to replicate the analysis once the dataset has been obtained. All scripts, weight matrices, and methodological details are included in this repository to ensure transparency and reproducibility.

---

This README section explains the **purpose, inputs, execution order, and outputs** of the script, making it reproducible and easy to follow.

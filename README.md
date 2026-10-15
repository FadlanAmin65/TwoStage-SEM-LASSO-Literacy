# Spatial Regression on Literacy Rate in South Sulawesi with Least Absolute Shrinkage and Selection Operator using Coordinate Descent Algorithm
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

## 📂 Repository Structure
- `Data.xlsx` → main dataset (variables X1–X12 and Y).
- `Data Spatial.xlsx` → spatial weight matrix (Road Access Matrix).

## 🚀 Step-by-Step Instructions
1. **Load Data**
   - Import `Data.xlsx` for the study variables.
   - Import `Data Spatial.xlsx` for the spatial matrix.

2. **Descriptive Statistics & Correlation**
   - Run `summary(datates)` for descriptive statistics.
   - Use `corrplot` to visualize correlations among variables.

3. **OLS & Diagnostics**
   - Fit OLS model: `lm(Y ~ ., data = datates.scaled)`.
   - Check multicollinearity with `VIF()`.
   - Test heteroskedasticity with `bptest()`.

4. **Spatial Effect Testing**
   - Build queen adjacency matrix with `mat2listw()`.
   - Run `moran.test()` and `lm.RStests()` to check spatial dependence.

5. **Modeling**
   - **Baseline SEM**: `errorsarlm(Y ~ ., data = datates.scaled, listw = nb)`.
   - **SEM-LASSO (Coordinate Descent)**: use `cv.glmnet()` to select variables, then fit SEM.
   - **SEM-LARS**: use `lars()` to select variables, then fit SEM.

6. **Model Evaluation**
   - Compare AIC & BIC across models (`AIC()`, `BIC()`).
   - Generate predictions with `predict()`.
   - Evaluate accuracy using RMSE and MAE.

## 📊 Outputs
- Selected variables (LASSO & LARS).
- Model statistics (AIC, BIC).
- Prediction accuracy (RMSE, MAE).
- Correlation plots.

## 📜 Dataset Notes
- Both `Data.xlsx` and `Data Spatial.xlsx` are required to run the code.
- If the dataset cannot be shared publicly (e.g., due to BPS licensing restrictions), please provide clear instructions on how readers can obtain it from the official source.

-----------
# SEM-LASSO with Different Spatial Weight Matrices

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
  - `Road-NS` → road network adjacency
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
- Ensure that `Data.xlsx` and `Weight Matrix.xlsx` are available in the specified directory.
- If datasets cannot be shared publicly, provide instructions for obtaining them from the official source (e.g., BPS South Sulawesi).
- The script is modular: each section (Road, IDW, Queen) can be run independently.

---

This README section explains the **purpose, inputs, execution order, and outputs** of the script, making it reproducible and easy to follow.

# Two-Stage SEM-LASSO & SEM-LARS for Literacy Analysis

This repository contains R scripts and spatial weight matrices used in the paper  
**"Spatial Regression on Literacy Rate in South Sulawesi with Least Absolute Shrinkage and Selection Operator using Coordinate Descent Algorithm"**.

## 📂 Repository Structure
- `weights/` → spatial weight matrices (`Weight Matrix.xlsx`, sheets: Road-NS, IDW, Queen)  
- `scripts/` → R scripts for each stage of analysis  
  - `Descriptive and Spatial Effect.R` → descriptive statistics, correlation, VIF, Moran’s I, LM tests  
  - `Syntax Modelling.R` → SEM baseline, SEM-LASSO (Coordinate Descent), SEM-LARS  
  - `Syntax Sensitivity Checks.R` → SEM-LASSO with different spatial weight matrices (Road, IDW, Queen)  
- `results/` → model outputs (AIC, BIC, RMSE, MAE)

---

## 🚀 Workflow Mapping to Paper

### Stage 1: Data Exploration & Diagnostics
**Paper Section:** *Descriptive statistics, correlation, multicollinearity, spatial effect tests*  
**Script:** `Descriptive and Spatial Effect.R`  
- Runs `summary()` for descriptive statistics.  
- Generates correlation heatmap (`corrplot`).  
- Tests multicollinearity with `VIF()`.  
- Tests heteroskedasticity with `bptest()`.  
- Moran’s I and LM tests for spatial autocorrelation.  

### Stage 2: Baseline & Penalized Models
**Paper Section:** *SEM baseline, SEM-LASSO (Coordinate Descent), SEM-LARS comparison*  
**Script:** `Syntax Modelling.R`  
- Fits baseline SEM (`errorsarlm`).  
- Applies SEM-LASSO with `cv.glmnet()` (Coordinate Descent).  
- Applies SEM-LARS with `lars()`.  
- Compares models using AIC, BIC, RMSE, MAE.  

### Stage 3: Alternative Spatial Weight Matrices
**Paper Section:** *Robustness check with Road, IDW, Queen matrices*  
**Script:** `Syntax Sensitivity Checks.R`  
- Loads different weight matrices from `Weight Matrix.xlsx`.  
- Fits SEM-LASSO for each matrix.  
- Compares variable selection and evaluation metrics across weighting schemes.  

---

## 📜 Dataset Availability
The raw dataset originates from **Badan Pusat Statistik (BPS) South Sulawesi**.  
Due to licensing restrictions, the dataset cannot be redistributed in this repository.  
Interested readers may request or download the dataset independently via the official portal:  
👉 [https://sulsel.bps.go.id](https://sulsel.bps.go.id)

---

## 📊 Outputs
- Selected variables (LASSO & LARS).  
- Model summaries (coefficients, significance).  
- Evaluation metrics: AIC, BIC, RMSE, MAE.  
- Correlation plots and diagnostic tests.  

---

With this structure, each script is explicitly linked to the corresponding methodological stage in the paper, ensuring transparency and reproducibility.

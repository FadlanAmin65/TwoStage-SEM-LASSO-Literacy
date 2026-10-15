
library(readxl)
library(regclass)
library(spdep)
library(glmnet)
library(spatialreg)
library(lmtest)
library(lars)

datates <- (read_excel("D:/S2/Tesis/Artikel/File/Data.xlsx"))
nama_variabel <- c("X1","X2","X3","X4",'X5','X6','X7','X8','X9','X10','X11','X12')
summary(datates)

datates.scaled <- as.data.frame(scale(datates[,-c(1:5)]))

# OLS
ols_tes <- lm(Y~., data = datates.scaled)

# Heterogeneity Test
bptest(ols_tes)

### Weight Matrix

mtqueen <- read_excel("D:/S2/Tesis/Artikel/File/Weight Matrix.xlsx", sheet = "Road-NS", range = "B3:Y27")
mtqueen <- as.matrix(mtqueen)
nb <- mat2listw(mtqueen, style = "W")

### Modelling
X <- as.matrix(datates.scaled[,-1])
y <- as.matrix(datates.scaled$Y)

#sar_gm <- predict.Sarlm(X26 ~ ., data = datates.scaled, listw = nb)
sem_gm <- errorsarlm(Y ~ ., data = datates.scaled, listw = nb)
summary(sem_gm)
lambda <- sem_gm$lambda

X_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%X
y_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%y

###

#LASSO-CD
set.seed(711)#15
model_lasso <- cv.glmnet(X_gm, y_gm, alpha = 1)
best_model <- model_lasso$lambda.1se
coef_lasso <- coef(model_lasso, s = best_model)
coef_lasso

pola_terbaik <- "101110110111" 

split_pola <- as.numeric(strsplit(pola_terbaik, "")[[1]])
vars_terpilih <- nama_variabel[split_pola == 1]
print("Variabel Pemenang:")
print(vars_terpilih)

formula_final <- as.formula(paste("Y ~", paste(vars_terpilih, collapse = "+")))
print(formula_final)
VIF(lm(formula_final, data = datates.scaled))

sem_lasso <- errorsarlm(formula = formula_final, data = datates.scaled, listw = nb)
summary(sem_lasso)

#LASSO-LARS
set.seed(711)
model_lars <- lars(X_gm, y_gm, type = "lar")
best_model <- which.min(model_lars$Cp)
coef_lars <- coef(model_lars, s = best_model)
coef_lars

pola_terbaik <- "101111110111"
split_pola <- as.numeric(strsplit(pola_terbaik, "")[[1]])
vars_terpilih <- nama_variabel[split_pola == 1]
print("Variabel Pemenang:")
print(vars_terpilih)

formula_final <- as.formula(paste("Y ~", paste(vars_terpilih, collapse = "+")))
print(formula_final)
VIF(lm(formula_final, data = datates.scaled))

sem_lars <- errorsarlm(formula_final, data = datates.scaled, listw = nb)
summary(sem_lars)


#Evaluasi
AIC(sem_lasso)
AIC(sem_lars)
AIC(sem_gm)
AIC(ols_tes)

BIC(sem_lasso)
BIC(sem_lars)
BIC(sem_gm)
BIC(ols_tes)

pred1 <- predict(sem_lasso, newdata = datates.scaled[,-c(1)], listw = nb)
pred2 <- predict(sem_lars, newdata = datates.scaled[,-c(1)], listw = nb)
pred3 <- predict(sem_gm, newdata = datates.scaled[,-c(1)], listw = nb)
pred4 <- predict(ols_tes, newdata = datates.scaled[,-c(1)])

# RMSE
rmse1 <- sqrt(mean((y - pred1)^2))
rmse2 <- sqrt(mean((y - pred2)^2))
rmse3 <- sqrt(mean((y - pred3)^2))
rmse4 <- sqrt(mean((y - pred4)^2))

# MAE
mae1 <- mean(abs(y - pred1))
mae2 <- mean(abs(y - pred2))
mae3 <- mean(abs(y - pred3))
mae4 <- mean(abs(y - pred4))

rmse1
rmse2
rmse3
rmse4

mae1
mae2
mae3
mae4


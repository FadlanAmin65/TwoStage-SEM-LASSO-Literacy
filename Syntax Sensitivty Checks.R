
library(readxl)
library(regclass)
library(spdep)
library(glmnet)
library(spatialreg)
library(lmtest)
library(lars)

datates <- (read_excel("D:/S2/Tesis/Artikel/File/Data.xlsx"))
datates.scaled <- as.data.frame(scale(datates[,-c(1:5)]))

nama_variabel <- c("X1","X2","X3","X4",'X5','X6','X7','X8','X9','X10','X11','X12')

##### Spatial Effect Road ######

mtqueen1 <- read_excel("D:/S2/Tesis/Artikel/File/Weight Matrix.xlsx", sheet = "Road-NS", range = "B3:Y27")
mtqueen <- as.matrix(mtqueen)
nb <- mat2listw(mtqueen, style = "W")

### Pemodelan

X <- as.matrix(datates.scaled[,-1])
y <- as.matrix(datates.scaled$Y)
sem_gm <- errorsarlm(Y ~ ., data = datates.scaled, listw = nb)
summary(sem_gm)
lambda <- sem_gm$lambda

X_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%X
y_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%y

set.seed(711)
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
AIC(sem_lasso)
BIC(sem_lasso)
pred1 <- predict(sem_lasso, newdata = datates.scaled[,-c(1)], listw = nb)
rmse1 <- sqrt(mean((y - pred1)^2))
mae1 <- mean(abs(y - pred1))
rmse1
mae1

##### IDW ######

mtqueen <- read_excel("D:/S2/Tesis/Artikel/File/Weight Matrix.xlsx", sheet = "IDW", range = "B3:Y27")
mtqueen <- as.matrix(mtqueen)
nb <- mat2listw(mtqueen, style = "W")

X <- as.matrix(datates.scaled[,-1])
y <- as.matrix(datates.scaled$Y)
sem_gm <- errorsarlm(Y ~ ., data = datates.scaled, listw = nb)
lambda <- sem_gm$lambda

X_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%X
y_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%y

set.seed(711)
model_lasso <- cv.glmnet(X_gm, y_gm, alpha = 1)
best_model <- model_lasso$lambda.1se
coef_lasso <- coef(model_lasso, s = best_model)
coef_lasso

pola_terbaik <- "000010000000" 

split_pola <- as.numeric(strsplit(pola_terbaik, "")[[1]])
vars_terpilih <- nama_variabel[split_pola == 1]
print("Variabel Pemenang:")
print(vars_terpilih)

formula_final <- as.formula(paste("Y ~", paste(vars_terpilih, collapse = "+")))
print(formula_final)
VIF(lm(formula_final, data = datates.scaled))

sem_lasso <- errorsarlm(formula = formula_final, data = datates.scaled, listw = nb)
summary(sem_lasso)
AIC(sem_lasso)
BIC(sem_lasso)
pred1 <- predict(sem_lasso, newdata = datates.scaled[,-c(1)], listw = nb)
rmse1 <- sqrt(mean((y - pred1)^2))
mae1 <- mean(abs(y - pred1))
rmse1
mae1

####### Queen ########

mtqueen <- read_excel("D:/S2/Tesis/Artikel/File/Weight Matrix.xlsx", sheet = "Queen", range = "B3:Y27")
mtqueen <- as.matrix(mtqueen)
nb <- mat2listw(mtqueen, style = "W")

X <- as.matrix(datates.scaled[,-1])
y <- as.matrix(datates.scaled$Y)

sem_gm <- errorsarlm(Y ~ ., data = datates.scaled, listw = nb)
lambda <- sem_gm$lambda

X_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%X
y_gm <- (diag(1,24)-(sem_gm$lambda*mtqueen))%*%y

set.seed(711)
model_lasso <- cv.glmnet(X_gm, y_gm, alpha = 1)
best_model <- model_lasso$lambda.1se
coef_lasso <- coef(model_lasso, s = best_model)
coef_lasso

pola_terbaik <- "101111110101"

split_pola <- as.numeric(strsplit(pola_terbaik, "")[[1]])
vars_terpilih <- nama_variabel[split_pola == 1]
print("Variabel Pemenang:")
print(vars_terpilih)

formula_final <- as.formula(paste("Y ~", paste(vars_terpilih, collapse = "+")))
print(formula_final)
VIF(lm(formula_final, data = datates.scaled))

sem_lasso <- errorsarlm(formula = formula_final, data = datates.scaled, listw = nb)
summary(sem_lasso)
AIC(sem_lasso)
BIC(sem_lasso)
pred1 <- predict(sem_lasso, newdata = datates.scaled[,-c(1)], listw = nb)
rmse1 <- sqrt(mean((y - pred1)^2))
mae1 <- mean(abs(y - pred1))
rmse1
mae1

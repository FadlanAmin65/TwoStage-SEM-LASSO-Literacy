
library(readxl)
library(regclass)
library(spdep)
library(glmnet)
library(spatialreg)
library(lmtest)
library(lars)

datates <- (read_excel("D:/S2/Tesis/Artikel/File/Data.xlsx"))
#View(datates)

nama_variabel <- c("X1","X2","X3","X4",'X5','X6','X7','X8','X9','X10','X11','X12')

### 1 Deskriptif
summary(datates)

### 3 Korelasi
corrplot::corrplot(cor(datates[,-c(1:5)]), method = "shade", type = "full",
                   outline = T, order = "FPC", insig = 'p-value', sig.level = -1)

### 4 VIF

datates.scaled <- as.data.frame(scale(datates[,-c(1:5)]))

ols_tes <- lm(Y~., data = datates.scaled)
summary(ols_tes)
VIF(ols_tes)

bptest(ols_tes)

### 5 Spatial Effect

mtqueen <- read_excel("D:/Tesis/Data Spatial.xlsx", sheet = "Sheet2_Std (3)", range = "B3:Y27")
mtqueen <- as.matrix(mtqueen)
mtqueen

nb <- mat2listw(mtqueen, style = "W")

moran.test(datates$Y, nb)
summary(lm.RStests(ols_tes, listw = nb, test = "all"))
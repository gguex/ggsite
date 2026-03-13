################################################### 
######## Regression multiple sur les notes ######## 
################################################### 

######## Chargement ######## 

# Chargement des données
data = read.csv("notes.csv")

# Récupération nombre de lignes, nombre de colonnes
n = dim(data)[1]
p = dim(data)[2]

######## Calcul ######## 

# Construction de X et de y
y = as.matrix(data$geographie)
X_s1 = as.matrix(data[,-2])
X = cbind(rep(1,n), X_s1)

# Calcul des coefficents de régression
b = solve( t(X) %*% X ) %*% t(X) %*% y

######## Regression avec lm ######## 

# Faire la régression avec tous les prédicteurs
solution_regression = lm(geographie~., data)

# Résumé
summary(solution_regression)

# Corrélations
cor(data)

######## Recherche de la meilleure regression ######## 

# Itération 1
reg_1 = lm(geographie~
             francais+
             physique+
             chimie+
             histoire+
             mathematiques+
             philosophie+
             allemand, data)
summary(reg_1)

# Itération 2 (- chimie)
reg_2 = lm(geographie~
             francais+
             physique+
             histoire+
             mathematiques+ 
             philosophie+
             allemand, data)
summary(reg_2)

# Itération 3 (- intercept)
reg_3 = lm(geographie~
             francais+
             physique+
             histoire+
             mathematiques+
             philosophie+
             allemand - 1, data)
summary(reg_3)

# Itération 4 (- physique)
reg_4 = lm(geographie~
             francais+
             histoire+
             mathematiques+
             philosophie+
             allemand - 1, data)
summary(reg_4)

# Itération 5 (- francais)
reg_5 = lm(geographie~
             histoire+
             mathematiques+
             philosophie+
             allemand - 1, data)
summary(reg_5)

# Itération 6 (- histoire)
reg_6 = lm(geographie~
             mathematiques+
             philosophie+
             allemand - 1, data)
summary(reg_6)

######## Tester les hypothèses de travail ######## 

# Diagramme des résidus
plot(reg_6$fitted.values, reg_6$residuals)

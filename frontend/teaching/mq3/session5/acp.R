################################################### 
################ 4 ACP Arrest #####################
################################################### 

library(tidyverse)
library(FactoMineR)
library(factoextra)

######## Dataset ######## 

df = read_csv("cantons.csv")
df = df %>% 
  column_to_rownames(var="nom")
view(df)

######## Faire l'ACP ######## 

ca = PCA(df, graph=F)

######## Les scores factoriels ######## 

view(ca$ind$coord)

fviz_pca_ind(ca)
ggsave("scores_factoriels.png", width=5, height=5)

######## Les saturations ######## 

view(ca$var$coord)

fviz_pca_var(ca)
ggsave("cercle_correlation.png", width=5, height=5)

######## Les saturations au carré ########

view(ca$var$cos2)

rowSums(ca$var$cos2) # Marge des lignes = 1

rowSums(ca$var$cos2[, 1:2]) # Communatlités

######## La variance expliquée ########

view(ca$eig)

fviz_screeplot(ca)
ggsave("scree_graph.png", width=5, height=5)

######## ACP sur la matrice de covariance ######## 

ca_cov = PCA(df, graph=F, scale.unit=F)

fviz_pca_ind(ca_cov)
fviz_pca_var(ca_cov)
fviz_screeplot(ca_cov)

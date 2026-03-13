################################################### 
################ 8 Exemples MDS ###################
################################################### 

library(tidyverse)
library(gridExtra)

##################################
# MDS uniforme : exemple hexagone
##################################

# Matrice des distances
D = matrix(c(0, 1, 3, 4, 3, 1, 1,
             1, 0, 1, 3, 4, 3, 1,
             3, 1, 0, 1, 3, 4, 1,
             4, 3, 1, 0, 1, 3, 1,
             3, 4, 3, 1, 0, 1, 1,
             1, 3, 4, 3, 1, 0, 1, 
             1, 1, 1, 1, 1, 1, 0), 7, 7)

# Calcul des produits scalaires
n = nrow(D)
H = diag(n) - matrix(1/n, n, n)
B = -0.5 * H %*% D %*% H

# Décomposition spectrale
eigen_B = eigen(B)
eigen_val = eigen_B$values
eigen_vec = eigen_B$vectors

# Reconstruction des coordonnées 1:2 seulement 
coord = eigen_vec[, 1:2] %*% diag(sqrt(eigen_val[1:2]))

# Plot des coordonnées
ggplot(data.frame(X = coord[,1], Y = coord[,2]), aes(x = X, y = Y)) +
  geom_point() +
  geom_text(aes(label = 1:7), hjust = 2) +
  xlab("Dimension 1") +
  ylab("Dimension 2") +
  ggtitle("Coordonnées par MDS de l'hexagone")
#ggsave("hexa_mds.png", width = 4, height = 4)

# Plot de l'inertie 
ggplot(data.frame(Index = 1:length(eigen_val), Eigenvalue = eigen_val/sum(eigen_val)), 
       aes(x = Index, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  xlab("Dimension") +
  ylab("Proportion d'inertie")
#ggsave("hexa_inertie.png", width = 4, height = 4)

##################################
# MDS uniforme : exemple villes UK
##################################

# Nom des villes
villes = c("Aberystwyth", "Brighton", "Carlisle", "Dover", "Exeter", 
           "Glasgow", "Hull", "Inverness", "Leeds", "London", 
           "Newcastle", "Norwich")

# Nombre d'individus
n = length(villes)

# Distance sur route
donnees = c(
  0, 244, 218, 284, 197, 312, 215, 469, 166, 212, 253, 270,
  244, 0, 350, 77, 167, 444, 221, 583, 242, 53, 325, 168,
  218, 350, 0, 369, 347, 94, 150, 251, 116, 298, 57, 284,
  284, 77, 369, 0, 242, 463, 236, 598, 257, 72, 340, 164,
  197, 167, 347, 242, 0, 441, 279, 598, 269, 170, 359, 277,
  312, 444, 94, 463, 441, 0, 245, 169, 210, 392, 143, 378,
  215, 221, 150, 236, 279, 245, 0, 380, 55, 168, 117, 143,
  469, 583, 251, 598, 598, 169, 380, 0, 349, 531, 264, 514,
  166, 242, 116, 257, 269, 210, 55, 349, 0, 190, 91, 173,
  212, 53, 298, 72, 170, 392, 168, 531, 190, 0, 273, 111,
  253, 325, 57, 340, 359, 143, 117, 264, 91, 273, 0, 256,
  270, 168, 284, 164, 277, 378, 143, 514, 173, 111, 256, 0
)

# Création de la matrice
D = matrix(donnees, nrow = n, byrow = TRUE,
           dimnames = list(villes, villes))

# Calcul des produits scalaires
H = diag(n) - matrix(1/n, n, n)
B = -0.5 * H %*% (D^2) %*% H

# Décomposition spectrale
eigen_B = eigen(B)
eigen_val = eigen_B$values
eigen_vec = eigen_B$vectors

# Affichage que ce n'est pas euclidien carré 
print(round(eigen_val, 4))

# Suppression des valeurs propres négatives
eigen_val[eigen_val < 0] = 0

# Nombre de coordonnées non-nulles
k = sum(eigen_val > 0)

# Reconstruction des coordonnées (1 à k seulement)
coord = eigen_vec[, 1:k] %*% diag(sqrt(eigen_val[1:k]))

# Plot des coordonnées
ggplot(data.frame(X = coord[,1], Y = coord[,2], Ville = villes), aes(x = X, y = Y)) +
  geom_point() +
  geom_text(aes(label = Ville), hjust = 1.1) +
  xlab("Dimension 1") +
  ylab("Dimension 2") +
  ggtitle("Coordonnées par MDS des villes UK")
#ggsave("uk_villes_mds.png", width = 5, height = 5)

# Plot de l'inertie
ggplot(data.frame(Index = 1:length(eigen_val), Eigenvalue = eigen_val/sum(eigen_val)), 
       aes(x = Index, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  xlab("Dimension") +
  ylab("Proportion d'inertie")
#ggsave("uk_villes_inertie.png", width = 4, height = 4)


##################################
# MDS pondéré : exemple villes AUS
##################################

# Nom des villes
villes = c("Adelaide", "Alice Springs", "Brisbane", "Darwin", "Hobart", 
           "Melbourne", "Perth", "Sydney")

# Nombre d'individus
n = length(villes)

# Poids des villes (population en millions)
pop = c(1.30, 0.03, 2.57, 0.15, 0.25, 5.39, 2.17, 5.25)

# Poids relatif 
f = pop / sum(pop)

# Distance sur route
donnees = c(
  0, 1328, 1600, 2616, 1161, 653, 2130, 1161,
  1328, 0, 1962, 1289, 2463, 1889, 1991, 2026,
  1600, 1962, 0, 2846, 1788, 1374, 3604, 732,
  2616, 1289, 2846, 0, 3734, 3146, 2652, 3146,
  1161, 2463, 1788, 3734, 0, 598, 3008, 1057,
  653, 1889, 1374, 3146, 598, 0, 2720, 713,
  2130, 1991, 3604, 2652, 3008, 2720, 0, 3288,
  1161, 2026, 732, 3146, 1057, 713, 3288, 0
)

# Création de la matrice des distances 
D = matrix(donnees, nrow = n, byrow = TRUE,
           dimnames = list(villes, villes))

# Calcul des produits scalaires
H = diag(n) - outer(rep(1, n), f)
B = -0.5 * H %*% (D^2) %*% t(H)

# Calcul des produits scalaires pondérées
K = diag(f)^0.5 %*% B %*% diag(f)^0.5

# Décomposition spectrale
eigen_K = eigen(K)
eigen_val = eigen_K$values
eigen_vec = eigen_K$vectors

# Affichage que ce n'est pas euclidien carré 
print(round(eigen_val, 4))

# Suppression des valeurs propres négatives
eigen_val[eigen_val < 0] = 0

# Nombre de coordonnées non-nulles
k = sum(eigen_val > 0)

# Reconstruction des coordonnées (1 à k seulement)
coord = diag(f^(-0.5)) %*% eigen_vec[, 1:k] %*% diag(sqrt(eigen_val[1:k]))

# Plot des coordonnées
ggplot(data.frame(X = coord[,1], Y = coord[,2], Ville = villes), aes(x = X, y = Y)) +
  geom_point() +
  geom_text(aes(label = Ville), hjust = 1.1) +
  xlab("Dimension 1") +
  ylab("Dimension 2") +
  ggtitle("Coordonnées par MDS pondéré des villes AUS")
#ggsave("uk_villes_mds.png", width = 5, height = 5)

# Plot de l'inertie
ggplot(data.frame(Index = 1:length(eigen_val), Eigenvalue = eigen_val/sum(eigen_val)), 
       aes(x = Index, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  xlab("Dimension") +
  ylab("Proportion d'inertie")
#ggsave("uk_villes_inertie.png", width = 4, height = 4)

#####################################
# MDS sur une grille avec plusieurs D
#####################################

# Génération des données 

# Taille de la grille
l = 10
n = l^2

# Les coordonnées de la grille
x = rep(1:l,l)
y = rep(1:l,each=l)
X=cbind(x,y)

# La couleur des points 
col = rgb((x + y)/(l+l),0,1-(x + y)/(l+l))

# Aperçu de la grille
ggplot() +
  geom_point(aes(x = X[,1], y = X[,2]), color = col, size = 4) +
  ggtitle("Grille initiale") +
  xlab(NULL) +
  ylab(NULL) +
  theme_minimal()
ggsave("g_init.png", width = 4, height = 4)


# Calculs de différentes dissimilarités
D_2 = as.matrix(dist(X,method="euclidean"))
D_1 = as.matrix(dist(X,method="manhattan"))
D_inf = as.matrix(dist(X,method="maximum"))
D_m15 = as.matrix(dist(X,method="minkowski", p=1.5))
D_m4 = as.matrix(dist(X,method="minkowski", p=4))

# Matrice de centration
H = diag(n) - 1/n * matrix(1,n,n)

# Matrices des produits scalaires
B_2 = -1/2 * H %*% D_2^2 %*% H
B_1 = -1/2 * H %*% D_1^2 %*% H
B_inf = -1/2 * H %*% D_inf^2 %*% H
B_m15 = -1/2 * H %*% D_m15^2 %*% H
B_m4 = -1/2 * H %*% D_m4^2 %*% H

# Décomposition spectrale
eigen_B2 = eigen(B_2)
eigen_B1 = eigen(B_1)
eigen_Binf = eigen(B_inf)
eigen_Bm15 = eigen(B_m15)
eigen_Bm4 = eigen(B_m4)

# Reconstruction des coordonnées
X_2 = eigen_B2$vectors[, 1:2] %*% diag(sqrt(eigen_B2$values[1:2]))
X_1 = eigen_B1$vectors[, 1:2] %*% diag(sqrt(eigen_B1$values[1:2]))
X_inf = eigen_Binf$vectors[, 1:2] %*% diag(sqrt(eigen_Binf$values[1:2]))
X_m15 = eigen_Bm15$vectors[, 1:2] %*% diag(sqrt(eigen_Bm15$values[1:2]))
X_m4 = eigen_Bm4$vectors[, 1:2] %*% diag(sqrt(eigen_Bm4$values[1:2]))

# Graphiques des résultats
plot_list = list(
  ggplot() +
    geom_point(aes(x = X[,1], y = X[,2]), color = col, size = 4) +
    ggtitle("Grille initiale") +
    xlab(NULL) +
    ylab(NULL) +
    theme_minimal(),
  ggplot() +
    geom_point(aes(x = X_2[,1], y = X_2[,2]), color = col, size = 4) +
    ggtitle("MDS L_2") +
    xlab(NULL) +
    ylab(NULL) +
    theme_minimal(),
  ggplot() +
    geom_point(aes(x = X_1[,1], y = X_1[,2]), color = col, size = 4) +
    ggtitle("MDS L_1") +
    xlab(NULL) +
    ylab(NULL) +
    theme_minimal(),
  ggplot() +
    geom_point(aes(x = X_inf[,1], y = X_inf[,2]), color = col, size = 4) +
    ggtitle("MDS L_inf") +
    xlab(NULL) +
    ylab(NULL) +
    theme_minimal(),
  ggplot() +
    geom_point(aes(x = X_m15[,1], y = X_m15[,2]), color = col, size = 4) +
    ggtitle("MDS L_1.5") +
    xlab(NULL) +
    ylab(NULL) +
    theme_minimal(),
  ggplot() +
    geom_point(aes(x = X_m4[,1], y = X_m4[,2]), color = col, size = 4) +
    ggtitle("MDS L_4") +
    xlab(NULL) +
    ylab(NULL) +
    theme_minimal()
)

# Plot des graphiques
grid.arrange(grobs = plot_list, ncol = 3)

# Sauvegarde des graphiques
# for (i in 1:length(plot_list)) {
#  ggsave(paste0("g_mds_", i, ".png"), plot = plot_list[[i]], width = 4, height = 4)
# }


#####################################
# MDS sur une table de contingence
#####################################

# Nom des lignes 
cat_ligne = c("Hom-30", "Hom-55", "Hom+55", "Fem-30", "Fem-55", "Fem+55")
# Nom des colonnes
cat_col = c("argent", "courage", "dormir", "livre", "maman", "manger", "pardon",
            "peinture", "plaisir", "politesse", "repas", "soleil")

# Dimensions
n = length(cat_ligne)
p = length(cat_col)

# Données 
donnees = c(
  11, 15, 6, 14, 9, 3, 
  2, 3, 11, 1, 3, 4, 
  8, 3, 1, 6, 2, 0,
  2, 7, 1, 9, 11, 11, 
  0, 3, 0, 12, 11, 3,
  9, 5, 1, 10, 3, 1,
  1, 2, 6, 0, 5, 5,
  0, 0, 1, 2, 7, 3, 
  10, 6, 2, 11, 2, 1, 
  0, 1, 5, 0, 4, 8, 
  3, 5, 4, 0, 3, 1, 
  26, 32, 23, 54, 56, 42
)

# Table de contingence
cont = matrix(donnees, nrow = n, ncol = p, 
              dimnames = list(cat_ligne, cat_col))

# poids des lignes et colonnes
f = rowSums(cont) / sum(cont)
rho = colSums(cont) / sum(cont)

# Table d'indépendance et des quotients
cont_indep = outer(rowSums(cont), colSums(cont)) / sum(cont)
quotients = cont / cont_indep

# ---- LIGNES ----

# Calculs des distances chi2 entre lignes
Dl_chi2 = matrix(0, n, n)
for (i in 1:n) {
  for (j in 1:n) {
    Dl_chi2[i, j] = sum(rho * (quotients[i, ] - quotients[j, ])^2)
  }
}  

# Calcul des produits scalaires
H = diag(n) - outer(rep(1, n), f)
B = -0.5 * H %*% (Dl_chi2^2) %*% t(H)

# Calcul des produits scalaires pondérées
K = diag(f)^0.5 %*% B %*% diag(f)^0.5

# Décomposition spectrale
eigen_K = eigen(K)
eigen_val = eigen_K$values
eigen_vec = eigen_K$vectors

# Sauvegarde de la dim max
k = sum(eigen_val > 0)

# Construction des coordonnées (1 à k seulement)
coord = diag(f^(-0.5)) %*% eigen_vec[, 1:k] %*% diag(sqrt(eigen_val[1:k]))

# Affichage des coordonnées
ggplot(data.frame(X = coord[,1], Y = coord[,2], Ligne = cat_ligne), aes(x = X, y = Y)) +
  geom_text(aes(label = Ligne), col="blue") +
  xlab("Dimension 1") +
  ylab("Dimension 2") +
  ggtitle("Coordonnées par MDS pondérée des lignes de la table de contingence")
#ggsave("cont_lignes_mds.png", width = 7, height = 7)

# ---- COLONNES ----

# Calculs des distances chi2 entre colonne
Dc_chi2 = matrix(0, p, p)
for (a in 1:p) {
  for (b in 1:p) {
    Dc_chi2[a, b] = sum(f * (quotients[, a] - quotients[, b])^2)
  }
}

# Calcul des produits scalaires
H = diag(p) - outer(rep(1, p), rho)
B = -0.5 * H %*% (Dc_chi2^2) %*% t(H)

# Calcul des produits scalaires pondérées
K = diag(rho)^0.5 %*% B %*% diag(rho)^0.5

# Décomposition spectrale
eigen_K = eigen(K)
eigen_val = eigen_K$values
eigen_vec = eigen_K$vectors

# Sauvegarde de la dim max
k = sum(eigen_val > 0)

# Construction des coordonnées (1 à k seulement)
coord = diag(rho^(-0.5)) %*% eigen_vec[, 1:k] %*% diag(sqrt(eigen_val[1:k]))

# Affichage des coordonnées
ggplot(data.frame(X = coord[,1], Y = coord[,2], Colonne = cat_col), aes(x = X, y = Y)) +
  geom_text(aes(label = Colonne), col="red") +
  xlab("Dimension 1") +
  ylab("Dimension 2") +
  ggtitle("Coordonnées par MDS pondérée des colonnes de la table de contingence")
#ggsave("cont_colonnes_mds.png", width = 7, height = 7)

##install.packages("ggplot2")
##install.packages("dplyr")

library(ggplot2)
library(dplyr)

data("airquality")
head(airquality)


ggplot(airquality, aes(x = Temp, y = Ozone)) + # Création du graphique de l'ozone en fonction de la température
  geom_point(color = "blue", size=6, shape=8) + # Nuage de point de la quantité d'ozone en focntion de la température avec forme, taille et couleur particulière
  labs(title = "Relation entre Ozone et Température",
       x = "Température (°F)",
       y = "Ozone (ppb)") + # Ecriture des titres
  theme(
    plot.background = element_rect(fill="yellow"),
    panel.background = element_rect(fill="pink")) #Ajout de couleurs de fonds

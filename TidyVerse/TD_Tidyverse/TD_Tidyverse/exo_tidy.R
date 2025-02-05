############################################################################
############################################################################
###################  ANALYSES - INDICATEURS  ###############################
############################################################################
############################################################################

## Date : 05/02/2025
## Auteur : Juliette GOUDAERT

##########################################################################
########################### Fonction utiles ##############################
##########################################################################

library(tidyverse)
library(readxl)

#%>% 
#|> 
#read_excel()
#select() avec start_with() par exemple
#filter()
#mutate()
#fct_recode()
#group_by_()
#summarise()
#left_join() right_join() inner_join() full_join()
#pivot_longer() pivot_wider()
# ...


##########################################################################
########################### Import #######################################
##########################################################################

Sites <- read_excel("data/Sites.xlsx") # Récupration des données de sites
Microorga <- read_excel("data/Microorganismes.xlsx") #Idem pour les micro-organismes
Nematodes <- read_excel("data/Nematodes.xlsx")# Idem pour les Nématodes
Vers <- read_excel("data/Lombrics.xlsx") #Idem pour les lombrics

##########################################################################
######################### Jointure de tables #############################
##########################################################################
########### CONSIGNE : Choisir deux communauté biologique ###########
# Associer sites et 2 communautés

# Jointure interne pour regrouper dans un même tableau les données des sites, des nématodes et des micro-organismes
Sites %>% 
  inner_join(.,Microorga, join_by(ID)) %>% 
  inner_join(.,Nematodes, join_by(ID)) -> SiteMN

# Attention, se contenter de mettre 2 tableau cote a cote ne suffit pas car on est pas sure que les tableaux sont de la meme taille et correspondent
# Pour faire correctement, on va utiliser des jointures : left/right/inner/full join


##########################################################################
################## Sélection de lignes et colonnes ##################
##########################################################################
########### CONSIGNE : Choisir un site ###########

#Choix du site : Gotheron
SiteMN %>% 
  filter(SITE=="Gotheron") -> GotMN

#EXEMPLE : Selection de colonnes qui nous interresse
GotMN %>% select(ID:SITE, 
                 BACT, 
                 BIOMASSE, 
                 contains("SABLE"), 
                 ends_with("MIN"), 
                 PHYTO:CARNI) -> exemple

#Selection de colonnes qui nous interresse
GotMN %>% select(ID:SITE,
                 MODE_DE_CONDUITE, 
                 PHYTO:CARNI, 
                 BIOMASSE, 
                 ) -> GotMNBiom

##########################################################################
####################### Créer des variables ##################
##########################################################################

#Création d'une variable permettant de calculer la biomasse totale de tous les nématodes confondus
GotMNBiom <- GotMNBiom %>% 
  mutate(NemTot = PHYTO+BACT+FONG+OMNI+CARNI)

##########################################################################
############################## Calculs par groupe ########################
##########################################################################
########### CONSIGNE : calculs sur plusieurs variables en même temps######

#On calcul ici la moyenne de biomasse de micro-organisme et celle des nématodes (total) par mode de conduite
GotMNBiomGroup <- GotMNBiom %>% 
  group_by(ID) %>%
  summarise(MODE_DE_CONDUITE, mean(BIOMASSE), mean(NemTot) )

##########################################################################
####################### Graphique ########################
##########################################################################
########### CONSIGNE : un graphique en modifiant l'ordre et en recodant des modalités

##########################################################################
######################## Pivots ##########################################
##########################################################################

#Je retire les colonnes détaillant la biomasse de chaque type de nématodes et la colonne SITE qui ne sert a rien
#J'effectue ensuite un pivot en longueur pour passer les paramètres biomasse et nématodes sous une seule colonne en supposant que l'unité de la biomasse est identique chez les micro-organismes et les nématodes

GotLong <- GotMNBiom %>%
  select(- c(PHYTO, BACT, FONG, OMNI, CARNI, SITE))%>%
  pivot_longer(
    cols = c(BIOMASSE, NemTot), 
    names_to = "Variable",  
    values_to = "Valeur"
  )

##########################################################################
####################### Enchaîner tous les traitements ###################
##########################################################################


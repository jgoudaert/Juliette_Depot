library(shiny)

#Modification de la police du titre
fluidPage(
  tags$style(HTML("
        #monTitre {
            font-family: 'Bauhaus 93';
            font-size: 60px;
            color: black ;
            font-weight: bold;
            text-align: center;
        }
    ")),
  tags$style(HTML("
        #Histoire {
            font-family: 'Roboto';
            font-size: 25px;
            color: hotpink ;
            font-weight: 600 ;
            text-align: center;
        }
    ")),
 
  tags$style(HTML("
        #Cinema {
            font-family: 'Roboto';
            font-size: 25px;
            color: darkblue ;
            font-weight: 600 ;
            text-align: center;
        }
    ")),
  
  tags$style(HTML("
        #Sciences {
            font-family: 'Roboto';
            font-size: 25px;
            color: green ;
            font-weight: 600 ;
            text-align: center;
        }
    ")),
  
  tags$style(HTML("
        #Geo {
            font-family: 'Roboto';
            font-size: 25px;
            color: orange ;
            font-weight: 600 ;
            text-align: center;
        }
    ")),
  
    # Titre de l'application en utilisant la police précédemment choisie
    titlePanel(tags$div("Quiz Culture Générale", id = "monTitre")),

    # Séparation de l'application en différents onglets thématiques
    tabsetPanel(
      tabPanel(
        tags$div("Histoire", id = "Histoire"), 
        h3(tags$div("En quelle année la Révolution française a-t-elle commencé ?", id = "Histoire")),
        radioButtons("Rep_Histoire", label = NULL, choices = c("1776", "1789", "1815", "1848"))
      ),
      tabPanel(
        tags$div("Cinéma", id = "Cinema"), 
        h3(tags$div("Dans quel film trouve-t-on la réplique 'Je suis ton père' ?", id = "Cinema")), 
            checkboxGroupInput("Rep_Cinema", label = NULL, choices = c("Matrix", "Star Wars", "Le Seigneur des Anneaux", "Harry Potter" ))
          ),
      tabPanel(tags$div("Sciences", id = "Sciences"), h3(tags$div("Quelle planète est surnommée la 'planète rouge' ?", id = "Sciences"))
      ),
      tabPanel(tags$div("Géographie", id = "Geo"), h3(tags$div("Quelle est la capitale du Canada ?", id = "Geo"))
      )
    
    )
  
   
)

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#these library files are moved in global.R file
#library(tidyverse)
#library(shiny)
#library(bslib)

# Load Andau loupe data
#commented out, now using Google Drive (in global.R file)
#andau_data <- readxl::read_excel("andau_loupe_data.xlsx")

# Load dental data
#commented out, now using Google Drive (in global.R file)
#dental_data <- readxl::read_excel("Dental_data.xlsx")%>%
#  filter(`Laser Mfg` != "") %>%
#  mutate(VLT = scales::percent(as.numeric(VLT)))
  

# theming options
andau_theme <- bs_theme(version = 5,
                        base_font  = font_google("Open Sans"),
                        bg = "white",
                        fg = "#1f0900",
                        primary = "#AE132A")
# Define application UI
shinyUI(page_fluid(
  titlePanel( 
    windowTitle = "Admetec",
    title =  tags$head(tags$link(rel = "shortcut icon", href = "favicon.ico"))),
    theme = andau_theme,
                   
  fluidRow(
    column(
      4,
      align = 'center',
      selectInput(
        inputId = "loupestyle",
        label = h4(strong("Loupe Frame")),
        choices = sort(andau_data$`Andau Frame`),
        selected = NULL
      )
    ),
    column(
      4,
      align = 'center',
      selectInput(
        inputId = "mfg",
        label = h4(strong("Manufacturer")),
        choices = sort(dental_data$`Laser Mfg`),
        selected = NULL
      )
    ),
    
    column(
      4,
      align = 'center',
      selectInput(
        inputId = "mod",
        label = h4(strong("Model")),
        choices = dental_data$`Laser Model`,
        selected = NULL
      )
    )),
  
  fluidRow(
    
    column(
      12,
      align = "center",
      br(),
      
      actionButton(
        inputId = "run",
        label = tagList(
          icon("magnifying-glass"),
          span(strong("Search"), style = "font-size: 16px; margin-left: 5px;")
        ),
        style = 'padding-left:30px;padding-right:30px;padding-top:1px;padding-bottom:1px;',
        class = "btn-primary"
      )      
      
      
 #     actionButton("run",
#                   icon = icon("magnifying-glass"),
#                   style='padding-left:50px;padding-right:50px;padding-top:1px;padding-bottom:1px; font-size:80%',
#                   h5(strong("Search")),
#                   class = "btn-primary")
      
      
      
      )
  ),
  
  
  
  br(),
  #fluidRow(
  #  column(12,
  #         p("Your information not available in the dropdowns? Contact Innovative Optics at (763) 425-7789"))
  #),
                       conditionalPanel(
                         condition = "input.run",
                         card(class="shadow p-3 mb-5 bg-body rounded",
                           fluidRow(column(12, align = "center",
                                         h3(em("Device Information")),
                                         tableOutput("userInfo"))),
                         fluidRow(column(12,
                                         align = "center", 
                                         h3(em("Compatible Innovative Optics Product")),
                                         tableOutput("tableInfo"))),
                         fluidRow(column(12, align = 'center',
                                         imageOutput("productImage")))),
                         card(class="shadow p-3 mb-5 bg-body rounded",
                              fluidRow(column(12,
                                  align = 'center',
                                  h4(strong("Frequently Purchased Together")))),
                           fluidRow(
                           column(4, align = 'center',
                             imageOutput("rec1"),
                           tableOutput("tableRec1")),
                           column(4, align = 'center',
                                  imageOutput("rec2"),
                                  tableOutput("tableRec2")),
                           column(4, align = 'center',
                                  imageOutput("rec3"),
                                  tableOutput("tableRec3")))
                         ))#,
                      # card(class="shadow p-3 mb-5 bg-body rounded",
                      #   card_footer(h5(
                      #   style = {
                      #     "color: #0FE410;
                      #   text-shadow: 1px 1px 1px black;"
                      #   },
                      #   "Powered by Innovative Optics"))
                      #   )
  )
                   )


  # sidebarLayout(
  # sidebarPanel(
  #   width = 4,
  #   selectInput(
  #     inputId = "loupestyle",
  #     label = "First, select your style of Andau loupes!",
  #     choices = andau_data$`Andau Frame`,
  #     selected = NULL
  #   ),
  #   selectInput(
  #     inputId = "mfg",
  #     label = "Next, select your laser's manufacturer!",
  #     choices = dental_data$`Laser Mfg`,
  #     selected = NULL
  #   ),
  #   selectInput(
  #     inputId = "mod",
  #     label = "Finally, select your laser model!",
  #     choices = dental_data$`Laser Model`,
  #     selected = NULL
  #   )
  # ),
  # mainPanel(width = 8,
  #           tableOutput("tableInfo"))





# Define UI for application that suggest eyewear based on loupe type and laser type
# shinyUI(fluidPage(
#     # Application title
#     h3("Welcome to the interactive dashboard"),
#     h4("Where you can easily find which inserts fit your loupes and which lens protects against your laser!"),
#     hr(),
#     sidebarLayout(sidebarPanel(
#     selectInput("frame",
#                        "First, select the style of loupes!",
#                        choices = andau_data$`Andau Frame`,
#                        selected = NULL),
#     h5("Next, select if you want to search by laser Category /n or by using our Dental or Medical laser lists!"),
#     tabsetPanel(
#       id = "profession",
#       type = "pills",
#       tabPanel("Category",
#         h5("Finally, select your laser category!"),       
#         selectInput("category",
#                     "Laser Category",
#                     choices = category_list,
#                     selected = NULL)),
#       tabPanel("Dental", 
#                h5("Finally, select your laser manufacturer and model!"),
#                selectInput("dentman",
#                            "Dental laser manufacturer",
#                            choices = dental_data$`Laser Mfg`,
#                            selected = NULL),
#                selectInput("dentmod",
#                            "Dental laser model",
#                            choices = dental_data$`Laser Model`,
#                            selected = NULL)),
#       tabPanel("Medical", 
#                h5("Finally, select your laser manufacturer and model!"),
#                                selectInput("medman",
#                                            "Medical laser manufacturer",
#                                            choices = medical_data$`Laser Mfg`,
#                                            selected = NULL),
#                                selectInput("medmod",
#                                            "Medical laser model",
#                                            choices = medical_data$`Laser Model`,
#                                            selected = NULL))
#                         )
#     ),
#     mainPanel(tableOutput("suglensCategory"),
#               tableOutput("sugdent"),
#               tableOutput("sugmed"),
#               imageOutput("Loupe"))
#     )
#   )
#)


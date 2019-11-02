library("shiny")
library("readxl")
library("cld2")
library("data.table")
library("DT")
library("here")

options(shiny.maxRequestSize = -1)
source("R/run.data.R")
tabPanel.about <- source("R/about.R")$value
tabPanel.macro <- source("R/Macro.R")$value
ui = fluidPage(
      titlePanel("xlsx to txt"),
      sidebarLayout(
        sidebarPanel(
          helpText("This app was designed specificly to reformat a 1 or 2-column xlsx file of ZH and EN into two txt files (seperated by semicolon)."),
          helpText("Either ZH and EN in two seperate columns (autodetected), or all in one column: one row of EN and one row of ZH."),
          h3(strong("Upload xlsx file")),
          fileInput('file_input', label = "",  accept = c(".xlsx")),
          br(), br(),
          # Allow action after upload xlsx file
          uiOutput("show_buttom"),
          br(), br(),
          
          # after click run, optional to download
          conditionalPanel("input.click_run",
            p(strong("Download Results")),                           
            downloadButton("click_downloadEN", "Download EN txt"),
            br(),
            downloadButton("click_downloadZH", "Download ZH txt"),
            br(),
            br(),br(),
            p(strong("Remember to change directory in the Macro")),
            downloadButton("click_downloadMacro", "Download Macro Code")
          )
        ),
        mainPanel(
          tabsetPanel(
            # The "Data" panel
            tabPanel("Data",
              h3(strong("Preview xlsx file")),
              DT::dataTableOutput('contents'),
              br(), br(),
              h4("Preview part of the txt files"),
              DT::dataTableOutput('table1'),
              
              br(), 
              DT::dataTableOutput('table2')),
            
 
            # The "About" panel
            tabPanel.about()
          )
        )
      )
      
    )
    
    
 server = function(input, output){
      output$show_buttom <- renderUI({
        if (is.null(input$file_input)) return()
        actionButton("click_run",  "Produce files")
        
      })
      
      
      reactive.run <- eventReactive(input$click_run, {
        req(input$file_input)
        inFile <- input$file_input
        showModal(modalDialog("Producing txt files", footer=NULL))
        
        d1 <- read_excel(inFile$datapath, sheet = 1, col_names = FALSE, col_types = "text")
        d2 <- prepare.data(d1)
        invisible(sapply(names(d2), write.to.txt, data = d2))
        removeModal()
        
        message("Two txt files have been created.")
        # read in local files
        # for preview
        invisible(sapply(names(d2), write.to.txt, data = d2[1:5,], filename = "Sample"))
        file_EN <- readLines(here::here("SampleEN.txt"))
        file_ZH <- readLines(here::here("SampleZH.txt"), encoding = "UTF-8")
        removeModal()
        return(list("file_EN" = file_EN, "file_ZH" = file_ZH, "d2" = d2))
      })
      # outputOptions(output, "table1", suspendWhenHidden = FALSE)
      
      
      output$contents <- DT::renderDataTable({
        req(input$file_input)
        inFile <- input$file_input
        dt <- read_excel(inFile$datapath, sheet = 1, col_names = FALSE, col_types = "text")
        dt[1:100,]
      })
      
      output$table1 <- DT::renderDataTable({
        t1 = head(reactive.run()$file_EN)
        data.table("EN" = t1)
      })
      
      output$table2 <- DT::renderDataTable({
        t2 = head(reactive.run()$file_ZH)
        data.table("ZH" = t2)
      })
      
      output$click_downloadEN <- downloadHandler(
        filename <- function() {
          "Index_EN.txt"
        },
        content <- function(file) {
          file.copy("Index_EN.txt", file)
          # d2 <- reactive.run()$d2
          # string0 <- paste(d2[["en"]], collapse = ";")
          # writeLines(string0, file, useBytes = TRUE)
        },
        contentType = "text"
      )
      
      output$click_downloadZH <- downloadHandler(
        filename <- function() {
          "Index_ZH.txt"
        },
        content <- function(file) {
          file.copy("Index_ZH.txt", file)
        }
      )
      
      output$click_downloadMacro <- downloadHandler(
        filename <- function(){"Macro_Code.txt"},
        content <- function(file) {
          file.copy("Macro code.txt", file)
        }
        
      )
}

 # Run App ---------------------------------------------------------------------
 shinyApp(ui, server)
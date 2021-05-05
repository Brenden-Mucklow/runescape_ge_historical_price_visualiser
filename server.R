#================================================================

server <- function(input, output, session) {
    
    get_historical_ge_data = function(item)
      {
        endpoint = gsub(" ", "_", item)
      
        endpoint0 = paste("exchange/history/rs/all?name=", endpoint, sep = "")
      
        url = modify_url("https://api.weirdgloop.org/", path = endpoint0)
      
        response = GET(url)
      
        if ( http_error(response) ){
          print(status_code(response))
          stop("Something went wrong.", call. = FALSE)
        }
      
        json_text = content(response,"text")
        item_data_from_json = fromJSON(json_text)
        item_data = item_data_from_json[[1]]
        item_data = item_data[,!(names(item_data) == "volume")]
        item_data$timestamp = as.Date(anytime(item_data$timestamp/1000))
        item_data
      }
    
    item_price_data = reactive({
      filter(get_historical_ge_data(input$item_name), between(timestamp, input$date_range[1], input$date_range[2]))
      })
    
    output$ge_item_plot = renderPlot({
      tryCatch(
        {ggplot(item_price_data(), aes(x = timestamp, y = price)) +
        geom_line(color = "blue")},
        error =  function(e) {""}
      )
    })
    
}

#================================================================
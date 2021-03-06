library(httr)
library(anytime)
library(tidyr)

get_historical_ge_data = function(item_name)
{
  endpoint = paste("exchange/history/rs/all?name=", item_name, sep = "")
  
  url = modify_url("https://api.weirdgloop.org/", path = endpoint)
  
  response = GET(url)
  
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  
  json_text = content(response,"text")
  item_data_from_json = jsonlite::fromJSON(json_text)
  item_data = item_data_from_json[[1]]
  item_data = item_data[,!(names(item_data) == "volume")]
  item_data$timestamp = as.Date(anytime(item_data$timestamp/1000))
  item_data
}

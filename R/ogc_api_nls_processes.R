library(httr2)

# example from https://www.maanmittauslaitos.fi/paikkatiedon-tiedostopalvelu/tekninen-kuvaus
# implemented in R & httr2

# Define the URL
url <- "https://avoin-paikkatieto.maanmittauslaitos.fi/tiedostopalvelu/ogcproc/v1/processes/maastokartta_rasteri_karttalehti/execution"

# api key
api_key = Sys.getenv("MML_API_KEY")

url <- paste0(url,
  "?api-key=", api_key
)

# Define the payload
payload <- list(
  id = "maastokartta_rasteri_karttalehti",
  inputs = list(
    fileFormatInput = "PNG",
    dataSetInput = "maastokartta_rasteri_10k_painovari",
    mapSheetInput = list("M5321L")
  )
)

# POST request what initiates a job
response <- request(url) %>%
  req_body_json(payload) %>%
  req_perform()

# Check the response
resp_status(response)
content <- resp_body_json(response)

# Check job status!
url <- content$links[[1]]$href
url <- paste0(url,
              "?api-key=", api_key
)
job_status <- request(url) |>
  req_perform()
resp_status(job_status)
job_response <- resp_body_json(job_status)

# if job status is successful, you retrieve the result urls
if (job_response$status == "successful"){
 # retrieve results
  url <- job_response$links[[1]]$href
  url <- paste0(url,
                "?api-key=", api_key)
  job_results <- request(url) |>
    req_perform()
}
resp_status(job_results)
response_results <- resp_body_json(job_results)

# Finally, you can download png file
download.file(url = response_results$results[[1]]$path, destfile = "results.png")


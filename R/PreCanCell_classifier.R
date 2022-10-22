#' Predicting Cancer and Non-Cancer Cells from Single-cell Transcriptomes
#'
#' @description \code{PreCanCell_classifier} Identify malignant and non-malignant cells across cancer types.
#'
#' @param testdata Cell type to be predicted.
#' (Note: Gene expression values of the samples need to be scaled to the range [0,1] by the function \link{PreCanCell_data} first)
#' @param cores Number of cores for parallel computing.
#' @importFrom parallel makeCluster clusterEvalQ clusterExport parLapply stopCluster
#' @importFrom caret predict
#' @return A dataframe with 2 columns:
#' \item{Sample}{Cell id}
#' \item{pred_labels}{Prediction results}
#'
#' @export
#'
#' @examples
#' path <- system.file("extdata", "example.rda", package = "PreCanCell", mustWork = TRUE)
#' input <- load(path)
#' testdata <- PreCanCell_data(input)
#' results <- PreCanCell_classifier(testdata, 2)


PreCanCell_classifier <- function(testdata, cores) {

  ## Check arguments
  if (missing(testdata) || !class(testdata) %in% c("matrix", "data.frame"))
    stop("'testdata' is missing or incorrect")

  if (TRUE %in% is.na(feature[,"Symbol"] %in% colnames(testdata))) {
    stop("Predictor variables are missing or incorrect")
  }

  ## Predict malignant and non-malignant cells
  cl <- parallel::makeCluster(cores)
  parallel::clusterEvalQ(cl,library(caret))
  parallel::clusterExport(cl, c("ModelList", "testdata"))
  set.seed(1234)
  res <- parallel::parLapply(cl, seq_len(length(ModelList)), function(x) caret::predict(ModelList[[x]], newdata = testdata))
  parallel::stopCluster(cl)

  res <- matrix(unlist(res), ncol = 5)
  resC <- apply(res, 1, function(x){
    names(which.max(table(x)))
  })

  result <- data.frame(Sample = rownames(testdata), pred_labels = resC, row.names = NULL, check.names = FALSE, stringsAsFactors = FALSE)

  return(result)

}

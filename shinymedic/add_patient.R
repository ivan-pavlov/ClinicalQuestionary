#! /usr/bin/Rscript

## Collect arguments
args <- commandArgs(TRUE)

## Default setting when no arguments passed
if(length(args) < 1) {
  args <- c("--help")
}

## Help section
if("--help" %in% args) {
  cat("
      Add patient info to our database

      Arguments:
      --doctor_id   - 
      --registration   - numeric
      --name   - character
      --sex   - boolean, TRUE - M; FALSE - F
      --dateofbirth   - date of birth
      --hsctdate   - operation date
      --dichargedate   - date of discharge
      --posthsctprogression   - string
      --comments   - strig
      --help  - print this text\n")
  
  q(save="no")
}


## Parse arguments (we expect the form --arg=value)
parseArgs <- function(x) strsplit(sub("^--", "", x), "=")
argsDF <- as.data.frame(do.call("rbind", parseArgs(args)))
argsL <- as.list(as.character(argsDF$V2))
names(argsL) <- argsDF$V1


library(RSQLite)
library(DBI)


fields <- paste("'", paste(argsDF$V1, collapse = "', '") ,"'", sep="")
values <- paste("'", paste(argsDF$V2, collapse = "', '") ,"'", sep="")

cmd <- paste("INSERT INTO patient (", fields,") VALUES (", values, ")", sep = "")

db <- dbConnect(SQLite(), dbname="../docs/test.sqlite")

dbExecute(db, cmd)

dbDisconnect(db)
\name{predict.moult}
\alias{predict.moult}
\alias{coef.moult}
\title{Predict method for moult models}

\description{Predict either the proportion of birds in a certain moult 
             stage (as defined in intervals) on a specified day, the average 
             moult score on a specified day, or start and/or duration of moult 
             for given covariate patterns}

\usage{
  \method{predict}{moult}(object, newdata, predict.type = "prob", intervals = 0.1, ...)}

\arguments{
  \item{object}{moult model objects}
  \item{newdata}{optional dataframe with explanatory variables for which to 
                 make predictions.  The first column must contain the days 
                 (as used when fitting) for which to make predictions. }
  \item{predict.type}{specifies form of predictions, see details.}
  \item{intervals}{length of moult categories for
    which probabilities/proportions should be calculated.  The default (= 0.1) 
    will calculate the probability that a bird will fall in this moult category
    on the specified day for each of the following categories: 0, (0, 0.1), 
    [0.1, 0.2), [0.2, 0.3), ..., [0.9, 1.0), 1.}
  \item{...}{other arguments passed to the predict method}
}

\details{\code{predict.type} has the following options: 

  \describe{
    \item{"response"}{the average moult index (proportion of
      feather mass grown) for each of the days specified.}
    \item{"prob"}{default, the proportion of birds in
      each of the moult categories as defined by intervals
      is predicted. }
    \item{"duration"}{predicts the duration of moult
      for the covariate combinations defined in \code{newdata},
      with standard errors. If \code{newdata} is not supplied, returns duration of baseline covariate set.}
    \item{"start"}{predicts the mean start date of moult
      for the covariate combinations defined in \code{newdata},
      with standard errors. If \code{newdata} is not supplied, returns mean start date of baseline covariate set. }
    \item{"both"}{predicts both mean start date of moult and 
      duration of moult for the covariate combinations defined in 
      \code{newdata}, with standard errors. Also, covariance of duration and start date estimates is given.}
  }
}  
\value{
  If \code{newdata} is missing, the expected moult scores at the observed days are returned. 
  
  If \code{predict.type = "response"}, the expected moult scores at the specified days are returned.
  
 If \code{predict.type = "prob"} a matrix of predicted probabilities for being in each of the moult categories defined by intervals.
    
  If \code{predict.type} equals "start" or "duration" or "both", the corresponding estimates (with standard errors) for each of the covariate patterns are returned.
}

\references{Erni, B., Bonnevie, B. T., Oschadleus, H.-D., Altwegg,
        R. and Underhill, L. G. (2013) moult: An R package to analyze
        moult in birds. Journal of Statistical Software, \bold{52}(8), 1--23.
        \url{https://www.jstatsoft.org/v52/i08/}

	Underhill, L. G. and Zucchini, W. (1988) A model for avian primary 
        moult. \emph{Ibis} \bold{130}, 358--372.

	Underhill, L. G. and Zucchini, W. and Summers, R. W. (1990) A
	model for avian primary moult-data types based on migration
	strategies and an example using the Redshank \emph{Tringa
	totanus}. \emph{Ibis} \bold{132}, 118--123. }


\author{\email{birgit.erni@uct.ac.za}}

\seealso{\code{\link{moult}}}
\examples{

data(weavers)

## convert moult scores to PFMG (proportion feather mass grown)
mscores <- substr(weavers$Moult, 1, 9)
feather.mass <- c(10.4, 10.8, 11.5, 12.8, 14.4, 15.6, 16.3, 15.7, 15.7)
weavers$pfmg <- ms2pfmg(mscores, feather.mass)

## day of year starting 1 August
weavers$day <- date2days(weavers$RDate, dateformat = "yyyy-mm-dd", startmonth = 8)
weavers$ssex <- ifelse(weavers$Sex == 1 | weavers$Sex == 3, "male",
  ifelse(weavers$Sex == 2 | weavers$Sex == 4, "female", NA))
  
mmf <- moult(pfmg ~ day | ssex | ssex, data = weavers, type = 3)
summary(mmf)

## predict duration and start of moult (then both) for males and females
ssex <- c("male", "female")
day <- 150

(p1 <- predict.moult(mmf, newdata = data.frame(day, ssex), predict.type = "duration"))
(p2 <- predict.moult(mmf, newdata = data.frame(day, ssex), predict.type = "start"))
(p3 <- predict.moult(mmf, newdata = data.frame(day, ssex), predict.type = "both"))

}

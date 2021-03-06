\name{sanderlings}
\alias{sanderlings}
\docType{data}
\title{Sanderling Moult Data
}
\description{This data set gives moult indices for 164 Sanderlings trapped on 11 days.
}
\usage{data(sanderlings)}
\format{
  A data frame with 164 observations on the following 2 variables.
  \describe{
    \item{\code{Day}}{a numeric vector of day bird was measured, 1 = 1 July}
    \item{\code{MIndex}}{a numeric vector of moult indices, 0 = bird has not started moult, 1 = bird has completed moult }
  }
}
\details{This data set gives moult indices for 164 Sanderlings trapped on 11 days in the southwestern Cape, South Africa, between October 1978 and April 1979. Day 1 = 1 July). Moult indices are a transformation of moult scores so that moult index increases linearly with time. See Underhill and Zucchini (1988) for details.
}
\source{Underhill and Zucchini (1998)}

\references{Underhill, L. G. and Zucchini, W. (1988) A model for avian
	primary moult. Ibis \bold{130}, 358--372.}

\examples{
data(sanderlings)

## fit model of type 1 to data
m1 <- moult(MIndex ~ Day, data = sanderlings, type = 1)               
summary(m1)

## model of type 2 (default)
m2 <- moult(MIndex ~ Day, data = sanderlings)                     
summary(m2)

## model of type 3
m3 <- moult(MIndex ~ Day, data = sanderlings, type = 3)              
summary(m3)

## find intercept and slope of mean moult trajectory line
uza <- - coef(m2, "mean") / coef(m2, "duration")    
uzb <- 1 / coef(m2, "duration")

## extract how many birds observed on each of the days
nn <- as.numeric(table(sanderlings$Day))        
## extract days of observations
day <- unique(sanderlings$Day)                                            

## probabilities of moult stages
## Table 6 in Underhill and Zucchini 1988
p1 <- predict(m2, newdata = data.frame(day))       
p1$M * nn

## Table 7 in Underhill and Zucchini 1988
days2 <- seq(70, 310, by = 10)
p2 <- predict(m2, newdata = data.frame(days2))
p2$M * 100                                  

p3 <- predict(m3, newdata = data.frame(day))      
p3

## Comparison with regression models
MInd <- sanderlings$MIndex[sanderlings$MIndex > 0 &
                           sanderlings$MIndex < 1]
MTime <- sanderlings$Day[sanderlings$MIndex > 0 &
                         sanderlings$MIndex < 1]

lm1 <- lm(MTime ~ MInd)                           
lm1.int <- coef(lm1)[1]
lm1.slope <- coef(lm1)[2]

lm2 <- lm(MInd ~ MTime)

## regression of Index on Time
plot(MTime, MInd, pch = 19, cex=0.7)

## regression of Time on Index: gives better estimates 
## for mean start day and duration of moult	    
abline(lm2, col = "blue", lwd = 2) 
abline(-lm1.int / lm1.slope, 1 / lm1.slope, col = "orange", lwd = 2) 
abline(uza, uzb, col = "red", lty = 2, lwd = 2)
}

\keyword{datasets}

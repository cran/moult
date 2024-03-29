\name{moult}
\alias{moult}
\alias{print.moult}
\alias{summary.moult}
\alias{logLik.moult}
\alias{moult_alternative}
\title{Models to analyse data of moult in birds}
\description{Estimate duration and mean start date of moult from 
             moult score data by maximum likelihood.  Covariates 
             to model duration and start of moult are possible. }

\usage{moult(formula, data, start = NULL, type = 2, method = "BFGS", fixed = NULL, 
             fixed.val = NULL, prec = 0.02)
            
moult_alternative(formula, data, start = NULL, type = 2, method = "BFGS", 
                  fixed = NULL, fixed.val = NULL, prec = 0.02)
}
          
\arguments{
  \item{formula}{symbolic description of the model, see details.}
  \item{start}{starting values for parameters.}
  \item{data}{an optional data frame containing the variables in the model. 
              If not found in data, the variables are taken from the environment
              from which \code{moult} was called.}
  \item{type}{integer (one of 1,2,3,4,5) referring to type of moult data
    and consequently model to be fitted (see details).}
  \item{method}{optimisation algorithm, passed to \code{\link{optim}}.}
  \item{fixed}{logical vector specifying which parameter values to fix during optimization.}
  \item{fixed.val}{numeric vector with values for the fixed parameters.}
  \item{prec}{numeric, measurement precision of moult index (proportion of feather mass grown), 
              default = 0.02.}
}

\details{\code{formula} is specified in 5 parts: 

  \code{moult.index ~ days | x1 + x2 | y1 + y2 | z1 + z2}

  where \code{moult.index} is a numerical vector with values between 0
  and 1, \code{days} is a vector with corresponding day numbers on which
  moult indeces were observed.  The next three parts contain explanatory
  variables for modelling duration, mean start date and standard
  deviation in start date, respectively.  If no explanatory variables are
  wanted for duration, say, this can be specified by leaving a blank
  between the first and second vertical lines, or equivalently,
  inserting a 1 between the vertical lines (which means all durations
  will be assumed equal).  Similarly for mean start date and standard
  deviation. The minimum formula must contain \code{moult.index ~ days},
  which will assume the same duration, mean start date and standard
  deviation for all individuals.   
                                              
\code{type} refers to the type of moult data available (see Underhill and
Zucchini (1998) and Underhill, Zucchini and Summers (1990)). 

\describe{
\item{type = 1}{sample is representative of entire population (not yet
  moulting, in moult, and birds which have completed moult).  For type 1
  data, any value between 0 and 1 (> 0 and < 1) can be used as the moult
  index for birds in active moult.  The value used does not matter, only
  the fact that they are in moult.}
\item{type = 2}{(default) sample is representative of entire population
  (not yet moulting, in moult, and birds which have completed
  moult).  Moult scores are required.}
\item{type = 3}{sample is representative only of birds in
  moult. Individuals with moult scores 0 or 1 are ignored.} 
\item{type = 4}{sample is representative only of birds in moult and those
  that have completed moult.  Individuals with moult scores 0 are ignored.} 
\item{type = 5}{sample is representative only of birds that have not
  started moult or that are in moult.  Individuals with moult scores 1
  are ignored.}
}

To \emph{fix parameters} \code{fixed} will be a logical vector, e.g. \code{fixed = c(F, F, T), 
fixed.val = 3.5} will fix the standard deviation in start date to exp(3.5) and only estimate 
the remaining two parameters. 

\code{moult} uses the \R function \code{\link{optim}} to minimise the negative log-likelihood. 

Note: The standard deviation parameters are estimated on the log-scale. Thus
the corresponding elements in the covariance matrix are also on the
log-scale. Starting values for the standard deviation should also be supplied on 
the log-scale. Standard errors for the standard deviation parameters are on
the scale of the standard deviation (in days), estimated using the delta
method.

\code{moult_alternative} offers a different parameterization (still in testing!): 
the \emph{duration of moult} parameter is as before, but instead of start of moult, 
the parameter estimated is the \emph{halfway date}, i.e. the date at which 50\% of 
individuals have completed 50\% of moult. The standard deviation parameter now is 
for the standard deviation between indiviudals in reaching 50\% of moult. Start and 
end of moult can be derived as halfway date - 0.5 x duration, + 0.5 x duration, 
respectively. This alternative parameterization attempts to reduce the problem of 
strong negative correlation between the previous parameters start of moult and 
duration, and gives a more robust estimate for timing of moult (Les Underhill, 
pers. comm., Jackson 2018).

}

\value{
    \item{coefficients}{parameter estimates split up into duration, mean
      start date and standard deviation of start date.}
    \item{loglik}{log-likelihood at parameter estimates.}
    \item{vcov}{variance covariance matrix for paramter estimates (duration, mean start date, SD(start date)).}
    \item{standard.errors}{vector of standard errors for parameter
      estimates, obtained from diagonal elements of vcov, see details (duration, mean start date, SD(start date)).}
    \item{type}{type of data assumed, see details.}
    \item{residuals}{vector of residuals: observed - fitted moult index.}
    \item{fitted.values}{a vector of fitted values (moult scores).}
    \item{n}{number of observations.}
    \item{df.residual}{residual degrees of freedom for fitted model.}
    \item{terms}{duration formula, mean formula, full formula.}
    \item{X}{model matrix with covariates.}
    \item{y}{observed response (moult index) values.}
    \item{Day}{observed observation days.}
    \item{mean.formula}{model formula for mean start date.}
    \item{duration.formula}{model formula for duration of moult.}
    \item{formula}{model formula for mean start and duration of moult.}
    \item{sd.formula}{grouping variable used to estimate standard
      deviations in mean start dates, different for each group.}
    \item{optim}{object returned by call to \code{\link{optim}}, which minimises
      negative log-likelihood.}
    \item{converged}{logical value indicating whether algorithm has
      converged or not.}
    \item{convergence.value}{value for convergence returned by optim,
      see \code{optim} for details.}
  }

\references{Erni, B., Bonnevie, B. T., Oschadleus, H.-D., Altwegg,
        R. and Underhill, L. G. (2013) moult: An R package to analyze
        moult in birds. \emph{Journal of Statistical Software}, \bold{52}(8), 1--23.
        \doi{10.18637/jss.v052.i08}
        
        Jackson, C. 2018. \emph{The moult and migration strategies of Lesser Sand Plover, 
        Greater Sand Plover and Terek Sandpiper.} PhD Thesis, University of Cape Town, 
        South Africa. 


  Underhill, L. G. and Zucchini, W. (1988) A model for avian
  primary moult. \emph{Ibis} \bold{130}, 358--372.

  Underhill, L. G. and Zucchini, W. and Summers, R. W. (1990) A model
  for avian primary moult-data types based on migration strategies and
  an example using the Redshank \emph{Tringa totanus}. \emph{Ibis} \bold{132},
  118--123. }

\author{Birgit Erni \email{birgit.erni@uct.ac.za}}

\seealso{\code{\link{predict.moult}}, \code{\link{ms2pfmg}}}
\examples{

data(sanderlings)

m2 <- moult(MIndex ~ Day, data = sanderlings) 
summary(m2)
}


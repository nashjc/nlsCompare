# NLSProbName: Bennett5_1.R
# NLSProbDescription: {These data are the result of a NIST study involving
#               superconductivity magnetization modeling.  The
#               response variable is magnetism, and the predictor
#               variable is the log of time in minutes.
#
#Reference:     Bennett, L., L. Swartzendruber, and H. Brown, 
#               NIST (1994).  
#               Superconductivity Magnetization Modeling.
# }

## DATA
# NOTE: we can get the data frame directly from the NISTnls package if installed.
NLSdata <- NISTnls::Bennett5

## STARTING VALUE
b1 <- -2000; b2 <- 50; b3 <- 0.8

NLSstart <-list(b1=b1, b2=b2, b3=b3) # a starting vector (named!)

## MODEL
NLSformula <- y ~ b1*(b2+x)**(-1/b3)
NLSlower<- c(-Inf,-Inf,-Inf)
NLSupper<- c(Inf,Inf,Inf)
NLSsubset <- 1:length(y)
NLSweights <- rep(1,length(y))
NLSref<-"nlsr"
#NLSrefVersion<-packageVersion(NLSref)
refsol<-nlsr::nlxb(NLSformula,NLSstart,NLSdata,lower=NLSlower, upper=NLSupper,trace=TRUE)
NLSproblems <- read.table(system.file("extdata","problems.csv",
                                        package="nlsCompare"),header=TRUE,sep=",")
NLSpars<-as.numeric(subset(NLSproblems,Name=="Bennett5_1.R")[4:(4+subset(NLSproblems,Name=="Bennett5_1.R")$nPars-1)])
NLSssquares<-subset(NLSproblems,Name=="Bennett5_1.R")$ssquares
NLStag<-"unbounded"
# NLSproblems[NLSproblems[,"Name"]=="Bennett5_1.R",]$PkgVers<-paste(NLSref,NLSrefVersion,sep=":")
# NLSproblems[NLSproblems[,"Name"]=="Bennett5_1.R",]$LastUpdated<-format(Sys.time(), "%Y-%m-%d %H:%M")
# write.table(NLSproblems,system.file("extdata","problems.csv",
#                                         package="nlsCompare"),append=FALSE,sep=",",col.names=FALSE,row.names=FALSE)
rm(y,tt,b1,b2,b3)

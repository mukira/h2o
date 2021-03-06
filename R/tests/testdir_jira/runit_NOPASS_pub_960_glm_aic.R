##
# Testing AIC value for GLM families gamma and tweedie
# Test for JIRA PUB-907 
# 'AIC Calculation for GLM Gamma & Tweedie'
##


setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source('../findNSourceUtils.R')


test <- function(conn) {
  
  print("Read prostate data into R.")
  prostate.data <-  h2o.uploadFile(conn, locate("smalldata/prostate/prostate.csv.zip"), key="prostate.data")
  
  print("Set variables for h2o.")
  myY = "DPROS"
  myX = c("ID","AGE","RACE","CAPSULE","DCAPS","PSA","VOL","GLEASON")
  
  print("Testing for family: GAMMA")
  model.h2o.Gamma.inverse <- h2o.glm(x=myX, y=myY, data=prostate.data, family="gamma", link="inverse", alpha=1, lambda_search=T, variable_importances=TRUE, use_all_factor_levels=TRUE, nfolds=0)
  print(model.h2o.Gamma.inverse)      #AIC is NaN
  
  print("Testing for family: TWEEDIE")
  model.h2o.tweedie <- h2o.glm(x=myX, y=myY, data=prostate.data, family="tweedie", link="tweedie", alpha=1, lambda_search=T, variable_importances=TRUE, use_all_factor_levels=TRUE, nfolds=0)
  print(model.h2o.tweedie)      #AIC is NaN
    
  testEnd()
}

doTest("Testing AIC value for GLM families gamma and tweedie", test)

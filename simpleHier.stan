data {
  int<lower=1> n;
  int<lower=1> sn;
  vector[n] FIXS;
  vector[n] VALS;
  int IDS[n];
  int TIMES[n];
}
parameters {
  real muOffset;
  real<lower=0> sigmaOffset;
  real offsets[sn];
  
  real<lower=0> muSlope;
  real<lower=0> sigmaSlope;
  real slopes[sn];
  
  real<lower=0> sigma;
}
model {
  muOffset ~ normal(10,10);
  sigmaOffset ~ pareto(0.1,1.5);
  muSlope ~ normal(0,.5);
  sigmaSlope ~ pareto(0.1,1.5);
  sigma ~ pareto(0.1,1.5);
  
  
  for(i in 1:sn){
    offsets[i] ~ normal(muOffset,sigmaOffset);
    slopes[i] ~ normal(muSlope,sigmaSlope);
  }
  
  for(i in 1:n){
    VALS[i] ~ normal(slopes[IDS[i]]*FIXS[i]+offsets[IDS[i]], sigma);
  }
}


library(covid19.analytics)

#Data
ag<-covid19.data(case='aggregated')
tsc<-covid19.data(case='ts-confirmed')
tsa<-covid19.data(case='ts-ALL')
#Summary
report.summary(Nentries = 10,
               graphical.output = T)

tots.per.location(tsc,geo.loc = 'India')

growth.rate(tsc,geo.loc = 'India')

totals.plt(tsa)

#world map
live.map(tsc)


#SIR Model           Susceptible Infected Recovered
generate.SIR.model(tsc,'India',tot.population = 135264228)

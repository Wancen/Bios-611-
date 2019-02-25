#Use the stringdist package to compare country names.
#Write a function called 'find_best_name' to find the best match for a single country.

find_best_name<-function(c){
  countries=unique(continent_sorted$name)
  dist=stringdist(c,countries,method='jw')
  min_dist=which.min(dist)
  closest_country=countries[min_dist]
  return(closest_country)
}
#Week 3 Homework
#
surveys = read.csv("data/portal_data_joined.csv")
surveys_base = surveys[1:60,c("species_id","weight","plot_type")]
surveys_base
surveys_base$species_id = as.character(surveys_base$species_id)
surveys_base$plot_type = as.character(surveys_base$plot_type)
surveys_base = surveys_base[complete.cases(surveys_base),]
surveys_base
#Challenge
surveys_base$weight = as.numeric(surveys_base$weight)
challenge_base = surveys_base[surveys_base$weight > 150,]
challenge_base
#

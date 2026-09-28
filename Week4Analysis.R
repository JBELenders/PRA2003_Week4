# PRA2003 - Week 4 Deliverable (Part 2 of 2)
# Reads the combined per-sub-sample results (from Part 1) and calculates,
# for each particle code:
#   - the WEIGHTED average across the 10 sub-samples (inverse-variance
#     weighted, using each sub-sample's own Poisson uncertainty)
#   - the standard deviation of the 10 sub-sample averages, used as the
#     statistical uncertainty (the "spread" method described in the slides)

input_csv <- "sub_sample_results.csv"

if (!file.exists(input_csv)) {
  stop(paste0("Can't find '", input_csv, "' - run Part 1 first."))
}

combined <- read.csv(input_csv)

final_result <- do.call(rbind, lapply(split(combined, combined$code), function(group) {
  
  weights <- 1 / (group$uncertainty^2)   #Inverse-variance weights, from each sub-sample's own uncertainty
  
  weighted_mean <- sum(weights * group$average_per_event) / sum(weights)
  spread_uncertainty <- sd(group$average_per_event)   #Standard deviation across the 10 sub-sample averages
  
  data.frame(
    code = group$code[1],
    name = group$name[1],
    average_per_event = round(weighted_mean, 5),
    uncertainty = round(spread_uncertainty, 5)
  )
}))

final_result <- final_result[order(-final_result$average_per_event), ]

options(scipen = 999)
cat("Final result: weighted average, uncertainty from spread across",
    length(unique(combined$sub_sample)), "sub-samples:\n\n")
print(final_result)

write.csv(final_result, "final_results.csv", row.names = FALSE)
cat("\nSaved final results to final_results.csv\n")
#Open the three files
ny = read.csv('new_york_city.csv')
wash = read.csv('washington.csv')
chi = read.csv('chicago.csv')

#Explore
head(ny)
head(wash)
head(chi)

#Question = What is the most common month in Chicago?

library(ggplot2)
library(plyr)

#Exploring
head(chi)
tail(chi)
str(chi)
summary(chi)
names(chi)

#Checking the frequency of each month
count(chi$start_month)

#Creating a mode function for the starting months.
mode_month <- function(m){
  uniqm <- unique(m)
  uniqm[which.max(tabulate(match(m, uniqm)))]
}

#Calculating which month appeared the most.
mode_month(chi$start_month)

#Converting start.time to be date format
Date <- as.Date(chi$Start.Time)
head(Date)

#Adding a column for chi for the start date
chi$start_date <- Date

#Adding a column for chi for the month only of the start date
chi$start_month <- months(chi$start_date)


#Creating a bar chart for the start month
ggplot(data = chi, aes(x = start_month)) +
  geom_bar(fill = 'blue', color = 'black') +
  ggtitle("Number of Counts in Chicago Per Month") +
  labs(x = "Starting Month", y = "Number of Counts")

#Answer = We could see that June is the most common month in Chicago. There are about 100,000 number of counts in the month of June. May is the second most common month of about 60,000 number of counts. We could conclude as the month increase, the number of counts increase.

#------------------------------------------------

#Question = How often do most people borrow bikes for in New York?

library(ggplot2)

#Exploring
head(ny)
tail(ny)
str(ny)
summary(ny)
names(ny)

#Creating an average function
avg_trip <- function(x){
  sum(x) / length(x)
}

#Finding the average of the trip duration
avg_trip(ny$Trip.Duration)

#Finding the median of the trip duration
median(ny$Trip.Duration)

#Creating a function for the mode of the trip duration
mode_trip <- function(y){
  uniqy <- unique(y)
  uniqy[which.max(tabulate(match(y, uniqy)))]
}

#Finding the mode of the trip duration, which could also answer our question.
mode_trip(ny$Trip.Duration)

#Creating a histogram of the trip duration
ggplot(data = ny, aes(x = Trip.Duration)) +
  geom_histogram(binwidth = 60, color = 'black', fill = 'green') +
  scale_x_continuous(limits = c(0,2000)) +
  ggtitle("Trip Duration Distribution in New York City") +
  labs(x = "Trip Duration per 60 Seconds", y = "Frequency")

#Answer = Since the bin width was set to 60 seconds, this histogram shows that most of the frequency appears within 300 to 360 seconds. Our calculated mode is within that range.

#-----------------------------------------------------

#Question = What is the average travel time for users in Washington based on their user type?

library(ggplot2)

#Exploring the summaries, which includes the average trip duration
head(wash)
tail(wash)
str(wash)
summary(wash)

#Creating a filter just for the Customer user type
cust_filter <- wash$User.Type == "Customer"

#Creating a data frame for the Washington data with only the Customer user type
wash_cust <- wash[cust_filter,]

#Creating a filter just for the Subscriber user type
sub_filter <- wash$User.Type == "Subscriber"

#Creating a data frame for the Washington data with only the Subscriber user type
wash_sub <- wash[sub_filter,]

#Creating a function for the mean of the trip duration
avg_trip <- function(x){
  sum(x) / length(x)
}

#Finding average of Washington Customer user type trip duration
avg_trip(wash_cust$Trip.Duration)

#Finding average of Washington Subscriber user type trip duration
avg_trip(wash_sub$Trip.Duration)

#Creating a mean for trip duration for Customer user type
avg_cust <- mean(wash_cust$Trip.Duration)

#Creating a mean for trip duration for Subscriber user type
avg_sub <- mean(wash_sub$Trip.Duration)

#Creating a data with two average values
avg_user <- rbind(avg_cust, avg_sub)

#Creating a user type value
user_type <- rbind("Customer", "Subscriber")

#Creating a data frame
avg_trip_user <- data.frame(avg_user, user_type)
avg_trip_user

#Creating a bar graph for Washington trip duration by user type.
ggplot(data = avg_trip_user, aes(x = user_type, y = avg_user)) +
  geom_col(fill = 'blue', color = 'black') +
  ggtitle("Average Trip Duration by User Type") +
  labs(x = "User Type", y = "Average Trip Duration in Seconds")

#Answer = The average of the Washington trip duration based on Customer user type is 2635.14 seconds. The average of the Washington trip duration based on Subscriber user type is 735.75 seconds. We could see that there is a significant difference of 1899.39 seconds between the mean trip duration of Customers and Subscribers.

##reading files

testx<- read.table("C:/Users/Yulia/Desktop/fernstudium/datascientist/R/assigmnets/UCI HAR Dataset/test/X_test.txt")
testy<- read.table("C:/Users/Yulia/Desktop/fernstudium/datascientist/R/assigmnets/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("C:/Users/Yulia/Desktop/fernstudium/datascientist/R/assigmnets/UCI HAR Dataset/test/subject_test.txt")

trainx<- read.table("C:/Users/Yulia/Desktop/fernstudium/datascientist/R/assigmnets/UCI HAR Dataset/train/X_train.txt")
trainy<- read.table("C:/Users/Yulia/Desktop/fernstudium/datascientist/R/assigmnets/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("C:/Users/Yulia/Desktop/fernstudium/datascientist/R/assigmnets/UCI HAR Dataset/train/subject_train.txt")


##rename variable because they are all have the same name->problem by merging
library("dplyr") 
subject_test <-rename(subject_test, ID= V1)
testy<-rename(testy, activities= V1)
trainy<-rename(trainy, activities = V1)
subject_train <-rename(subject_train, ID= V1)

#merging test data sets together
dataTest<- cbind(subject_test,testy,testx)
##merging train data sets together
dataTrain<- cbind(subject_train,trainy,trainx)

##merging two datasets togheter
data<-rbind(dataTest, dataTrain)
View(data)


##subsetting only meaNS AND ST for each activity
data_new<-select(data, ID, activities,V1 :V6, V41 :V46, V81 :V86,V121: V126, V161:V166, V201,V202, V214, V215, V227,V228, V240, V241, V253, V254, V266:V271, V345:V350, V424:V429,V503:V504,V516,V517,V529,V530,V542,V543)

##renaming variables
data_new<-rename(data_new, tBodyAccmeanX = V1,tBodyAccmeanY = V2,tBodyAccmeanZ = V3, tBodyAccstdX=V4, tBodyAccstdY= V5,tBodyAccstdZ= V6)
data_new<-rename(data_new,tGravityAccmeanX = V41,tGravityAccmeanY = V42, tGravityAccmeanZ = V43, tGravityAccstdX=V44, tGravityAccstdY= V45,tGravityAccstdZ= V46)
data_new<-rename(data_new, tBodyAccJerkmeanX = V81,tBodyAccJerkmeanY = V82,tBodyAccJerkmeanZ = V83, tBodyAccJerkstdX=V84, tBodyAccJerkstdY= V85,tBodyAccJerkstdZ= V86)
data_new<-rename(data_new, tBodyGyromeanX = V121,tBodyGyromeanY = V122,tBodyGyromeanZ = V123, tBodyGyrostdX=V124, tBodyGyrostdY= V125,tBodyGyrostdZ= V126)
data_new<-rename(data_new, tBodyGyroJerkmeanX = V161,tBodyGyroJerkmeanY = V162,tBodyGyroJerkmeanZ = V163, tBodyGyroJerkstdX=V164, tBodyGyroJerkstdY= V165,tBodyGyroJerkstdZ= V166)
data_new<-rename(data_new, tBodyAccMagmean = V201,tBodyAccMagstd = V202, tGravityAccMagmean = V214, tGravityAccMagstd=V215, tBodyAccJerkMagmean= V227, tBodyAccJerkMagstd= V228)
data_new<-rename(data_new, tBodyGyroMagmean = V240,tBodyGyroMagstd = V241,tBodyGyroJerkMagmean = V253, tBodyGyroJerkMagstd=V254,  fBodyAccmeanX= V266,fBodyAccmeanY= V267, fBodyAccmeanZ=V268)
data_new<-rename(data_new, fBodyAccstdX = V269, fBodyAccstdY = V270,fBodyAccstdZ = V271, fBodyAccJerkmeanX=V345, fBodyAccJerkmeanY= V346,fBodyAccJerkmeanZ= V347)
data_new<-rename(data_new, fBodyAccJerkstdX = V348,fBodyAccJerkstdY = V349,fBodyAccJerkstdZ = V350, fBodyGyromeanX=V424, fBodyGyromeanY= V425,fBodyGyromeanZ= V426,fBodyGyrostdX= V427,fBodyGyrostdY= V428)
data_new<-rename(data_new, fBodyGyrostdZ = V429,fBodyAccMagmean = V503,fBodyAccMagstd = V504,fBodyBodyAccJerkMagmean=V516, fBodyBodyAccJerkMagstd= V517,fBodyBodyGyroMagmean= V529,fBodyBodyGyroMagstd= V530,fBodyBodyGyroJerkMagmean=V542, fBodyBodyGyroJerkMagstd=V543)

##recoding the activities
install.packages("plyr")
library("plyr")
data_new$activities <- mapvalues(data$activities, from= c(1, 2, 3, 4, 5, 6 ), to=c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING", "STANDING","LAYING" ))

##creatin a tidy data set
install-package("reshape2")
library("reshape2")
molten_data<-melt(data_new, id=c("ID", "activities"))
tidy_data<-dcast(molten_data, ID+activities~variable, mean)
write.table(tidy_data,file="tidy_data.txt", row.names=FALSE)


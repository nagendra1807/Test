library(xlsx)
#Reading Data
Emp_Data<-read.xlsx(file = "C:/Users/Nagendra.B/Documents/My Inbit Messenger Files/Attrition Dataset.xlsx",sheetIndex = 2)
Emp_Type_Data<-read.xlsx(file = "C:/Users/Nagendra.B/Documents/My Inbit Messenger Files/Attrition Dataset.xlsx",sheetIndex = 3)
Ace_Roles_Details_Data<-read.xlsx(file = "C:/Users/Nagendra.B/Documents/My Inbit Messenger Files/Attrition Dataset.xlsx",sheetIndex = 4)
Emp_History_Data<-read.xlsx(file = "C:/Users/Nagendra.B/Documents/My Inbit Messenger Files/Attrition Dataset.xlsx",sheetIndex = 5)
Prior_Wrk_Exp_Data<-read.xlsx(file = "C:/Users/Nagendra.B/Documents/My Inbit Messenger Files/Attrition Dataset.xlsx",sheetIndex = 6)
Time_Details_Data<-read.xlsx(file = "C:/Users/Nagendra.B/Documents/My Inbit Messenger Files/Attrition Dataset.xlsx",sheetIndex = 7)
Performance_Grade_Data<-read.xlsx(file = "C:/Users/Nagendra.B/Documents/My Inbit Messenger Files/Attrition Dataset.xlsx",sheetIndex = 8)

Result_Data<-data.frame(ID = Emp_Data$EMP_ID,Desig = Emp_Data$EMP_DESIGNATION,DOJ = Emp_Data$EMP_DOJ,DOB = Emp_Data$EMP_DOB,DOT = Emp_Data$EMP_TERMINATION_DATE,Gender = Emp_Data$EMP_GENDER)
Result_Data<-cbind(Result_Data, Gender = Emp_Data$EMP_GENDER)
#Age Derived Fields

Result_Data$DOB<-as.character(Result_Data$DOB)
Result_Data$DOT<-as.character(Result_Data$DOT)

Result_Data$M_DOB<-ifelse(Result_Data$DOB == "NULL","",Result_Data$DOB)
Result_Data$M_DOT<-ifelse(Result_Data$DOT == "NULL","",Result_Data$DOT)

Result_Data$M_DOB<-as.numeric(Result_Data$M_DOB)
Result_Data$M_DOT<-as.numeric(Result_Data$M_DOT)

Result_Data$M_DOB<-as.Date(Result_Data$M_DOB,"1899-12-30")
Result_Data$M_DOT<-as.Date(Result_Data$M_DOT,"1899-12-30")

curr_date<-Sys.Date()
Result_Data$Age<-round((Result_Data$M_DOT - Result_Data$M_DOB)/365.25,2)

Result_Data$Total_Expr<-round((Result_Data$M_DOT-Result_Data$DOJ)/365.25,2)

Result_Data$Curr_Company<-"UST Global"


#Duration Field

Prior_Wrk_Exp_Data_Count<-count(Prior_Wrk_Exp_Data,"EMPLOYER")
Prior_Wrk_Exp_Data_Mean<-aggregate(Years~EMPLOYER,Prior_Wrk_Exp_Data,mean)

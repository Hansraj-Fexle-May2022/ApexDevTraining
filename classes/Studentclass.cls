public class Studentclass
{   
    // Insert Student records
	public void insertRcord()
    {
        //Inserted Student Detail
		Student__c student = new Student__c();
        Student.Name__c = 'Hansraj Jangid' ;
        Student.Father_Name__c = 'Jivraj Jangid';
		Student.Name = 'Hansraj Jangid';
        Student.HomePhone__c = '+919772415654' ; 
		Student.Roll_Number__c = 1000;
        Student.Date_Of_Birth__c = Date.newInstance(2000,08,14); 
        Student.Student_Gender__c = 'Male';
        Student.Student_Linkedin_Id__c = ' https://www.linkedin.com/in/hans-raj-jangid-9a3844196/ ' ; 
        Student.Address__c = 'Babra,pali,Rajsthan,306101';
        Student.Email__c = 'hansrajjangid14@gmail.com ' ; 
        Student.Father_Mobile_Number__c= '+919982097435' ; 
        Student.Mobile_Number__c = '+918302510323' ;
        Student.Overal_Grade__c = 8.3 ;
      
        
        //Bank details
        Student.Bank_Name__c = 'Axis Bank,Beawar' ;
        Student.Acoount_Number__c = 8888999;
        Student.Account_holder_Mobile_Number__c ='+918302510323';
        Student.Account_holder_Mobile_Number__c ='+918302510323';
        Student.Bank_Phone_Number__c = '+918302510323';
        Student.City__c = 'Pali' ;
        Student.State__c = 'Rajsthan';
        Student.IFSC_Code__c = '98HJ78900J4';
        
        
        // Semester Details
        Student.Back_In_Which_Sem__c ='NA';  
        Student.Back_In_Which_Subject__c = 'NA';
        Student.X1st_Sem_Percentage__c = 76 ;
        Student.X2nd_Sem_Percentage__c = 74 ;
        Student.X3rd_Sem_Percentage__c = 79 ;
        Student.X4th_Sem_Percentage__c = 80 ;
        
          
        // Fees Details
        Student.Current_Year__c = 4 ;
        Student.Exam_Fees_Submit__c = 'Yes';
        Student.Donation_Amount__c = 30000;
        Student.Fees_Submitted__c = 'Yes' ;
        Student.Pending_Exam_Fees__c = 0;
        Student.Pending_Fees_Amount__c = 0 ;
        Student.Pending_Overall_Amount__c = 0;
        Student.Is_Donetion__c = 'Yes';
        
        
        //Class Info
        Student.Class__c = '8th semester';
        Student.Section__c = 'A';
        Student.Stream__c = 'CSE';
       
        
        insert student;
        
		//Itrating the studant datails
		//List<Student__c> studentList= [select id, Name, Roll_Number__c from Student__c order by createdDate asc limit 5];
        //for(Student__c student_detail : iteratecontact )
        //{
		//	system.debug('Chck Student Data ::: ' + student_detail);
        //}
    }
    
}
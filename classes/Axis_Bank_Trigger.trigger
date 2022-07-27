trigger Axis_Bank_Trigger on Account (before insert,after insert) {
    for(Account bankAccountList : Trigger.New){
        if(Trigger.isInsert){
            if(Trigger.isBefore){
                if(bankAccountList.Account_Type__c == 'Saving Account'){
		bankAccountList.AccountNumber = 'SA-' +  bankAccountList.AccountNumber ;
		}
		if(bankAccountList.Account_Type__c == 'Salary account'){
		bankAccountList.AccountNumber = 'SalA-' +  bankAccountList.AccountNumber ;
		}
		if(bankAccountList.Account_Type__c == 'Current Account'){
		bankAccountList.AccountNumber = 'CA-' +  bankAccountList.AccountNumber ;
		}
		if(bankAccountList.Account_Type__c == 'Fixed Deposit Account'){
		bankAccountList.AccountNumber = 'FDA-' +  bankAccountList.AccountNumber ;
		}
	    }
	    if(Trigger.isAfter){
                BankTriggerUtility.BankEmailSend(Trigger.new);           
            }
        }
    }
}

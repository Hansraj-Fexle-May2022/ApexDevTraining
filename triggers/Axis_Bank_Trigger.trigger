trigger Axis_Bank_Trigger on Account (before insert,after insert) {
    if(Trigger.isInsert){
        BankTriggerUtility.addingPrefix(Trigger.new);
    }
	if(Trigger.isAfter){
        BankTriggerUtility.bankEmailSend(Trigger.new);           
    }
}

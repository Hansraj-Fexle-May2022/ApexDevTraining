trigger Axis_Bank_Trigger on Account (before insert,after insert) {
    if(Trigger.isInsert){
        BankTriggerUtility.AddingPrefix(Trigger.new);
    }
	if(Trigger.isAfter){
        BankTriggerUtility.BankEmailSend(Trigger.new);           
    }
}
/**
	Description 	:   This is the trigger for State__c object.
	Created BY 	    :   HANS RAJ JANGID
	Created Date 	:   10-07-2022
	Revision Logs 	:   V_1.0 - Created
			            V_1.1 - Dev Name : HANS RAJ JANGID
			            Date     : 17-08-2022
**/
trigger StateTrigger on State__c (after insert ,after delete) {
    if(Trigger.isInsert || Trigger.isDelete ){
        StateTriggerHelper.StateCountOnCountry(Trigger.New,Trigger.Old);
    }
}
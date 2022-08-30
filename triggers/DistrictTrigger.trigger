/**
	Description 	:   This is the trigger for District__c object
	Created BY 	    :   HANS RAJ JANGID
	Created Date 	:   10-07-2022
	Revision Logs 	:   V_1.0 - Created
			            V_1.1 - Dev Name : HANS RAJ JANGID
			            Date     : 17-08-2022
**/
trigger DistrictTrigger on District__c (after insert ,after delete ,after update) {
    if(Trigger.isInsert || Trigger.isUpdate|| Trigger.isDelete){
        DistrictTriggerHelper.districtCountOnState(Trigger.New,Trigger.oldMap);
    }
}
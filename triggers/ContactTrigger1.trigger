/**
	Description 	:   This is the trigger for contact object
	Created BY 	:   HANS RAJ JANGID
	Created Date 	:   10-07-2022
	Revision Logs 	:   V_1.0 - Created
			    V_1.1 - Dev Name : HANS RAJ JANGID
			            Date     : 17-08-2022
**/
trigger ContactTrigger1 on Contact (before insert) {
        ContactTriggerHelperForStatus.checkStatus(Trigger.New);
}
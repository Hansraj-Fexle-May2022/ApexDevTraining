/**
Description :   This is the trigger for not allowing and adding error for insering and updating email on Contact object.
Created By :    Hansraj Jangid
Created Date :  06-08-2022
Revision Logs : V_1.0 - Created 								  
**/
trigger SameEmailTrigger on Contact(before insert ,before update) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate ||Trigger.isInsert ){
            DuplicateEmailHelper.duplicateInsertAndUpdate(Trigger.New,Trigger.oldMap);
        }
    }
}
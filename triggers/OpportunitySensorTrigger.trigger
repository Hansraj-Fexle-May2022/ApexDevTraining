/**
Description :   This is the Opportunity Trigger for Automobile  sensor 
Created By :    Hansraj Jangid
Created Date :  08-08-2022
Revision Logs : V_1.0 - Created 								  
**/
trigger OpportunitySensorTrigger on Opportunity ( after insert ,after update) { 
    if(Trigger.IsAfter){
        if(Trigger.isInsert){
            AutomobileSensor.sendEmail(Trigger.New);
            AutomobileSensor.sendEmail(Trigger.New);
        }
        if(Trigger.isUpdate){
            AutomobileSensor.insertAutomobileSensor(Trigger.New, Trigger.OldMap);
        }      
    }
}  
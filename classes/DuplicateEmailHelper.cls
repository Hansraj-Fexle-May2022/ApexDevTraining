/**
Description :   This is the Helper Class of SameEmailTrigger
Created By :    Hansraj Jangid
Created Date :  06-08-2022
Revision Logs : V_1.0 - Created 								  
**/
public with sharing class DuplicateEmailHelper {
    public static void duplicateInsertAndUpdate(List<Contact> emailList , Map<Id,Contact> oldContactMap ) {
        //creating new set for new email list
        Set<String> newEmailSet = new Set<String>();
         //creating new set for existing email list
        Set<String> existEmailSet = new Set<String>();
        //itrating trigger.new list and adding in new email set
        for(Contact con : emailList ){
            if(con.Email != null && (oldContactMap == null || con.Email != oldContactMap.get(con.Id).Email)){
                newEmailSet.add(con.Email);
            }
        }
        //quering the existing email which is the new email set and addin into exist set
        for (Contact con :  [SELECT Email FROM Contact WHERE Email IN : newEmailSet AND Email != null]){
            existEmailSet.add(con.Email);
        }
        if(Trigger.isInsert||Trigger.isUpdate){
            for(Contact con : emailList){
                //checking the exist email set contains the email trigger.new emails
                if(existEmailSet.contains(con.Email)){
                    con.Email.AddError('Dupalicate Email is not allowed');
                }
            }
        }
    }
}
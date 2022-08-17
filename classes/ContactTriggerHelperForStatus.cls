/**
	Description 	:   This is the helper class for the contact trigger for
                        syncing the status of Property,Account $ Contact Object.
	Created BY 		:   HANS RAJ JANGID
	Created Date 	:  	10-07-2022
	Revision Logs 	: 	V_1.0 - Created
						V_1.1 - Dev Name : HANS RAJ JANGID
								Date 	 : 17-08-2022
**/
public with sharing class ContactTriggerHelperForStatus {
    public static void checkStatus( List<Contact> newList) {
        //new lists for Account field and related field
        List<Account>acountList = [SELECT Id, Status__c, Property__r.Status__c FROM Account];
        List<Account>acountList2 = [SELECT Id, Status__c, Property__r.Status__c FROM Account];
        for(Contact contact : newList) {
            //checking for contact field
            if(contact.Status__c == null) {
                for(Account account : acountList) {
                    if(contact.AccountId == account.Id) {
                        //checking for account field
                        if(account.Status__c != null) {
                            contact.Status__c = account.Status__c;
                        }
                        else if(account.Status__c == null) {
                            contact.Status__c = account.Property__r.Status__c;  
                            account.Status__c = account.Property__r.Status__c;                 
                        }
                    }
                }
            }
            if(contact.Status__c != null) {
                for(Account account : acountList2) {
                    if(account.Id  == contact.AccountId){
                        //checking for account field
                        if(account.Status__c == null) {
                            account.Status__c = contact.Status__c;
                        }
                        //checking for account and property field
                        else if(account.Status__c != null && account.Property__r.Status__c== null) { 
                            account.Property__r.Status__c = account.Status__c ;
                        }             
                    }
                }
            }
        }
    }
}
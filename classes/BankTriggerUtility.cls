public with sharing class BankTriggerUtility {
    public static void  addingPrefix(List<Account> acctountList){
        for(Account bankAccountList : acctountList){
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
        }
    }
    public static void  bankEmailSend(List<Account> acctList) {
        List <Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Account account : acctList){
            if(account.Account_Holder_Email__c != null){
                //Creating a new Email
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                List<String> sendTo = new List<String>();
                sendTo.add(account.Account_Holder_Email__c);
                mail.setToAddresses(sendTo);
                // the email is sent from 
                mail.setReplyTo('hansraj.jangid@fexle.com');
                mail.setSenderDisplayName('HANSRAJ JANGID');
                mail.setSubject('Welcome to Axis Bank!');
                String body = 'Dear ' + account.Name + ', ';
                body += 'your account has been activated and your account number is :' + account.AccountNumber;
                mail.setHtmlBody(body);
                mails.add(mail);
            }
        }
        // Sending all emails in the master list
        Messaging.sendEmail(mails);
    }
}

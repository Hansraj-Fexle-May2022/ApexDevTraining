public with sharing class BankTriggerUtility {
    public static void  BankEmailSend(List<Account> acctList) {
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
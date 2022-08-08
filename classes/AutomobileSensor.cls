/**
Description :   This is the Opportunity Trigger helper class for Sensor
Created By :    Hansraj Jangid
Created Date :  08-08-2022
Revision Logs : V_1.0 - Created 								  
**/
public with sharing class AutomobileSensor {   
    public static void insertAutomobileSensor(List<Opportunity> opportunityNewList) {
        List<Automobile_Sensor__c> listAutoSensor = new  List<Automobile_Sensor__c>();
        List<Automobile_Presence_Sensor__c> listAutoPresenceSensor = new List<Automobile_Presence_Sensor__c>();
        List<Automobile_TDU__c> listAutoTduSensor = new List<Automobile_TDU__c>();
        List<Automobile_Tag__c> listAutoTagSensor = new List<Automobile_Tag__c>();    
        Set<String> allListSet = new Set<String>();
        Set<String> allOldSet = new Set<String>();
        for(Opportunity opportunity : opportunityNewList){
            if(opportunity.StageName == 'Shipped to Customer' ||  opportunity.StageName == 
               'Return To Customer' ||  opportunity.StageName == 'Return To HQ'){                    
                if(opportunity.Automobile_Tag_Details_1__c != null && opportunity.Automobile_Tag_Details_2__c!=null
                   && opportunity.Automobile_Tag_Details_3__c != null && opportunity.Return_To_HQ__c != null ){             
                    List<String> tagDetails1String = opportunity.Automobile_Tag_Details_1__c.split('\n');
                    List<String> tagDetails2String = opportunity.Automobile_Tag_Details_2__c.split('\n');
                    List<String> tagDetails3String = opportunity.Automobile_Tag_Details_3__c.split('\n');
                    List<String> returnToHqString = opportunity.Return_To_HQ__c.split('\n');
                    allListSet.addAll(tagDetails1String);
                    //system.debug(allListSet);
                    allListSet.addAll(tagDetails2String);
                    allListSet.addAll(tagDetails3String);
                    allListSet.addAll(returnToHqString);
                    //for(String k : tagDetails1String){
                    //        system.debug(k);
                    if(!allListSet.isEmpty()){
                        for(String opc : allListSet){
                            Automobile_Sensor__c autoSensor = new Automobile_Sensor__c();
                            Automobile_Presence_Sensor__c autoPresenceSensor =	new Automobile_Presence_Sensor__c();
                            Automobile_TDU__c autoTduSensor=	new Automobile_TDU__c();
                            Automobile_Tag__c autoTagSensor= new Automobile_Tag__c();
                            //For remove the extra sting character
                            if(opc.length()>18){
                                opc = opc.substring(0,18);
                            }                
                            if(opc.startsWith('00:11:CE:00:')){
                                autoSensor.Name = opc;
                                autoSensor.Opportunity__c = opportunity.Id;
                                if(opportunity.StageName =='Return To HQ'){
                                    autoSensor.Account__c = opportunity.Shipment_Account__c;
                                }
                                else{
                                    autoSensor.Account__c = opportunity.AccountId;
                                }
                                listAutoSensor.add(autoSensor);  
                            }                         
                            if(opc.startsWith('00:11:CE:D:')){
                                autoPresenceSensor.Name = opc;
                                autoPresenceSensor.Opportunity__c = opportunity.Id;
                                if(opportunity.StageName =='Return To HQ'){
                                    autoPresenceSensor.Account__c = opportunity.Shipment_Account__c;
                                }
                                else{
                                    autoPresenceSensor.Account__c = opportunity.AccountId;
                                }
                                listAutoPresenceSensor.add(autoPresenceSensor);                       
                            }                 
                            if(opc.startsWith('00:11:CE:E:')){
                                autoTduSensor.Name = opc;                  
                                autoTduSensor.Opportunity__c = opportunity.Id;
                                if(opportunity.StageName =='Return To HQ'){
                                    autoTduSensor.Account__c = opportunity.Shipment_Account__c;
                                }
                                else{
                                    autoTduSensor.Account__c = opportunity.AccountId;
                                }
                                listAutoTduSensor.add(autoTduSensor);
                            }               
                            if(opc.substring(0,3).isNumeric()){
                                autoTagSensor.Name = opc ;
                                autoTagSensor.Opportunity__c = opportunity.Id;
                                if(opportunity.StageName =='Return To HQ'){
                                    autoTagSensor.Account__c = opportunity.Shipment_Account__c;
                                }
                                else{
                                    autoTagSensor.Account__c = opportunity.AccountId;
                                }
                                listAutoTagSensor.add(autoTagSensor); 
                            }  
                        }
                    }    
                }
            }
         	else{
                opportunity.StageName.AddError('Stage name is not valid');
            }
        }
        if(listAutoSensor.size()>0){ 
            system.debug('listAutoSensor'+listAutoSensor);
            insert listAutoSensor;        
        }
        if(listAutoPresenceSensor.size()>0){
            system.debug('listAutoSensor'+listAutoPresenceSensor);  
        	insert listAutoPresenceSensor;
        }
        if(listAutoTduSensor.size()>0){
        	insert listAutoTduSensor;
        }
        if(listAutoTagSensor.size()>0){
        	insert listAutoTagSensor;
        }
    }  
 	public static void updateAutomobileSensor(List<Opportunity> opportunityNewList, List<Opportunity> opportunityOldList) {
    	Set<Id> setOfAccountid = new Set<Id>();
        for(Opportunity opportunity1 : opportunityNewList) {
            for(Opportunity opportunity2 : opportunityOldList) {
                if(opportunity1.Id == opportunity2.Id && opportunity1.StageName !=opportunity2.StageName ){
                	setOfAccountid.add(opportunity1.Id);
                }
            }
            system.debug('setOfAccountid'+setOfAccountid);
        }  
        List<Opportunity> automobileList = [SELECT Id, Name,StageName,AccountId,Shipment_Account__c,
                                            (Select Id, Name,Account__c From Automobile_Sensors__r),
                                            (Select Id, Name,Account__c From Automobile_Presence_Sensors__r),
                                            (Select Id, Name,Account__c From Automobile_TDUes__r),
                                            (Select Id, Name,Account__c From Automobile_Tags__r)
                                            FROM Opportunity WHERE Id IN : setOfAccountid];
        List<Automobile_Sensor__c> listAutoSensor = new  List<Automobile_Sensor__c>();
        List<Automobile_Presence_Sensor__c> listAutoPresenceSensor = new List<Automobile_Presence_Sensor__c>();
        List<Automobile_TDU__c> listAutoTduSensor = new List<Automobile_TDU__c>();
        List<Automobile_Tag__c> listAutoTagSensor = new List<Automobile_Tag__c>();
        if(!automobileList.isEmpty()){
            for(Opportunity opportunity : automobileList) {
                List<Automobile_Sensor__c> autoSensor = opportunity.Automobile_Sensors__r;
                List<Automobile_Presence_Sensor__c> autoPresenceSensor = opportunity.Automobile_Presence_Sensors__r;
                List<Automobile_TDU__c> autoTduSensor = opportunity.Automobile_TDUes__r;
                List<Automobile_Tag__c> autoTagSensor = opportunity.Automobile_Tags__r;
                if(opportunity.StageName == 'Shipped to Customer' ||  opportunity.StageName == 
                'Return To Customer' ){
                    for(Automobile_Sensor__c sensor : autoSensor) {
                        sensor.Account__c = opportunity.AccountId;
                        listAutoSensor.add(sensor);
                    }
                    for(Automobile_Presence_Sensor__c presenceSensor : autoPresenceSensor) {
                        presenceSensor.Account__c = opportunity.AccountId;
                        listAutoPresenceSensor.add(presenceSensor);
                    }
                    for(Automobile_TDU__c tduSensor : autoTduSensor) {
                        tduSensor.Account__c = opportunity.AccountId;
                        listAutoTduSensor.add(tduSensor);
                    }
                    for(Automobile_Tag__c tagSensor : autoTagSensor) {
                        tagSensor.Account__c = opportunity.AccountId;
                        listAutoTagSensor.add(tagSensor);
                    }
                }
                else if(opportunity.StageName == 'Return To HQ'){
                    for(Automobile_Sensor__c sensor : autoSensor) {
                        sensor.Account__c = opportunity.Shipment_Account__c;
                        listAutoSensor.add(sensor);
                    }
                    for(Automobile_Presence_Sensor__c presenceSensor : autoPresenceSensor) {
                        presenceSensor.Account__c = opportunity.Shipment_Account__c;
                        listAutoPresenceSensor.add(presenceSensor);
                    }
                    for(Automobile_TDU__c tduSensor : autoTduSensor) {
                        tduSensor.Account__c = opportunity.Shipment_Account__c;
                        listAutoTduSensor.add(tduSensor);
                    }
                    for(Automobile_Tag__c tagSensor : autoTagSensor) {
                        tagSensor.Account__c = opportunity.Shipment_Account__c;
                        listAutoTagSensor.add(tagSensor);
                    }
                }
            }
        }       
        if(listAutoSensor.size() >0) {
            update listAutoSensor;
        }
        if(listAutoPresenceSensor.size() >0) {
            update listAutoPresenceSensor;
        }
        if(listAutoTduSensor.size() >0) {
            update listAutoTduSensor;
        }
        if(listAutoTagSensor.size() >0) {
            update listAutoTagSensor;
        }
    }
    public static void sendEmail(List<Opportunity> opportunityNewList){
        List <Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Set<String> allListSet = new Set<String>();
        Set<String> allWrongSet = new Set<String>();
        for(Opportunity opportunity :opportunityNewList ){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(opportunity.OwnerId);
            mail.setToAddresses(sendTo);
            mail.setSenderDisplayName('HANSRAJ JANGID');
            mail.setSubject(opportunity.Name +' '+ opportunity.CreatedDate);
            String body ='Sensor shipment process is completed' ;
            body += 'Please refer below mentioned details to get all the success and failure details.'+'<br/>';
            body +=  'Sussesfull : ' + '<br/>';
            body +=  '<table border="1" cellspacing="0"><tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';
            if(opportunity.StageName == 'Shipped To Customer'||opportunity.StageName == 'Return To Customer' ||
                opportunity.StageName == 'Return To HQ') {
                List<String> strListTag_Details_1 = opportunity.Automobile_Tag_Details_1__c.split('\n');
                List<String> strListTag_Details_2 = opportunity.Automobile_Tag_Details_2__c.split('\n');
                List<String> strListTag_Details_3 = opportunity.Automobile_Tag_Details_3__c.split('\n');
                List<String> returnToHqString = opportunity.Return_To_HQ__c.split('\n');
                allListSet.addAll(strListTag_Details_1);
                allListSet.addAll(strListTag_Details_2);
                allListSet.addAll(strListTag_Details_3);
                allListSet.addAll(returnToHqString);
                system.debug('allListSet:'+allListSet);
                if(allListSet.size()>0){
                    for(String sensorName : allListSet) {
                        if(sensorName.startsWith('00:11:CE:00:')){
                            body +='<tr><td>'+'Sensor'+'</td><td>'+sensorName+
                                '</td><td>'+'Sensor inserted under Installation account '+opportunity.AccountId+'</td></tr>';
                        }
                        else if(sensorName.startsWith('00:11:CE:D:')) {
                            body +='<tr><td>'+'Presence_Sensor'+'</td><td>'+sensorName+
                                '</td><td>'+'Sensor inserted under Installation account '+opportunity.AccountId+'</td></tr>';
                         }  
                        else if(sensorName.startsWith('00:11:CE:E:')){
                            body +='<tr><td>'+'TDU_Sensor'+'</td><td>'+sensorName+
                                '</td><td>'+'Sensor inserted under Installation account '+opportunity.AccountId+'</td></tr>';
                        }
                        else if(sensorName.substring(0,3).isNumeric()) {
                            body +='<tr><td>'+'Tag_Sensor'+'</td><td>'+sensorName+
                                '</td><td>'+'Sensor inserted under Installation account '+opportunity.AccountId+'</td></tr>';
                               
                        }
                        else{
                            allWrongSet.add(sensorName);
                        }              
                    }
                    body += '</table><br/><br/>';
                    if(!allWrongSet.isEmpty()){
                        body += 'Unsussesfull : ' + '<br/>';
                        body +=  '<table border="1" cellspacing="0"><tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';
                        for(String sensor :allWrongSet ){
                            body += '<tr><td>'+'Sensor'+'</td><td>'+sensor+'</td><td>'+'Invalid Sensor'+'</td></tr>';
                        }
                        body += '</table>';
                        }
                    }      
                mail.setHtmlBody(body);
                mails.add(mail); 
            }  
        }
        Messaging.sendEmail(mails);
    }
}
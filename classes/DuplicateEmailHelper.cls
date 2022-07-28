public with sharing class DuplicateEmailHelper {
    public static void duplicateInsert(List<Contact> emailList ) {
        Set<String> newEmailSet = new Set<String>();
        Set<String> existEmailSet = new Set<String>();
        for(Contact con : emailList ){
                if(con.Email != null ){
                    newEmailSet.add(con.Email);
                }
        }
        List<Contact> exisingEmailList = [SELECT Email FROM Contact WHERE Email IN : newEmailSet AND Email != null];
        for (Contact con : exisingEmailList){
            existEmailSet.add(con.Email);
        }
        for(Contact con : emailList){
            if(existEmailSet.contains(con.Email)){
                con.Email.AddError('Dupalicate Email is not allowed');
            }
        }
    }
    public static void duplicateUpdate(List<Contact> listEmail , List<Contact> existList){
        Set<String> newEmailSet = new Set<String>();
        Set<String> existEmailSet = new Set<String>();
        for(Contact con : listEmail ){
            for(Contact exEmail : existList ){
                if(con.Email != null && con.Email != exEmail.Email){
                    newEmailSet.add(con.Email);
                }
            }
        }
        List<Contact> exisingEmailList = [SELECT Email FROM Contact WHERE Email IN : newEmailSet AND Email != null];
        for (Contact con : exisingEmailList){
            existEmailSet.add(con.Email);
        }
        for(Contact con : listEmail){
            if(existEmailSet.contains(con.Email)){
                con.Email.AddError('Dupalicate Email is not allowed');
            }
        }
    }
}

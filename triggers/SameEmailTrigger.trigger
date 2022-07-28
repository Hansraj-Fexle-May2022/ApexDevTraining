trigger SameEmailTrigger on Contact(before insert ,Before Update) {
    if(Trigger.isInsert && Trigger.isBefore ){
        DuplicateEmailHelper.duplicateInsert(Trigger.New);
    }
    if(Trigger.isUpdate && Trigger.isBefore){
        DuplicateEmailHelper.duplicateUpdate(Trigger.New ,Trigger.Old);
    }
}
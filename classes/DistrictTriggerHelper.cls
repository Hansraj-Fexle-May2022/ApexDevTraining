/**
	Description 	:   This is the Helper class  for District__c object to populate
                        the  JSON as well as Count of districs and states.
	Created BY 	    :   HANS RAJ JANGID
	Created Date 	:   10-07-2022
	Revision Logs 	:   V_1.0 - Created
			            V_1.1 - Dev Name : HANS RAJ JANGID
			                    Date     : 17-08-2022
**/
public class DistrictTriggerHelper {
    public class Districts {
        public String districtName{get; set;}
    }
    public class States {
        public Integer Total_Number_Of_Districts{get; set;}
        public string stateName{get; set;}   
        public List<Districts> districts{get; set;}
    }

    public static void districtCountOnState(List<District__c> newDisList, List <District__c> oldDisList) {
        List<integer> countDistrictCountry = new List<integer>();
        List<integer> listcountStateDistrict = new List<integer>();
        States wrapperOfState;
        Districts wrapperOfDistrict;
        //new sets for storing the State id
        Set<id> storeStateId = new Set<id>();
        Set<id> storeNewStateId = new Set<id>();
        Set<id> storeOldStateId = new Set<id>();

        //new sets for storing the Country id
        Set<id> storeCountryId = new Set<id>();
        
        //new list for adding total disticts in state & country
        List<State__c> totalDistrictsInState = new List<State__c>();
        List<Country__c> totalDistrictsInCountry = new List<Country__c>();

        List<State__c> addState = new List<State__c>();
        List<Country__c> addCountry = new List<Country__c>();
        //insert and upadte Case
        if(newDisList != null){
            if(newDisList != null ){
                for (District__c district : newDisList){
                    storeStateId.add(district.State_Name__c);
                    storeCountryId.add(district.Country__c );
                }
            }
            else if(newDisList != null && oldDisList!= null){
                 for (District__c newDistrict : newDisList){
                    for(District__c oldDistrict : oldDisList){
        				if((newDistrict.State_Name__c != null) && (oldDisList == null || oldDistrict.State_Name__c != newDistrict.State_Name__c)) {                            
                    		storeNewStateId.add(newDistrict.State_Name__c);
                            storeOldStateId.add(oldDistrict.State_Name__c);		
            			} 
            		}
        		} 
                storeStateId.addAll(storeNewStateId);
        		storeStateId.addAll(storeOldStateId);
            }
            
        }
        system.debug('storeStateId'+storeStateId);
        system.debug('storeCountryId'+storeCountryId);
        //for delete case
        if(newDisList == null && oldDisList != null){
            for (District__c district : oldDisList){
                storeStateId.add(district.State_Name__c);
                storeCountryId.add(district.Country__c );
            }
        }
        //system.debug('oldDisList' + oldDisList);
        //Aggrigating Count of District

        List<AggregateResult> listAggDistrictState = [SELECT COUNT(id) cid ,State_Name__c sid FROM District__c WHERE State_Name__c =: storeStateId GROUP BY State_Name__c];
        List<AggregateResult> listAggDistrictCountry = [SELECT COUNT(id) ctid ,Country__c Conid FROM District__c  WHERE Country__c =:     storeCountryId GROUP BY Country__c];
       
        system.debug('listAggDistrictState' + listAggDistrictState);
        system.debug('listAggDistrictCountry' + listAggDistrictCountry);

        if(listAggDistrictState.size()>0){
            for(AggregateResult ar :listAggDistrictState){
                Id stateId = (Id)ar.get('sid');
                Integer countDistrict = (Integer)ar.get('cid');

                State__c st = new State__c(Id = stateId);
                st.Total_Number_of_Districts__c = countDistrict;
                addState.add(st);
            }
        }
        system.debug('addState' + addState);
        if(listAggDistrictCountry.size()>0){
            for(AggregateResult ar :listAggDistrictCountry){
                Id countryId = (Id)ar.get('Conid');
                Integer countDistrictOfCountry = (Integer)ar.get('ctid');

                Country__c con = new Country__c(Id = countryId);
                con.Total_Number_of_Districts__c = countDistrictOfCountry;
                addCountry.add(con);
            }
        }
        system.debug('addCountry' + addCountry);
        if(addState.size()>0){
            update addState;
        }
        if(addCountry.size()>0){
            update addCountry;
        }
        //Json Population on country 
        Integer b = 0;
        for(AggregateResult agr : listAggDistrictCountry) {
            listcountStateDistrict.add((Integer)agr.get('ctid'));
        }
        for(Country__c country : [Select Id, Name, Total_Number_of_Districts__c From Country__c Where Id In : storeCountryId]) {
            country.Total_Number_of_Districts__c = listcountStateDistrict[b];
            b = b+1 ;
            totalDistrictsInCountry.add(country);
        }
        if(totalDistrictsInCountry.size() != null) {
            Update totalDistrictsInCountry;
            System.debug('Total District Country -:' + totalDistrictsInCountry );
        }
        
        //Json population on State
        for(AggregateResult agr : listAggDistrictState) {
            listcountStateDistrict.add((Integer)agr.get('cid'));
        }

        Integer a = 0;
        List<District__c> disList = [SELECT Id, Name FROM District__c WHERE State_Name__c IN :storeStateId];
        for(State__c state : [SELECT Id, Name, Total_Number_of_Districts__c FROM State__c WHERE Id IN :storeStateId]) {
            state.Total_Number_of_Districts__c = listcountStateDistrict[a];
            a=a+1 ; 
            wrapperOfState = new States();
            wrapperOfState.stateName = state.Name;
            wrapperOfState.districts = new List<Districts>();
            for(District__c district : disList) {
                wrapperOfDistrict = new Districts();
                wrapperOfDistrict.districtName = district.Name;
                wrapperOfState.districts.add(wrapperOfDistrict);
            }
            wrapperOfState.Total_Number_of_Districts = (Integer)state.Total_Number_of_Districts__c;
            String stateJSONData = JSON.serialize(wrapperOfState);
            System.debug('stateJSONData : ' + stateJSONData);
            state.State_JSON_Data__c = stateJSONData;
            totalDistrictsInState.add(state);
        }
        if(totalDistrictsInState.size() != null) {
            Update totalDistrictsInState;
            System.debug('Total Districts in State -:' + totalDistrictsInState );
        }    
    }
}
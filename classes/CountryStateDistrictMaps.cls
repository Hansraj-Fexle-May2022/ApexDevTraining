public with sharing class CountryStateDistrictMaps {
    Map<Integer, Map<string, Map<string, List<string>>>> mapcountrycode = 
    new Map<Integer, Map<string, Map<string, List<string>>>>();
    List<string> listCountry = new List<string>{'India', 'Japan', 'Singapore', 'Australia'};
    public CountryStateDistrictMaps(){ 
        //Lists for India,91
        List<String> districtRajasthan = new List<String>{'Ajmer', 'Jaipur', 'Udaipur', 'Pali','Jodhpur'}; 
        List<String> districtHaryana   =  new List<String>{'Ambala', 'Bhiwani','Faridabad','Fatehabad'};
        List<String> districtGujarat   =  new List<String>{'Ahmedabad', 'Gandhinagar','Surat', 'Surendranagar'};
        //Lists for Japan, 81
        List<string> districtKanto   = new List<String>{'Tochigi', 'Gunma', 'Saitama'};
        List<String> districtChugoku = new List<String>{'Hiroshima' , 'Yamaguchi' , 'Shimane', 'Tottori'};
        //Lists for Singapore , 65
        List<String> districtDowntownCore = new List<String>{'Phillip', 'Maxwell', 'Nicoll'}; 
        List<String> districtGeylang      = new List<String>{'Aljunied', 'MacPherson',  'Somerset'};
        //Lists for Australia,61
        List<String> districtAVictoria = new List<String>{'Altona', 'Sydenham', 'Sunbury'}; 

        //Assigning  List of districts according to states
        Map<String, List<String>> mapIndia =
        new Map<String, List<String>>{'Rajasthan' => districtRajasthan, 'Gujarat' =>districtGujarat, 'Haryana'=>districtHaryana};
        Map<String, List<String>> mapJapan =
        new Map<String, List<String>>{'Kanto'=>districtKanto,'Chugoku'=> districtChugoku}; 
        Map<String, List<String>> mapSingapore= 
        new Map<String, List<String>>{'DowntownCore' =>districtDowntownCore ,'Geylang' => districtGeylang };
        Map<String, List<String>> mapAustralia =
        new Map<String, List<String>>{'AVictoria' => districtAVictoria};

        //Assigning Map of states according to country
        Map<String, Map<String, List<String>>> mapOfIndia= 
        new Map<String, Map<String, List<String>>>{'India'=> mapIndia };
        Map<String, Map<String, List<String>>> mapOfJapan= 
        new Map<String, Map<String, List<String>>>{'Japan' => mapJapan};
        Map<String, Map<String, List<String>>> mapOfSingapore= 
        new Map<String, Map<String, List<String>>>{'Singapore' => mapSingapore};
        Map<String, Map<String, List<String>>> mapOfAustralia= 
        new Map<String, Map<String, List<String>>>{'Australia' => mapAustralia};   
        Map<String, Map<String, List<String>>> mapOfCountry= 
        new Map<String, Map<String, List<String>>>{'India'=> mapIndia,'Japan' => mapJapan,'Singapore' => mapSingapore,'Australia' => mapAustralia};

        //Assigning Map of country according to country code
        Map<Integer, Map<String, Map<String, List<String>>>> mapCountryCode =  
        new Map<Integer, Map<String, Map<String, List<String>>>>{91=>mapOfIndia,81=>mapOfJapan, 65 => mapOfSingapore, 61 => mapOfAustralia };

        //1.finding combination of Country, state and districts where it starts with 'A'
        System.debug('Comibinations of Countries, States and Districts which starts with A : ');
        for(String getCountry :  mapOfCountry.keyset()) {
            if(getCountry.startsWithIgnoreCase('A')) {
                System.debug('Country - '+getCountry);
                for(String getState : mapOfCountry.get(getCountry).keySet()) {
                    if(getState.startsWIthIgnoreCase('A')) {
                        System.debug('State - '+getState);
                        for(String getDistrict : mapOfCountry.get(getCountry).get(getState)) {
                            if(getDistrict.startsWIthIgnoreCase('A')) {
                                System.debug('District - '+getDistrict);
                            }
                        }
                    }  
                }
            }
        }
        // 2. Find such a District which length is more or equal to some number.
        System.debug('District which length is more or equal to 6 : ');
        for(String getCountry : mapOfCountry.keySet()) {
            for(String getState : mapOfCountry.get(getCountry).keySet()) {
                for(String getDistrict : mapOfCountry.get(getCountry).get(getState)) {
                    if(getDistrict.length() <= 6) {
                        System.debug('District : '+getDistrict);
                    }
                }
            }
        }
    }
}
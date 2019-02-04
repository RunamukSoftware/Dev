

var mathLib = {
    add5: function (a) {
        return a + 5;
    }
}


// These are used to ensure that all local storage used to persist values
// use the same name
const ls_chk_USPA = "chk_uspa";
const ls_chk_logbook = "chk_logbook";
const ls_chk_dz = "chk_dz";
const ls_chk_equipment = "chk_equipment";
const ls_chk_policy = "chk_policy";
const ls_policystate = "policystate";

//Persist  canopy policy entries
const ls_canopytype = "canopytype";
const ls_canopysize = "canopysize";
const ls_name = "name";
const ls_email = "email";
const ls_exitweight = "exitweight";
const ls_totaljumps = "totaljumps";
const ls_lastyearjumps = "lastyearjumps";
const ls_USPA_MembershipNumber = "uspamembershipnumber";
const ls_USPA_Expiration= "expiration";
const ls_LicenseNumber = "licensenumber";
const ls_LicenseLetter = "licenseletter";
const ls_reasoning = "policyreasoning";  //for debug purposes only

var debugmode = false;
var ShowReasoning = false;


//{ Name: "DZ", Heading: "DZ Briefing", ContentURL: "content/dz.html", persistItem: ls_chk_dz, confirmClick: "I have a watched the DZ briefing video" },

// These relate to the headings and content pages for each of the chk items
var KnownChkItems = [
         { Name: "USPA", Heading: "USPA Membership", ContentURL: "content/uspa.html", persistItem: ls_chk_USPA, confirmClick: "I have a valid USPA membership" },
         { Name: "Logbook", Heading: "Logbook", ContentURL: "content/logbook.html", persistItem: ls_chk_logbook, confirmClick: "I have a valid logbook" },         
         { Name: "EQUIPMENT", Heading: "Equipment", ContentURL: "content/equipment.html", persistItem: ls_chk_equipment, confirmClick: "My equipment complies with FAA Rules" },
         { Name: "POLICY", Heading: "Canopy Policy", ContentURL: "content/policy.html", persistItem: ls_chk_policy, confirmClick: "My gear meets policy" },
]

function ItemState(xs) {
// This will return a better text description for checked items to confirm they have been entered in email construction.
	var returnstring = "NOT ENTERED";
	
	if ( xs == null || xs == undefined)
	{	
	}	
	else {
		switch (xs.toLowerCase())
		{
			case "true":
				returnstring = "CONFIRMED"
				break;
			case "false":
				returnstring = "NOT ENTERED"
				break;		
			default:
				break;		

		}
	}
	return returnstring;

}

function sendDetails() {
    //These are persisted items so if we leave the page and come back they are still present
    var uspa = localStorage.getItem(ls_chk_USPA);
    var logbook = localStorage.getItem(ls_chk_logbook);
    var equipment = localStorage.getItem(ls_chk_equipment);
    var dz = localStorage.getItem(ls_chk_dz);
    var policy = localStorage.getItem(ls_chk_policy);
	var license = localStorage.getItem(ls_LicenseLetter);
	var licensenumber = localStorage.getItem(ls_LicenseNumber);
	var policy = localStorage.getItem(ls_chk_policy);

    var name = $("#name").val();
    var email = $("#email").val();
	
	localStorage.setItem(ls_name, name);
	
	
	//Boolean(dz) &&
	
    if (Boolean(uspa) &&
        Boolean(logbook) &&
        
        Boolean(equipment) &&
        Boolean(policy) &&
        name.length > 0 &&
        email.length > 0) {

        //After sending we can remove these settings
        //resetlocalstoragevalues(); 
        updatemessage ();
        showState();		
		
    }
    else {
        alert("something is not entered, ensure all items are checked and name/email have been entered...")
    }
}




function confirmReadSection() {
    // This is used to reflect that the content panel button has been clicked confirming the user has viewed the 
    // content page.

    // Get the title of the content panel
    // and check when the button in the content footer is clicked showing that the person has read the content
    //  Policy will set the checked status based upon the policy being completed successfully

    var nocheckmark = "content/Checkmarks/no-th.jpg";
    var checkmark = "content/Checkmarks/th.jpg";

    var contentheading = $("#cp_heading").text();
    var chkcontrol = "";

    var chkItem = findKnownChkItem(contentheading);
    if (chkItem != null) {
        chkcontrol = chkItem.persistItem;

        if (chkcontrol !== "") {
            if (chkcontrol === ls_chk_policy) {
                reflectPolicyState(chkcontrol);
            }
			else if (chkcontrol === ls_chk_dz) {                
				// Determine if state is checked indicating video has been 
				// watched fully before checking
				if (localStorage.getItem(chkcontrol) == "true"){
					//Determine state and set check accordingly
					var img = "#" + chkcontrol + "_img";
					$(img).attr("src", checkmark);
					$(img).attr("hidden", false);	
				}
				else {
					$(img).attr("src", nocheckmark);
				}
            }
			else if (chkcontrol === ls_chk_USPA) {                				
				// watched fully before checking
				var x1b = validateUSPA();
				
				var img = "#" + chkcontrol + "_img";							
				$(img).attr("hidden", false);	
				
				if (localStorage.getItem(chkcontrol) == "true"){				
					//Determine state and set check accordingly			
					$(img).attr("src", checkmark);		
				}
				else {
					$(img).attr("src", nocheckmark);	
				}				
            }
            else {
                //Determine state and set check accordingly
                var img = "#" + chkcontrol + "_img";
                $(img).attr("src", checkmark);
                $(img).attr("hidden", false);
                localStorage.setItem(chkcontrol, true);
            }
        }
    }
    updatemessage();
}


function validateUSPA() {
	//Verify that both membership and expiration are valid
	
	// 6 digit number for membership
	// date is later than now
	
	var str = $("#MembershipNumber").val().trim();
	var patt = new RegExp("^(\\d{6}|\\d{7})$");		
	var error1 = false;
	var strReason = "";
	
	if (!patt.test(str)) {
			 error1 =true;
			 strReason = strReason  + "Invalid membership number (should be 6 or 7 digits) <br>"
	}
	
	//Expiration > todays date....	
 
	var de = Date.parse( $("#Expiration").val());	
	var dn = new Date();
	

	if (isNaN(de)) {
			 error1 =true;
			 strReason = strReason  + "Invalid expiration date (must be a valid date) <br>"
	}
	else {
	if (de < dn ) {		
		strReason = strReason  + "Already expired membership <br>"
		error1=true;			
	}	
		
	}
		
	var str2 = $("#LicenseNumber").val().trim();
	var patt = new RegExp("\\b\\d{1,6}\\b");		
	
 
	
	
	
	if (! patt.test(str2)) {
		strReason = strReason  + "Invalid license number (should be less than 6 digits)<br>"
		error1 =true;
	}	
		
	//Store details
	localStorage.setItem(ls_USPA_MembershipNumber ,str);		
	localStorage.setItem(ls_USPA_Expiration,$("#Expiration").val());					
	localStorage.setItem(ls_LicenseLetter, $("#LicenceType option:selected").val());
	localStorage.setItem(ls_LicenseNumber, $("#LicenseNumber").val());
	
	
	document.getElementById('USPAResult').style.display = "block";		
	if (error1) {	
		document.getElementById('USPAResult').innerHTML = "PROBLEM WITH INPUTS <br>" + strReason ;	
		localStorage.setItem(ls_chk_USPA,false);				
	}
	else {
		//possibly hide validation
		document.getElementById('USPAResult').innerHTML = "";		
		localStorage.setItem(ls_chk_USPA,true);				
	}
	
	
	
}
	
	
function reflectPolicyState(control) {
    // We want to confirm policy was met before displaying the check status against canopy policy item
    // So this uses the result from validating the inputs to determine status.
    // If the policystate is NotOK then we don't want to show the canopy policy as checked.

    var pr = parseInt(localStorage.getItem(ls_policystate));

    var img = "#" + control + "_img";
    if (pr === PolicyResult.OK || pr === PolicyResult.Possible) {
        // OK or possible.... Then check    
        //$(img).attr("hidden", false);
        localStorage.setItem(control, true);

        //TODO: could change to reflect possible.
        if (pr === PolicyResult.OK) {
            $(img).attr("src", "content/checkmarks/th.jpg");
        }
        else if (pr === PolicyResult.Possible) {
            $(img).attr("src", "content/checkmarks/possible-th.jpg");
        }
    }
    else {
        //No meeting requirments
        var checkmark = "content/Checkmarks/no-th.jpg";
        $(img).attr("src", checkmark);

        localStorage.setItem(control, false);
    }
}

function findKnownChkItem(name) {
    // case insensitive search of names and Headings against the KnownChkItems array
    // we use these KnownChkItems to set content and headings for the content panel.

    //Search Names
    for (var i = 0; i < KnownChkItems.length; i++) {
        if (KnownChkItems[i].Name.toLowerCase() === name.toLowerCase()) {
            return KnownChkItems[i];
            break;
        }
    }

    //Search Headings
    for (var i = 0; i < KnownChkItems.length; i++) {
        if (KnownChkItems[i].Heading.toLowerCase() === name.toLowerCase()) {
            return KnownChkItems[i];
            break;
        }
    }

    return null;
}

function updatemessage() {
            // Populate the message with inputs
			
		var x = "Entered Info:\n";
            x = x + "USPA: " + ItemState(localStorage.getItem(ls_chk_USPA)) + "\n";
            x = x + "  MEMBERSHIP NUMBER: " + blankStringOrContent(localStorage.getItem(ls_USPA_MembershipNumber)) + "\n";
            x = x + "  EXPIRATION DATE  : " + blankStringOrContent(localStorage.getItem(ls_USPA_Expiration)) + "\n";    			
			x = x + "  LICENSE  : " + blankStringOrContent(localStorage.getItem(ls_LicenseLetter)) +  "-" + blankStringOrContent(localStorage.getItem(ls_LicenseNumber))   +"\n";    
            x = x + "LOGBOOK: " + ItemState(localStorage.getItem(ls_chk_logbook)) + "\n";
            x = x + "EQUIPMENT: " + ItemState(localStorage.getItem(ls_chk_equipment)) + "\n";
            x = x + "DZ VIDEO WATCHED: " + ItemState(localStorage.getItem(ls_chk_dz)) + "\n";
            x = x + "CANOPY POLICY CHECK : " + ItemState(localStorage.getItem(ls_chk_policy)) + "\r\n\n";			
			x = x + "CANOPY POLICY INPUTS: \n";            			
            x = x + "TOTAL JUMPS: " + blankStringOrContent(localStorage.getItem(ls_totaljumps)) + "\n";
            x = x + "PREV 12 MONTH JUMPS: " + blankStringOrContent(localStorage.getItem(ls_lastyearjumps)) + "\n";
            x = x + "EXIT WEIGHT: " + blankStringOrContent(localStorage.getItem(ls_exitweight)) + "\n";
            x = x + "CANOPY: " + blankStringOrContent(localStorage.getItem(ls_canopytype)) + "\n";
            x = x + "CANOPY SIZE: " + blankStringOrContent(localStorage.getItem(ls_canopysize)) + "\n\n";
						
			var rx = '';			
			if (localStorage.getItem(ls_reasoning) != ""){				
				rx = rx + "REASONING : " +blankStringOrContent(localStorage.getItem(ls_reasoning)) + "\r\n";		
			}				
			
			$("#reasoning").val(rx);
            $("#message").val(x);
        }
		
		
function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

function blankStringOrContent (str) {	
	if (isBlank(str)) {
		return  "";
	}
	return str;
}

function displayContent(name) {
    // This will get the content pages for each of the check items.
    //  It is done this way to separate the content details from the basic page framework.

    var contentHeading = "";
    //if changing items and havent saved then persist the data.
    if ($("#cp_heading").text == "policy") {
        PersistPolicyValue();
    }

    var chkItem = findKnownChkItem(name);
    if (chkItem != null) {
        $("#cp_inner").attr("hidden", false)

        if (name.toLowerCase() === "policy") {
            $.ajaxSettings.cache = false;
            $("#cp_content").load(chkItem.ContentURL + '?buster=' + new Date().getTime(), function () {                
                //Jumps, Currency, Weight, CanopyType, Canopy Size
                $("#TotalJumps").val(localStorage.getItem(ls_totaljumps));
                $("#JumpsInPast12Months").val(localStorage.getItem(ls_lastyearjumps));
                $("#ExitWeight").val(localStorage.getItem(ls_exitweight));
                $("#CanopySize").val(localStorage.getItem(ls_canopysize));
                $("#ddl_canopies1").val(localStorage.getItem(ls_canopytype));
            });
        }
        else if (name.toLowerCase() === "uspa") {
            $.ajaxSettings.cache = false;
            $("#cp_content").load(chkItem.ContentURL + '?buster=' + new Date().getTime(), function () {
                // We need to populate form items                
                $("#MembershipNumber").val(localStorage.getItem(ls_USPA_MembershipNumber));
                $("#Expiration").val(localStorage.getItem(ls_USPA_Expiration));												
				$("#LicenseNumber").val(localStorage.getItem(ls_LicenseNumber));
				$("#LicenceType").val(localStorage.getItem(ls_LicenseLetter));
            });
       }
        else {
            
            $("#cp_content").load(chkItem.ContentURL);
        }
        $("#cp_heading").text(chkItem.Heading);
    }
    else {
        // display unknown chkitem detail
        $("#cp_inner").attr("hidden", true)
    }

}

function PersistPolicyValue() {
    //Persist values for repopulation in future
    // This is only used for the policy fields 
    localStorage.setItem(ls_canopysize, $("#CanopySize").prop('value'));
    localStorage.setItem(ls_canopytype, $("#ddl_canopies1 option:selected").text());
    localStorage.setItem(ls_exitweight, $("#ExitWeight").prop('value'));
    localStorage.setItem(ls_totaljumps, $("#TotalJumps").prop('value'));
    localStorage.setItem(ls_lastyearjumps, $("#JumpsInPast12Months").prop('value'));
    localStorage.setItem(ls_name, $("#name").prop('value'));
    localStorage.setItem(ls_email, $("#email").prop('value'));
}

function resetlocalstoragevalues() {
    // After sending we can remove these settings
	// or when we reset the form
	localStorage.removeItem(ls_name);
    localStorage.removeItem(ls_email);
	localStorage.removeItem(ls_chk_USPA);
    localStorage.removeItem(ls_chk_logbook);
    localStorage.removeItem(ls_chk_equipment);
    localStorage.removeItem(ls_chk_dz);
    localStorage.removeItem(ls_chk_policy);
    localStorage.removeItem(ls_policystate);
    localStorage.removeItem(ls_canopytype);
    localStorage.removeItem(ls_canopysize);
    localStorage.removeItem(ls_exitweight);
    localStorage.removeItem(ls_totaljumps);
    localStorage.removeItem(ls_lastyearjumps);
    localStorage.removeItem(ls_USPA_MembershipNumber);
    localStorage.removeItem(ls_USPA_Expiration);
    localStorage.removeItem(ls_reasoning); 	
	localStorage.removeItem(ls_LicenseLetter);
    localStorage.removeItem(ls_LicenseNumber);
}
















var Result = {
    OK: 0,
    HighPerformance_ExemptionPossible: 1,
    //Fast fail conditions
    Experience_TooLow: 2,
    CanopySize_Under100_NonNegotiable: 3,
    Experience_BelowELipticalLimit: 4,

    // Experience checking limits exceeded
    CanopySize_TooSmallForExperience: 5,
    WingLoading_TooSmallForExperience: 6,

    // Currency levels exceeded
    ExceedLimitsBasedUponCurrency: 7,
    InvalidInputs: 8
}

// Used to determine fast fail conditions
var ExperienceResult = {
    WithinLimit: 1,
    OutOfLimit: 2,
    Possible: 3,
};

var PolicyResult = {
    OK: 0,
    Possible: 1,
    NotOk: 2,
};

const NonNegotiableLimit = 1000;
const ElipticalLimit = 300;
const HiPerformanceNegotiableLimit = 1000;

var KnownCanopies = [         
         { Name: "Aerodyne Mamba", IsEliptical: true , IsCommon: false,},
         { Name: "Aerodyne Diablo", IsEliptical: true, IsCommon: false },
         { Name: "Aerodyne Sensei", IsEliptical: true, IsCommon: false },
         { Name: "Aerodyne Vision", IsEliptical: true, IsCommon: false  },
         { Name: "Aerodyne Zulu", IsEliptical: true, IsCommon: false  },
         { Name: "Flight Concepts Pro Series", IsEliptical: true , IsCommon: false },
         { Name: "Flight Concepts Rage", IsEliptical: true , IsCommon: false },
         { Name: "Parachutes de France BT", IsEliptical: true , IsCommon: false },
         { Name: "Parachutes de France BT Pro", IsEliptical: true , IsCommon: false },
         { Name: "Parachutes de France Springo", IsEliptical: true , IsCommon: false },
         { Name: "Parachutes de France Ninja", IsEliptical: true , IsCommon: false },
         { Name: "Paratec Factor", IsEliptical: true , IsCommon: false },
         { Name: "Paratec X-Wing", IsEliptical: true , IsCommon: false },
         { Name: "Paratec Fandango", IsEliptical: true , IsCommon: false },
         { Name: "Performance Designs Stilleto", IsEliptical: true , IsCommon: true },
         { Name: "Performance Designs Vengeance", IsEliptical: true , IsCommon: false },
         { Name: "Performance Designs Velocity", IsEliptical: true , IsCommon: true },
         { Name: "Performance Designs Katana", IsEliptical: true , IsCommon: true },
         { Name: "Performance Designs Peregrine", IsEliptical: true , IsCommon: false },
         { Name: "Precision Nitron", IsEliptical: true , IsCommon: false },
         { Name: "Precision Xaos 21", IsEliptical: true , IsCommon: false },
         { Name: "Precision Xaos 27", IsEliptical: true , IsCommon: false },
         { Name: "Precision Batwing", IsEliptical: true , IsCommon: false },
         { Name: "Icarus Crossfire", IsEliptical: true , IsCommon: true },
         { Name: "Icarus Crossfire 2", IsEliptical: true , IsCommon: true},
         { Name: "Icarus Extreme FX", IsEliptical: true , IsCommon: false },
         { Name: "Icarus Extreme VX", IsEliptical: true , IsCommon: false },
         { Name: "Icarus Neos", IsEliptical: true , IsCommon: false },
         { Name: "Icarus Petra", IsEliptical: true , IsCommon: false },
		 { Name: "Icarus Leia", IsEliptical: true , IsCommon: false },
         { Name: "Performance variables Contrail", IsEliptical: true , IsCommon: false },
         { Name: "Big Air Sports Samurai", IsEliptical: true , IsCommon: false },
         { Name: "Parachute Systems/Chute Shop Hurricane", IsEliptical: true, IsCommon: false },
         { Name: "Parachute Systems/Chute Shop Volt", IsEliptical: false, IsCommon: false },
         { Name: "Atair Space", IsEliptical: true , IsCommon: false },
         { Name: "Atair Cobalt", IsEliptical: true , IsCommon: false },
         { Name: "Atair Alpha", IsEliptical: true , IsCommon: false },
         { Name: "Atair Radical", IsEliptical: true , IsCommon: false },
         { Name: "Atair Onyx", IsEliptical: true , IsCommon: false },
         { Name: "Airtime Jonathan", IsEliptical: true , IsCommon: false },
         { Name: "Airtime Jedei", IsEliptical: true , IsCommon: false },
         { Name: "Airtime Tomcat", IsEliptical: true , IsCommon: false },
         { Name: "PISA Heatwave", IsEliptical: true , IsCommon: false },
         { Name: "Parachute Labs Firebolt", IsEliptical: true , IsCommon: false },
         { Name: "Aerodyne Solo", IsEliptical: false , IsCommon: false },
         { Name: "Aerodyne Triathlon", IsEliptical: false , IsCommon: true },
         { Name: "Aerodyne Pilot", IsEliptical: false , IsCommon: true },
         { Name: "Flight Concepts/Glidepath Maverick", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Fury", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Cricket", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Firelite", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Startrac", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Sharpchuter", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Raider", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Maverone", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Clipper", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Manta", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts/Glidepath Cruiselite", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts Sentry", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts Express", IsEliptical: false , IsCommon: false },
         { Name: "Flight Concepts Prodigy", IsEliptical: false , IsCommon: false },
         { Name: "Parachutes de France Prima", IsEliptical: false , IsCommon: false },
         { Name: "Parachutes de France Drakkar", IsEliptical: false , IsCommon: false },
         { Name: "Parachutes de France Turbo", IsEliptical: false , IsCommon: false },
         { Name: "Parachutes de France Electra", IsEliptical: false , IsCommon: false },
         { Name: "Parachutes de France Merit", IsEliptical: false , IsCommon: false },
         { Name: "Paratec Balans", IsEliptical: false , IsCommon: false },
         { Name: "Paratec Super 7", IsEliptical: false , IsCommon: false },
         { Name: "Paratec Quadra", IsEliptical: false , IsCommon: false },
         { Name: "Paratec Quadra V-tec", IsEliptical: false , IsCommon: false },
         { Name: "Performance Designs Navigator", IsEliptical: false , IsCommon: false },
         { Name: "Performance Designs F111 series", IsEliptical: false , IsCommon: false },
         { Name: "Performance Designs Sabre", IsEliptical: false , IsCommon: true },
         { Name: "Performance Designs Spectre", IsEliptical: false , IsCommon: true },
         { Name: "Performance Designs Silhouette", IsEliptical: false , IsCommon: false },
         { Name: "Performance Designs Pulse", IsEliptical: false , IsCommon: true },
         { Name: "Performance Designs Storm", IsEliptical: false , IsCommon: false },
         { Name: "Performance Designs Sabre 2", IsEliptical: false , IsCommon: true },
         { Name: "Performance Designs Lightning", IsEliptical: false , IsCommon: false },
         { Name: "PISA Skymaster", IsEliptical: false , IsCommon: false },
         { Name: "PISA Hornet", IsEliptical: false , IsCommon: false },
         { Name: "Precision Raven", IsEliptical: false , IsCommon: false },
         { Name: "Precision Super Raven", IsEliptical: false , IsCommon: false },
         { Name: "Precision Falcon", IsEliptical: false , IsCommon: false },
         { Name: "Precision Synergy", IsEliptical: false , IsCommon: false },
         { Name: "Precision Monarch", IsEliptical: false , IsCommon: false },
         { Name: "Precision Fusion", IsEliptical: false , IsCommon: false },
         { Name: "Icarus Student ZP7", IsEliptical: false , IsCommon: false },
         { Name: "Icarus Equinox", IsEliptical: false , IsCommon: false },
         { Name: "Icarus Omni", IsEliptical: false , IsCommon: false },
         { Name: "Icarus Safire", IsEliptical: false , IsCommon: true },
         { Name: "Icarus Safire 2", IsEliptical: false , IsCommon: true },
         { Name: "Icarus Omega", IsEliptical: false , IsCommon: false },
         { Name: "Performance Variables Spark", IsEliptical: false, IsCommon: false },         
         { Name: "Parachute Systems/Chute Shop Volt ", IsEliptical: false , IsCommon: false },
         { Name: "Big Air Sports Lotus", IsEliptical: false , IsCommon: false },
         { Name: "Parachute Systems/Chute Shop ZPo", IsEliptical: false , IsCommon: false },
         { Name: "Strong Enterprises Zpo", IsEliptical: false , IsCommon: false },
         { Name: "Strong Enterprises Stellar", IsEliptical: false , IsCommon: false },
         { Name: "Atair  Drago", IsEliptical: false }
];



function ValidateEntries(totalJumps,
    jumpsInLastYear,
    CanopyName,
    canopysize,
    exitWeight,
    name,
    email
    ) {

    //Basic Validations
    if (CanopyName.length == 0 || isNaN(parseInt(canopysize)) ||
        isNaN(parseInt(totalJumps)) ||
        isNaN(parseInt(jumpsInLastYear)) ||
        isNaN(parseInt(exitWeight))) {
        xresult = Result.InvalidInputs;
		localStorage.setItem(ls_reasoning, "");
    }
    else if (parseInt(totalJumps) < parseInt(jumpsInLastYear)) {
        //Something strange with jump number
        xresult = Result.InvalidInputs;
	    localStorage.setItem(ls_reasoning, "");
    }
    else {
        //Calculate the wing loading
        var wingloading = parseInt(exitWeight) / parseInt(canopysize);

        //Call the calculation to determine if meet the policy
        var xresult = WingLoadingSizeMatrix(parseInt(totalJumps),
                                     parseInt(jumpsInLastYear),
                                     wingloading,
                                     CanopyName,
                                     parseInt(canopysize));

    }



    return xresult;
}


function WingLoadingSizeMatrix(TotalJump,
                               JumpInYear,
                               WingLoading,
                               CanopyType,
                               CanopySize) {
    //Determine Fast Exit Conditions
    //  Too low nump numbers
    //  Less than eliptical limit.
    //  Too high loading or small for experience
    //  Less than 100 sqft for under 1000 jumps - non negotiable
    var reasoning = "REASONING \n";

    var Experience_MaxLoading = 1.3;
    var Experience_MinSize = 135;
    var experienceResult = ExperienceResult.WithinLimit;

    var isEliptical = IsFullyEliptical(CanopyType);

    if (TotalJump < 200) {
        reasoning = reasoning + "Below 200 limit - Not C License (FAST EXIT)<br>";
        localStorage.setItem(ls_reasoning,reasoning);

        return Result.Experience_TooLow;
    }


    if (TotalJump < ElipticalLimit && isEliptical) {
        reasoning = reasoning + "Below 300 limit for eliptical (FAST EXIT)<br>";
        localStorage.setItem(ls_reasoning,reasoning);

        return Result.Experience_BelowELipticalLimit;
    }


    //For experience get the limits.
    if (TotalJump >= 200 && TotalJump <= 300) {
        Experience_MaxLoading = 1.35;
        Experience_MinSize = 135;
    }
    else if (TotalJump > 300 && TotalJump <= 400) {
        Experience_MaxLoading = 1.4;
        Experience_MinSize = 135;
    }
    else if (TotalJump > 400 && TotalJump <= 500) {
        Experience_MaxLoading = 1.45;
        Experience_MinSize = 135;
    }
    else if (TotalJump > 500 && TotalJump <= 600) {
        Experience_MaxLoading = 1.5;
        Experience_MinSize = 120;
    }
    else if (TotalJump > 600 && TotalJump <= 700) {
        Experience_MaxLoading = 1.55;
        Experience_MinSize = 120;
    }
    else if (TotalJump > 700 && TotalJump <= 800) {
        Experience_MaxLoading = 1.6;
        Experience_MinSize = 120;
    }
    else if (TotalJump > 800 && TotalJump <= 900) {
        Experience_MaxLoading = 1.65;
        Experience_MinSize = 110;
    }
    else if (TotalJump > 900 && TotalJump <= 999) {
        Experience_MaxLoading = 1.7;
        Experience_MinSize = 100;
    }
    else if (TotalJump >= HiPerformanceNegotiableLimit) {
        if (CanopySize < 100 || WingLoading > 1.7)
        {
            experienceResult = ExperienceResult.Possible;            
        }
        else
        {
            experienceResult = ExperienceResult.WithinLimit;
            
        }
        Experience_MaxLoading = 1.7;
        Experience_MinSize = 100;
        
    }

    // Possible is only set for greater than 1000 jumps
    if (experienceResult != ExperienceResult.Possible) {
        //TODO: May remove this and just have it fail for out of limits
        if (TotalJump < NonNegotiableLimit) {
            if (CanopySize < 100) {
                reasoning = reasoning + "<br>" +
                "Total Jumps: " + TotalJump + "<br>" +
                "Past Year Jumps: " + JumpInYear + "<br>" +
                "Wing Loading: " + WingLoading + "<br>" +
                "Experience Min Size:   " + Experience_MinSize + "<br>" +
                "Experience MaxLoading: " + Experience_MaxLoading + "<br>";
                reasoning = reasoning + "Under 100 with less than 1000 jumps (REJECTED BASED UPON EXPERIENCE / FAST EXIT)<br>";
                localStorage.setItem(ls_reasoning, reasoning);
                return Result.CanopySize_Under100_NonNegotiable;
            }

            if (WingLoading > 1.7) {
                reasoning = reasoning + "<br>" +
                "Total Jumps: " + TotalJump + "<br>" +
                "Past Year Jumps: " + JumpInYear + "<br>" +
                "Wing Loading: " + WingLoading + "v" +
                "Canopy Size: " + CanopySize + "<br>" +
                "Experience Min Size:   " + Experience_MinSize + "<br>" +
                "Experience MaxLoading: " + Experience_MaxLoading + "<br>";
                reasoning = reasoning + "Exceeding 1.7 wingloading with less than 1000 jumps (REJECTED BASED UPON EXPERIENCE / FAST EXIT)<br>";
                localStorage.setItem(ls_reasoning, reasoning);
                return Result.CanopySize_TooSmallForExperience
            }
        }

        //Determine if jumper is within experience limits as we know what they are
        if (CanopySize < Experience_MinSize) {
            reasoning = reasoning + "<br>" +
                         "Total Jumps: " + TotalJump + "<br>" +
                         "Past Year Jumps: " + JumpInYear + "<br>" +
                         "Wing Loading: " + WingLoading + "<br>" +
                         "Canopy Size: " + CanopySize + "<br>" +
                         "Experience Min Size:   " + Experience_MinSize + "<br>" +
                         "Experience MaxLoading: " + Experience_MaxLoading + "<br>";
            reasoning = reasoning + "Too small for Experience (REJECTED BASED UPON EXPERIENCE)<br>";
            localStorage.setItem(ls_reasoning, reasoning);

            experienceResult = ExperienceResult.OutOfLimit;
            return Result.CanopySize_TooSmallForExperience;
        }
        if (WingLoading > Experience_MaxLoading) {
            reasoning = reasoning + "<br>" +
                            "Total Jumps: " + TotalJump + "<br>" +
                            "Past Year Jumps: " + JumpInYear + "<br>" +
                            "Wing Loading: " + WingLoading + "<br>" +
                            "Canopy Size: " + CanopySize + "<br>" +
                            "Experience Min Size:   " + Experience_MinSize + "v" +
                            "Experience MaxLoading: " + Experience_MaxLoading + "<br>";

            reasoning = reasoning + "Too high a loading for Experience (REJECTED BASED UPON EXPERIENCE)<br>";
            localStorage.setItem(ls_reasoning, reasoning);


            experienceResult = ExperienceResult.OutOfLimit;
            return Result.WingLoading_TooSmallForExperience;
        }
    }

    // At this point wehave eliminated based upon experience and fast exit conditions.
    //  We now need to determine if size is appropriate for currency
    var Currency_MaxLoading = 1.3;
    var Currency_MinSize = 135;

    //Determine Jump Currency based upon size
    if (CanopySize > 135)
        Currency_MinSize = 0;
    else if (CanopySize <= 135 && CanopySize > 120)
        Currency_MinSize = 50;
    else if (CanopySize <= 120 && CanopySize > 110)
        Currency_MinSize = 100;
    else if (CanopySize <= 110 && CanopySize > 100)
        Currency_MinSize = 200;
    else if (CanopySize <= 100)
        Currency_MinSize = 250;

    //Determine Jump Currency based upon wingloading
    if (WingLoading < 1.3)
        Currency_MaxLoading = 0;
    else if (WingLoading > 1.3 && WingLoading <= 1.35)
        Currency_MaxLoading = 50;
    else if (WingLoading > 1.35 && WingLoading <= 1.4)
        Currency_MaxLoading = 50;
    else if (WingLoading > 1.4 && WingLoading <= 1.45)
        Currency_MaxLoading = 100;
    else if (WingLoading > 1.45 && WingLoading <= 1.5)
        Currency_MaxLoading = 100;
    else if (WingLoading > 1.5 && WingLoading <= 1.55)
        Currency_MaxLoading = 200;
    else if (WingLoading > 1.55 && WingLoading <= 1.6)
        Currency_MaxLoading = 200;
    else if (WingLoading > 1.65 && WingLoading <= 1.65)
        Currency_MaxLoading = 200;
    else if (WingLoading > 1.65 && WingLoading <= 1.7)
        Currency_MaxLoading = 250;
    else if (WingLoading > 1.7)
        Currency_MaxLoading = 250;


    // Determine which is the higher Currency Limit (based upon size or loading)
    var Currency_JumpLimit;
    if (Currency_MinSize > Currency_MaxLoading)
        Currency_JumpLimit = Currency_MinSize;
    else
        Currency_JumpLimit = Currency_MaxLoading;


    // THe only time we get here is if we havent already reject because of experience
    // so experienceResult should be ok or possible
    if (JumpInYear >= Currency_JumpLimit) {
        if (experienceResult != ExperienceResult.Possible) {
            //OK
            reasoning = reasoning + "<br>" +
                            "Total Jumps: " + TotalJump + "<br>" +
                            "Past Year Jumps: " + JumpInYear + "<br>" +
                            "Wing Loading: " + WingLoading + "<br>" +
                            "Canopy Size: " + CanopySize + "<br>" +
                            "Experience Min Size:   " + Experience_MinSize + "<br>" +
                            "Experience MaxLoading: " + Experience_MaxLoading + "<br>" +
                            "Currency Jump For Equipment Canopy Size:   " + Currency_MinSize + "<br>" +
                            "Currency Jumps for Equipment Wing Loading : " + Currency_MaxLoading + "<br>" +
                            "Currency On Gear (whichever is higher): " + Currency_JumpLimit + "<br>";

            reasoning = reasoning + "CURRENCY: OK TO JUMP <br>";
            localStorage.setItem(ls_reasoning, reasoning);

            return Result.OK;
        }
        else {
            //POSSIBLE
            if (WingLoading >= 1.7 || CanopySize < 100) {
                reasoning = reasoning + "<br>" +
                                "Total Jumps: " + TotalJump + "<br>" +
                                "Past Year Jumps: " + JumpInYear + "<br>" +
                                "Wing Loading: " + WingLoading + "<br>" +
                                "Canopy Size: " + CanopySize + "<br>" +
                                "Experience Min Size:   " + Experience_MinSize + "<br>" +
                                "Experience MaxLoading: " + Experience_MaxLoading + "<br>" +
                                "Currency Jump For Equipment Canopy Size:   " + Currency_MinSize + "<br>" +
                                "Currency Jumps for Equipment Wing Loading : " + Currency_MaxLoading + "<br>" +
                                "Currency On Gear (whichever is higher): " + Currency_JumpLimit + "<br>";

                reasoning = reasoning + "CURRENCY: High Performance Exemption is Possible <br>";
                localStorage.setItem(ls_reasoning ,reasoning);

                return Result.HighPerformance_ExemptionPossible;
            }
        }
    }

    // Exceed limits based upon currency
    reasoning = reasoning + "<br>" +
                "Total Jumps: " + TotalJump + "<br>" +
                "Past Year Jumps: " + JumpInYear + "<br>" +
                "Wing Loading: " + WingLoading + "<br>" +
                "Canopy Size: " + CanopySize + "<br>" +
                "Experience Min Size:   " + Experience_MinSize + "<br>" +
                "Experience MaxLoading: " + Experience_MaxLoading + "<br>" +
                "Currency Jump For Equipment Canopy Size:   " + Currency_MinSize + "<br>" +
                "Currency Jumps for Equipment Wing Loading : " + Currency_MaxLoading + "<br>" +
                "Currency On Gear (whichever is higher): " + Currency_JumpLimit + "<br>";

    reasoning = reasoning + " CURRENCY: You are not able to jump this equipment (REJECTED BASED UPON CURRENCY)<br>";
    localStorage.setItem(ls_reasoning, reasoning);

    return Result.ExceedLimitsBasedUponCurrency;
}


//Generate Confirmation Letter



/// <summary>
/// Returns a list of strings for all the canopy names in alphabetic order
/// </summary>
/// <returns></returns>
function GetKnownCanopyList(CommonItem) {

    var Canopies = [];

    for (var i = 0; i < KnownCanopies.length; i++) {
        if (CommonItem != undefined) {
            if (CommonItem == KnownCanopies[i].IsCommon) {
                Canopies.push(KnownCanopies[i].Name);
            }            
        }
        else {
            Canopies.push(KnownCanopies[i].Name);
        }
        
    }
    return Canopies;
}

function PopulateCanopyDropdown(name) {
    //Get the control
    var control = document.getElementById(name);

    //Remove any existing entries
    for (i = 0; i < control.length; i++) {
        control.remove(i);
    }

 
    //Sort the array        
    var sorteditems = GetKnownCanopyList(true).sort();

    for (var i = 0; i < sorteditems.length; i++) {        
            var option = document.createElement("option");
            option.text = sorteditems[i];
            control.add(option);        
    }
    
    var option = document.createElement("option");
    option.text = "——————————————————————————";
    option.disabled = "disabled";
    control.add(option);
    
    sorteditems = GetKnownCanopyList(false).sort();
    for (var i = 0; i < sorteditems.length; i++) {        
            var option = document.createElement("option");
            option.text = sorteditems[i];
            control.add(option);        
    }
}

/// <summary>
/// Determines from name if the canopy is eliptical or not.
/// </summary>
/// <param name="name"></param>
/// <returns></returns>
function IsFullyEliptical(name) {
    var IsEliptical = false;  //Change default to false
    var found = false;
    if (name != undefined) {
        // Search List for Canopy and Iseliptical property
        for (var i = 0; i < KnownCanopies.length; i++) {
            if (KnownCanopies[i].Name.toLowerCase() === name.toLowerCase()) {
                return KnownCanopies[i].IsEliptical;
                found = true;

            }
        }

    }

    return found;
}

/// <summary>
/// Handles the odd size canopies which are slightly small and get rounded up.
/// ie.  the icarus 149 should be considered a 150
/// </summary>
/// <param name="CanopySize"></param>
/// <returns></returns>
function RoundUpSize(CanopySize) {

    if (CanopySize <= 0 || CanopySize >= 400) {
        return 0
    }

    //If the canopy size ends in a 9 then round up.
    //ie. 149 -> 150        
    var s = CanopySize.toString();

    if (s.slice(s.length - 1, s.length) !== "9") {
        return CanopySize;
    }
    else {
        return CanopySize + 1;
    }
}


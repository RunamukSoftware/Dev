test("will add 5 to number", function () {
    var res = mathLib.add5(10)
    equal(res, 15, "should add 5");
});



test("Verify iseliptical Function with known eliptical", function () {

    var x = IsFullyEliptical("Performance Designs Stilleto");

    equal(x, true, "Expected value was produced");
});


test("Verify iseliptical Function with known eliptical Incorrect case", function () {

    var x = IsFullyEliptical("Performance Designs STILLETO");

    equal(x, true, "Expected value was produced");
});


test("Verify iseliptical Function with known eliptical", function () {

    var x = IsFullyEliptical("Performance Designs Sabre");

    equal(x, false, "Expected value was produced");
});


test("Verify iseliptical Function with unknown eliptical", function () {

    var x = IsFullyEliptical("XZYZ");

    equal(x, false, "Expected value was produced");
});


// ************************************************************************************************

test("Verify known canopies returns correct count", function () {

    var x = GetKnownCanopyList();
    equal(x.length, 100, "Expected value was produced");
});

// ************************************************************************************************

test("Roundup ends with a 9", function () {

    var x = RoundUpSize(149);
    equal(x, 150, "Expected value was produced");
});

test("Roundup does not ends with a 9", function () {

    var x = RoundUpSize(120);
    equal(x, 120, "Expected value was produced");
});

test("Roundup is negative not ends with a 9", function () {

    var x = RoundUpSize(-120);
    equal(x, 0, "Expected value was produced");
});

test("Roundup is negative ends with a 9", function () {

    var x = RoundUpSize(-129);
    equal(x, 0, "Expected value was produced");
});

test("Roundup is out of range too big", function () {

    var x = RoundUpSize(1000);
    equal(x, 0, "Expected value was produced");
});
// ************************************************************************************************
test("OK For Experience Non Eliptical Canopy", function () {
    var x = ValidateEntries(299, 299, "Performance Designs Sabre", 150, 150, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("OK For Experience Eliptical Canopy", function () {

    var x = ValidateEntries(399, 399, "Performance Designs Velocity", 150, 150, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});


test("Not OK For Experience Eliptical Canopy", function () {

    var x = ValidateEntries(299, 299, "Performance Designs Velocity", 150, 150, "a", "a@b.com");
    equal(x, Result.Experience_BelowELipticalLimit, "Expected value was produced");
});


test("Not OK For Experience Eliptical Canopy  Unknown canopy", function () {
    //As we don't know the canopy we assume its non-eliptical and this will then be OK
    var x = ValidateEntries(299, 299, "Performance Designs ssss", 150, 150, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

// ************************************************************************************************

test("Real World - 1200/600 Jumps Sabre 99  120lb", function () {
    // Meet eliptical requirements
    // Meet 1000+ jumps for high performance
    // Meet currency requirements
    // wingloading does not exceed 1.7
    // size is less the 100
    // should be exemption

    var x = ValidateEntries(1200, 600, "Performance Designs Sabre", 99, 120, "a", "a@b.com");
    equal(x, Result.HighPerformance_ExemptionPossible, "Expected value was produced");
});

test("Real World - 500/300 Jumps Vengeance(Eliptical) 150 120lb", function () {
    //As we don't know the canopy we assume its non-eliptical and this will then be OK
    var x = ValidateEntries(500, 300, "Performance Designs Vengeance", 150, 150, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});


test("Real World - 201/201 Jumps Sabre 150 150lb - OK", function () {
    //As we don't know the canopy we assume its non-eliptical and this will then be OK
    var x = ValidateEntries(201, 201, "Performance Designs Sabre", 150, 150, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("Real World - 201/201 Jumps Sabre 150 150lb - Fails Size For Experience", function () {
    // Meets Experience Wing Loading and Size Requirements
    // Meets Currency Requirments
    var x = ValidateEntries(201, 40, "Performance Designs Sabre", 120, 120, "a", "a@b.com");
    equal(x, Result.CanopySize_TooSmallForExperience, "Expected value was produced");
});


test("Real World - 201/60 Jumps Sabre 150 220lb -Fails Wing Loading", function () {
    // Meets Experience Wing Loading and Size Requirements
    // Meets Currency Requirments
    var x = ValidateEntries(201, 60, "Performance Designs Sabre", 150, 220, "a", "a@b.com");
    equal(x, Result.WingLoading_TooSmallForExperience, "Expected value was produced");
});

test("Real World - 302/100 Jumps Vengeance 150 160lb - OK ", function () {
    var x = ValidateEntries(302, 100, "Performance Designs Vengeance", 150, 160, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("Real World - 302/100 Jumps Sabre 120 120lb - Too Small for Experience ", function () {
    var x = ValidateEntries(302, 100, "Performance Designs Sabre", 120, 120, "a", "a@b.com");
    equal(x, Result.CanopySize_TooSmallForExperience, "Expected value was produced");
});



test("Real World - 302/100 Jumps Sabre 150 220lb - Too high wingloading for experience", function () {
    var x = ValidateEntries(302, 100, "Performance Designs Sabre", 150, 220, "a", "a@b.com");
    equal(x, Result.WingLoading_TooSmallForExperience, "Expected value was produced");
});



test("Real World - 302/110 Jumps Sabre 110 110lb - OK", function () {
    //Meets wingloading and currency requirements
    var x = ValidateEntries(302, 110, "Performance Designs Sabre", 110, 110, "a", "a@b.com");
    equal(x, Result.CanopySize_TooSmallForExperience, "Expected value was produced");
});



test("Real World - 1002/300 Jumps Sabre 89 120lb - Exemption Possible", function () {
    var x = ValidateEntries(1002, 300, "Performance Designs Sabre", 89, 120, "a", "a@b.com");
    equal(x, Result.HighPerformance_ExemptionPossible, "Expected value was produced");
});

test("Real World - 200/150 Jumps Sabre 150 150lb - OK", function () {
    var x = ValidateEntries(200, 150, "Performance Designs Sabre", 150, 150, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("Real World - 402/200 Jumps Sabre 120 120lb - OK", function () {
    var x = ValidateEntries(400, 200, "Performance Designs Sabre", 120, 120, "a", "a@b.com");
    equal(x, Result.CanopySize_TooSmallForExperience, "Expected value was produced");
});


test("Real World - 402/200 Jumps Sabre 120 120lb - OK", function () {
    var x = ValidateEntries(402, 200, "Performance Designs Sabre", 150, 220, "a", "a@b.com");
    equal(x, Result.WingLoading_TooSmallForExperience, "Expected value was produced");
});



// FALLBACK TO CURRENCY 
test("Real World - 802/251 Jumps Sabre 150 195lb - OK", function () {
    //    //Meets loading on experience but fails on currency
    //    //802 would allow a 110, 1.65
    //    //but 251 jumps in year would exceeds current so can jump at this level            

    var x = ValidateEntries(802, 251, "Performance Designs Sabre", 150, 195, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("Real World - 802/51 Jumps Sabre 120 195lb - Fails Currency", function () {
    //    //Meets loading on experience but fails on currency
    //    //802 would allow a 110, 1.65
    //    //but 51 jumps in year would put loading at 135 and 1.4
    //    //If meet this 135 and 1.4 then good
    var x = ValidateEntries(802, 51, "Performance Designs Sabre", 120, 195, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});


test("Real World - 802/51 Jumps Sabre 135 195lb - Fails Currency", function () {
    //    //Meets loading on experience but fails on currency
    //    //802 would allow a 110, 1.65
    //    //but 51 jumps in year would put loading at 135 and 1.4
    //    //If meet this 135 and 1.4 then good
    var x = ValidateEntries(802, 51, "Performance Designs Sabre", 135, 195, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});


test("Real World - 732/75  Jumps Sabre 120  wl:1.5 - Fails Currency", function () {
    var desired_wl = 1.5;
    var canopysize = 120;
    var experience = 732;
    var currency = 75;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});

test("Real World - 615/135  Jumps Sabre 120  wl:1.47 - Fails Currency", function () {
    var experience = 615;
    var desired_wl = 1.47;
    var canopysize = 135;
    var currency = 75;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});


test("Real World - 537/58 Jumps Sabre 120  wl:1.4 - OK", function () {
    var experience = 537;
    var desired_wl = 1.4;
    var canopysize = 135;
    var currency = 58;
    var weight = desired_wl * canopysize;


    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});



test("Real World - 950/100 Jumps Sabre 120  wl:1.5 - OK", function () {
    var experience = 950;
    var desired_wl = 1.5;
    var canopysize = 120;
    var currency = 100;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});


test("Real World - 732/150 Jumps Sabre 120  wl:1.2 - OK", function () {
        var experience = 732;
        var desired_wl = 1.3;
        var canopysize = 120;
        var currency = 150;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});



test("Real World - 431/150 Jumps Sabre 135  wl:1.35 - OK", function () {
        var experience = 431;
        var desired_wl = 1.35;
        var canopysize = 150;
        var currency = 75;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("Real World - 550/51 Jumps Sabre 135  wl:1.4 - OK", function () {
        var experience = 550;
        var desired_wl = 1.4;
        var canopysize = 135;
        var currency = 51;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});


test("Real World - 575/75 Jumps Sabre 120  wl:1.7 - Fail Currency", function () {
    var experience = 575;
    var desired_wl = 1.47;
    var canopysize = 120;
    var currency = 75;
    var weight = desired_wl * canopysize;
    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});


test("Real World - 631/100 Jumps Sabre 120  wl:1.6 - Fail Experience Too Small", function () {
        var experience = 631;
        var desired_wl = 1.6;
        var canopysize = 120;
        var currency = 100;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.WingLoading_TooSmallForExperience, "Expected value was produced");
});

test("Real World - 631/100 Jumps Sabre 120  wl:1.5 - OK", function () {
        var experience = 631;
        var desired_wl = 1.5;
        var canopysize = 120;
        var currency = 100;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("Real World - 497/75 Jumps Sabre 135  wl:1.4 - OK", function () {
        var experience = 497;
        var desired_wl = 1.4;
        var canopysize = 135;
        var currency = 75;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});


test("Real World - 533/75 Jumps Sabre 135  wl:1.4 - OK", function () {
        var experience = 533;
        var desired_wl = 1.4;
        var canopysize = 135;
        var currency = 75;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});



test("Real World - 910/100 Jumps Sabre 110  wl:1.6 - Fail Currency", function () {
    var experience = 910;
    var desired_wl = 1.6;
    var canopysize = 110;
    var currency = 100;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});

test("Real World - 805/100 Jumps Sabre 120  wl:1.55 - Fail Currency", function () {
        var experience = 805;
        var desired_wl = 1.55;
        var canopysize = 120;
        var currency = 100;
        var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});



test("Real World - 790/125 Jumps Sabre 120  wl:1.6 - Fail Currency", function () {
    var experience = 790;
    var desired_wl = 1.6;
    var canopysize = 120;
    var currency = 125;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});




test("Real World - 650/50 Jumps Sabre 120  wl:1.55 - Fail Currency", function () {
    var experience = 650;
    var desired_wl = 1.55;
    var canopysize = 120;
    var currency = 50;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});


test("Real World - 790/50 Jumps Sabre 120  wl:1.55 - Fail Currency", function () {
    var experience = 790;
    var desired_wl = 1.55;
    var canopysize = 120;
    var currency = 100;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});

test("Real World - 790/200 Jumps Sabre 120  wl:1.55 - OK", function () {
    var experience = 790;
    var desired_wl = 1.55;
    var canopysize = 120;
    var currency = 200;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Sabre", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});

test("Real World - 400/50 Jumps Lightning 135  wl:1.2 - OK", function () {
    var experience = 400;
    var desired_wl = 1.2;
    var canopysize = 135;
    var currency = 50;
    var weight = desired_wl * canopysize;

    var x = ValidateEntries(experience, currency, "Performance Designs Lightning", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});


test("Real World - 700/100 Jumps Precision Raven wl:1.45 - OK", function () {
    var experience = 700;
    var desired_wl = 1.45;
    var canopysize = 135;
    var currency = 100;
    var weight = desired_wl * canopysize;
    var x = ValidateEntries(experience, currency, "Precision Raven", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});




test("Real World - 337/33 Jumps Diablo 150  wl:1.1 - OK", function () {
    var experience = 337;
    var desired_wl = 1.1;
    var canopysize = 150;
    var currency = 154;
    var weight = desired_wl * canopysize;
    var x = ValidateEntries(experience, currency, "Aerodyne Diablo", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK, "Expected value was produced");
});


test("Real World - 1001/333 Jumps VX 101 l.78 - High Performance Possible", function () {
    var experience = 1001;
    var desired_wl = 1.78;
    var canopysize = 101;
    var currency = 333;
    var weight = desired_wl * canopysize;
    var x = ValidateEntries(experience, currency, "Icarus Extreme VX", canopysize, weight, "a", "a@b.com");
    equal(x, Result.HighPerformance_ExemptionPossible, "Expected value was produced");
});

test("Real World - 1001/133 Jumps VX 101 l.78 - Fail currency", function () {
    var experience = 1001;
    var desired_wl = 1.78;
    var canopysize = 101;
    var currency = 133;
    var weight = desired_wl * canopysize;
    var x = ValidateEntries(experience, currency, "Icarus Extreme VX", canopysize, weight, "a", "a@b.com");
    equal(x, Result.ExceedLimitsBasedUponCurrency, "Expected value was produced");
});


test("Real World - 1001/133 Jumps FX 101 1.2 - OK", function () {
    var experience = 1001;
    var desired_wl = 1.2;
    var canopysize = 123;
    var currency = 333;
    var weight = desired_wl * canopysize;
    var x = ValidateEntries(experience, currency, "Icarus Extreme FX", canopysize, weight, "a", "a@b.com");
    equal(x, Result.OK , "Expected value was produced");
});


test("Real World - 987/271 Jumps Diablo 120 1.8 - Reject Non Negotiable Limit Wing load above 1.7", function () {
    var experience = 987;
    var desired_wl = 1.8;
    var canopysize = 120;
    var currency = 271;
    var weight = desired_wl * canopysize;
    var x = ValidateEntries(experience, currency, "Aerodyne Diablo", canopysize, weight, "a", "a@b.com");
    equal(x, Result.CanopySize_TooSmallForExperience, "Expected value was produced");
});
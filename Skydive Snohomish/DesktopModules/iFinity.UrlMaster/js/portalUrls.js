//------------------
//Portal Urls js file
//Url Master 2.0 UI
//9th April 2010
//mods
// brc 3/3/2011 - change optUseAlias handling for initial page load to fix bug 800
// brc 3/5/2011 - add in hidden field to capture selected portal alias for asp.net 4.0
// brc 3/7/2011 - add in new module providers tab handling
// brc 6/12/2011 - fix up errors with not saving removed tabs / incorrect tr row toggling from clicks
//-------------------

//main jquery handler for page
jQuery(document).ready(function($){

    //main page loading function
    pageUrlsPageLoad();

});//end main jquery handler for page

function pageUrlsPageLoad()
{
    //onload actions
    var tabIndex = selectedTabIndex;
        jQuery("#tabs").tabs();
        jQuery("#tabs").bind('tabsshow', function(event, ui){
            //this gets called on the click of a different tab
            if (ui.index != tabIndex)
                bindCurrentTabEvents(ui.index);
        });

        bindCurrentTabEvents(tabIndex); //run load procedure for current tab
        
        enableUpdatePanelHandler(); //keep tabs index when updatepanel does partial postback
        
        checkValidators();  //turns validators on and off depending on current settings
        
        //set the validator on/off depending on value
        var val = jQuery("[name$='$optUserProfileAction']:checked");
        showUserProfileControls(val);

        //make alias Option behave as normal option group
        //800 : force setting of current 'name' to match that of currently selected option
        //reason: asp.net uses the 'name' value to group options together, but this 
        //doesn't work when options are inserted via a repeater
        jQuery("[name$='$optUseAlias']").attr("name", jQuery("[name$='$optUseAlias']:checked").attr("name"));
        //link up the click function to do the same if the value is clicked
        jQuery("[name$='$optUseAlias']").change(function (event) {
            //set name for all to name of clicked
            //825 : save selected value into hidden field
            //909 : cross browser changes to get Id
            var clickedId = (event.currentTarget.id) ? event.currentTarget.id : event.srcElement.id;
            jQuery("[name$='$hdnSelectedAlias']").val(clickedId);
            var clickedName = clickedId.replace('_', '$'); //replace _ with $
            //use regex value to remove ctl0x and _0x from id to create 'name' attribute.  This ensures the group
            //acts as a list of radio buttons instead of individual buttons.
            var re = new RegExp(/(\$ctl\d+)?(\$[\w]+)(\$\d+)?$/); //create regexp for replace of $ctl01$ with $
            var clickedName = clickedName.replace(re, "$2");
            jQuery("[name$='$optUseAlias']").attr("name", clickedName);
        });

        
        //space replacement option
        jQuery("[name$='$chkReplaceSpaces']").change(function()
            {
                //if checked, hide text box
                var tb = jQuery("[name$='$txtReplaceSpaceWith']")
                if (this.checked == true)
                    tb.show();
                else
                {
                    tb.hide('slow');
                    tb.val("");
                    }
            });
        
        //portal lias handling
        jQuery("[name$='$optPortalAliasUsage']").change(function()
        {
            var val = jQuery("[name$='$optPortalAliasUsage']:checked");
            showAliasControls(val);    
        });
        //page extension handling
        jQuery("[name$='$optPageExtensionUsage']").change(function ()
        {
            var val = jQuery("[name$='$optPageExtensionUsage']:checked");
            showPageExtensionHandling(val, true);
        });
        //404/Error Handling options
        jQuery("[name$='$opt404Handling']").change(function()
        {
            var val = jQuery("[name$='$opt404Handling']:checked");
            show404Controls(val);    
        });
        
        //500 Error Handling options
        jQuery("[name$='$opt500Handling']").change(function()
        {
            var val = jQuery("[name$='$opt500Handling']:checked");
            show500Controls(val); 
        });
        //user profile handling options
        jQuery("[name$='$optUserProfileAction']").change(function()
        {
            var val = jQuery("[name$='$optUserProfileAction']:checked");
            showUserProfileControls(val);
            checkValidators();
        });
        //770 : custom portal alias handling
        jQuery("[name$='$optCustomPortalAliasUsage']").change(function() {
            var val = jQuery(this).parent().find("[name$='$optCustomPortalAliasUsage']:checked");
            showAliasDropDown(val);
        });

        jQuery(".showHide").click(function() {
            var val = jQuery(this).parent().parent().find(".portalAliasUsage");
            showHidePortalAliasUsage(val, jQuery(this));
            return false;
        });

        // module providers pageload functions
        //hover over rows
        jQuery('.moduleProvidersTable').delegate('tr', 'mouseenter', function (event) {
            var editTr = jQuery(this);
            var cssclass = jQuery(event.target).attr('class');
            
            var nodeName = event.target.nodeName.toLowerCase();
            if (cssclass != undefined && (cssclass.indexOf("mpseltabdel") > -1 || cssclass.indexOf('mpseltabstab') > -1 || cssclass.indexOf('mpalltabs') > -1)) {
                //this is a mouseneter/click on the actual tab object
            }
            else {
                editMpRow(editTr);
            }
            
        });
        jQuery('.moduleProvidersTable').delegate('tr', 'mouseleave', function () {
            var editTr = jQuery(this);
            if (editTr.length)
                doneEditMpRow(editTr);
        });
        //find hidden tab selection field
        var hdnPageDetails = jQuery('#hdnPageDetails');
        hdnPageDetails.change(function () {
            //what do we do when the page is changed??
        });
        //click event when 'get tab' is clicked
        jQuery('.mpgettab').click(function () {
            //copy this tab over to current selected provider
            var hdnPageDetails = jQuery('#hdnPageDetails');
            if (hdnPageDetails.length) {
                var tabid = getTabId(hdnPageDetails);
                var tabName = getPageName(hdnPageDetails);
                var tabsList = jQuery(this).parent().parent().parent().last().find('.mpseltabs');
                if (tabsList.length) {
                    buildAndHookSelTabListItem(tabid, tabName, tabsList);
                }
            }
            return false;
        });
        //hook actions to selected tabs list
        hookSelTabsActions();
        
    }
    //adds a list item to the list of selected tabs, and hooks events for that list item
    function buildAndHookSelTabListItem(tabid, tabName, tabsList) {
        if (tabid == undefined || tabid == '') {
            //no tab selected, show message
            var hdnNoTabSel = jQuery("[name$='$hdnNoTabSel']");
            if (hdnNoTabSel.length)
                alert(hdnNoTabSel.val());
        }
        else {
            var exists = false;
            //get the ul
            var liItems = jQuery(tabsList).find('li');
            if (liItems.length) {
                liItems.each(function (index) {
                    var id = jQuery(this).attr('id');
                    if (id == tabid) {
                        exists = true;
                        return false;
                    }
                });
            }
            if (exists == false) {
                //add to list
                tabsList.append('<li id=\'' + tabid + '\' class=\'mpseltabslistitem\'><span class=\'mpseltabstab\'><a href=\'#\' class=\'mpseltabdel\'>x</a>' + tabName + '</span></li>');
                hookSelTabsActions();
                //now add to hidden details for tabid
                var hdnTabs = tabsList.parent().find(':input:hidden');
                if (hdnTabs.length) {
                    //add this tabid to the list
                    var list = addValToList(hdnTabs.val(), tabid);
                    hdnTabs.val(list); //set new val
                }
                //now find the 'alltabs' item, and hide it if it's there
                var allTabs = tabsList.parent().parent().find('.mpalltabs');
                if (allTabs.length) {
                    allTabs.hide();
                }
            } 
        }
    }
    function hookSelTabsActions() {
        //click on 'delete' for module provider tab selection
        //unbind old clicks to stop double event firing
        jQuery('.mpseltabdel').unbind('click').click(function (event) {
            //stop bubbling up on the event
            event.stopPropagation();
            //get id of clicked item
            var li = jQuery(this).parent().parent();
            if (li.length) {
                var id = li.attr('id');
                var hdnTabs = li.parent().parent().find(':input:hidden');
                if (hdnTabs.length) {
                    //remove from tabids
                    var list = remValFromList(hdnTabs.val(), id);
                    hdnTabs.val(list);
                    //remove from list
                    var ul = li.parent();
                    ul.find('#' + id).remove();
                    //check if ul has no children
                    if (ul.find('li').length == 0) {
                        //now find the 'alltabs' item, and show it if it's there
                        var allTabs = ul.parent().parent().find('.mpalltabs');
                        if (allTabs.length) {
                            allTabs.show();
                        }
                    }
                }
            }
            return false;
        });
        jQuery('.mpseltabdel').delegate('span', 'mouseenter mouseleave', function () {
            jQuery(this).toggleClass('mpseltabhover');
        });

    }
    //safely adds a value to a list and retursn the new list
    //assumes comma separated, does not duplicate
    function addValToList(list, val) {
        //split list into array
        var arr = list.split(',');
        //iterate through the list
        var found = false;
        for (i=0;i<=arr.length -1;i++)
        {
            var fndVal = arr[i];
            //compare items with value
            if (fndVal == val) {
                found = true;
                break;
            }
        }
        if (found == false) {
            //not found, add to array and return
            arr.push(val);
            list = arr.join(',');
        }
        return list;
    }
    //safely removes an item from a list if it exists
    //returns the list without the val in it
    function remValFromList(list, val) {
        //split list into array
        var arr = list.split(',');
        var newArr = new Array();
        //iterate through the list and make new list
        for (i = 0; i <= arr.length - 1; i++) {
            var fndVal = arr[i];
            //compare items with value and
            //add to new array if not matched
            //create a remove value which doesn't have
            //the 't' prefix of the control Id
            var rmvVal = val.replace("t", "");
            if (fndVal != val && fndVal != rmvVal) {
                newArr.push(fndVal);
            }
        }
        return newArr.join(',');
    }
    function getPageName (hdnPageDetails) {
            var details = hdnPageDetails.val();
            var vars = details.split(':', 2);
            var id = vars[0];
            var name = vars[1];
            return name;
        }
    function getTabId (hdnPageDetails) {
            var details = hdnPageDetails.val();
            var vars = details.split(':', 1);
            var id = vars[0];
            return id;
        }
    //editMpRow - puts a row into edit mode
    function editMpRow(editTr) {
        //set parent tr into permanent edit background
        editTr.toggleClass('tredit');
        //td into edit mode
        editTr.find('td').toggleClass('tdedit');
        //last td into edit td end
        var lasttd = editTr.find('td:last');
        //first td into edit td start
        var firsttd = editTr.find('td:first');
        if (lasttd.length) {
            lasttd.toggleClass('tdlastedit');
            }
        if (firsttd.length) {
            firsttd.toggleClass('tdfirstedit');
            }
        
        //show tab copy link
        editTr.find('.mptabcopy').show();
        //providerTabs out of edit mode
        jQuery('.providerTabs').toggleClass('providerTabsEdit');
    }
    function doneEditMpRow(doneTr) {
        //change back class into non-edit mode
        //set parent tr into permanent edit background
        doneTr.toggleClass('tredit');
        //td into edit mode
        doneTr.find('td').toggleClass('tdedit');
        //last td into edit td end
        var lasttd = doneTr.find('td:last');
        //first td into edit td start
        var firsttd = doneTr.find('td:first');
        if (lasttd.length) {
            lasttd.toggleClass('tdlastedit');
        }
        if (firsttd.length) {
            firsttd.toggleClass('tdfirstedit');
        }

        //hide tab copy link
        doneTr.find('.mptabcopy').hide();
        //not in edit mode
        jQuery('.providerTabs').toggleClass('providerTabsEdit');
    }

function bindCurrentTabEvents(tabIndex)
{
    switch (tabIndex)
    {
        case -1:
            togglePageUrlsControls(false);//show/hide on first load
            break;
        case 0:
            break;
        case 1://portalSettings
            var valAliasHandling = jQuery("[name$='$optPortalAliasUsage']:checked");
            showAliasControls(valAliasHandling);
            var userProfileHandling = jQuery("[name$='$optUserProfileAction']:checked");
            showUserProfileControls(userProfileHandling);
            var pageExtHandling = jQuery("[name$='$optPageExtensionUsage']:checked");
            showPageExtensionHandling(pageExtHandling, false);
            break;
        case 2:// 404 error handling
            var val404Handling = jQuery("[name$='$opt404Handling']:checked");
            show404Controls(val404Handling);    
            var val500Handling = jQuery("[name$='$opt500Handling']:checked");
            show500Controls(val500Handling);    
            break;
        case 3:
            showAdvancedSettings();
            break;
        case 4:
            //module provider settings
            break;
        case 5:
        //regex settings
            break;
        case 6:
            showTestUrlSettings();
            break;
    }
}
//global var for remembeing which tab we were on across postbacks
var selectedTabIndex=-1; var pageLoaded=0;  var pageExpanded=false;
function enableUpdatePanelHandler()
{
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    if (prm != null)
    {
        //register the end and begin request handler events
        prm.add_endRequest(EndRequestHandler);
        prm.add_beginRequest(BeginRequestHandler);
    }
}
/// begin request event handler - triggered by MS ajax scriptmanager
function BeginRequestHandler(sender, args) 
{
    if (pageLoaded == 0)
    {
        pageLoaded = 1;
        var tabs = jQuery("#tabs").tabs();
        selectedTabIndex = tabs.tabs('option', 'selected');
        pageExpanded = jQuery(".hideLink").is(":visible");
        pageLoaded = 2;
    }
} 
/// end request event handler - triggered by MS ajax scriptmanager
function EndRequestHandler(sender, args) 
{
    if (pageLoaded > 1)
    {
        var tabs = jQuery("#tabs").tabs();
        tabs.tabs('select', selectedTabIndex);
        pageUrlsPageLoad();//run the page load routine
        //re-hook tabSingleSelect events after postback
        if (selectedTabIndex == 0 || selectedTabIndex == 6 || selectedTabIndex == 1 || selectedTabIndex == 2)
            ifty_tss.reHookAllEvents();
        if (selectedTabIndex == 6)
            showTestUrlSettings();
        //show / hide the page urls detail depending on what was already selected
        togglePageUrlsControls(pageExpanded);
        //rehook custom portal alias handling
        jQuery("[name$='$optCustomPortalAliasUsage']").change(function() {
            var val = jQuery(this).parent().find("[name$='$optCustomPortalAliasUsage']:checked");
            showAliasDropDown(val);
        });
        //rehook show/hide for custom portal alias usage
        /*jQuery(".showHide").click(function() {
            var val = jQuery(this).parent().parent().find(".portalAliasUsage");
            showHidePortalAliasUsage(val);
            return false;
        });*/
        pageLoaded = 0;//set back to initial state
    }
}
//shows/hides the page detailshost
function togglePageUrlsControls(show)
{
    //bind the click event
    jQuery('#toggleLink').click(function() {
        var visible = jQuery('.tabFieldOption').is(':visible');
        if (visible)
        {
            //hide
            hidePageDetails();
        }
        else
        {
            //show
            showPageDetails();
        }
        return false;
    });
    
    if (!show)
    {
        //start by hiding if not instructed to show
        jQuery('.tabFieldOption').hide();
        jQuery('.showLink').show();
        jQuery('.hideLink').hide();
    }
}
function hidePageDetails()
{
    jQuery('.tabFieldOption').hide('slow');//toggle the rows to display/hide
    jQuery('.showLink').show();
    jQuery('.hideLink').hide();

}
function showPageDetails()
{
    jQuery('.tabFieldOption').show('fast');//toggle the rows to display/hide
    jQuery('.showLink').hide();//toggle the show
    jQuery('.hideLink').show();//toggle the hide

}
//770 : controls for showing the custom portal alias drop down
//toggles the alias drop down box on / off depending on selection
function showAliasDropDown(val) {
    //locate the accompanying drop down list
    var ddlAlias = val.parent().parent().parent().parent().parent().parent().find("[name$='$ddlAlias']");
    var lblScheme = val.parent().parent().parent().parent().parent().parent().find(".httpScheme")
    //locate the portal alias label
    var lblAlias = val.parent().parent().parent().parent().parent().parent().find(".httpAlias")
    
    switch (val.val()) {
        case "0": // default ; disable drop down
        case "3": // same as parent (inherited)
            ddlAlias.hide();
            lblScheme.hide();
            lblAlias.show();
            break;
        case "1":  //page and child pages
        case "2": //only this page
            ddlAlias.show();
            lblScheme.show();
            lblAlias.hide();
            break;
    }
}
//770 : shows/hides the portal alias usage div
function showHidePortalAliasUsage(val, link) {
    var visible = val.is(':visible');
    var showHide = link.parent().parent().find('.showHideCont');
    if (visible) {
        val.hide();
        showHide.addClass('showHideUp');
        showHide.removeClass('showHideDown');
    }
    else {
        val.show();
        showHide.addClass('showHideDown');
        showHide.removeClass('showHideUp');
    }
}
function showAliasControls(val)
{
    var aliasCultureEls = jQuery(".aliasCultureList");
    var aliasCultureHdrELs = jQuery(".aliasCultureListHdr");
    var aliasCheckEls = jQuery(".aliasCheck");
    var aliasCheckHdrEls = jQuery(".aliasCheckHdr");
    var aliasOptHdrEls = jQuery(".aliasOptHdr");
    var aliasOptionEls = jQuery(".aliasOption");
    //737 : browserType browser option
    var aliasBrowserTypeEls = jQuery(".aliasBrowserType");
    var aliasBrowserTypeHdrEls = jQuery(".aliasBrowserTypeHdr");
    //852 : alias skin settings
    var aliasSkinHdrEls = jQuery(".aliasSkinHdr");
    var aliasSkinEls = jQuery(".aliasSkin");
    switch (val.val())
    {
        case "Any":
            aliasCheckEls.hide();
            aliasCheckHdrEls.hide();
            aliasOptionEls.hide();
            aliasOptHdrEls.hide();
            aliasCultureEls.hide();
            aliasCultureHdrELs.hide();
            aliasBrowserTypeEls.hide();
            aliasBrowserTypeHdrEls.hide();
            aliasSkinEls.hide();
            aliasSkinHdrEls.hide();
            break;
        case "One":
            aliasCheckHdrEls.hide();
            aliasCheckEls.hide();
            aliasOptHdrEls.show();
            aliasOptionEls.show();
            aliasCultureEls.hide();
            aliasCultureHdrELs.hide();
            aliasBrowserTypeEls.hide();
            aliasBrowserTypeHdrEls.hide();
            aliasSkinEls.hide();
            aliasSkinHdrEls.hide();
            break;
        case "Culture":
            aliasCheckEls.show();
            aliasCheckHdrEls.show();
            aliasOptionEls.hide();
            aliasOptHdrEls.hide();
            aliasCultureEls.show();
            aliasCultureHdrELs.show();
            aliasBrowserTypeEls.show();
            aliasBrowserTypeHdrEls.show();
            aliasSkinEls.show();
            aliasSkinHdrEls.show();
            break;
    }
}
function showPageExtensionHandling(val, fromClick)
{
    var pageExt = jQuery("#pageExtension");
    var tb = jQuery("[name$='$txtPageExtension']");
    switch (val.val())
    {
        case "Always":
            pageExt.show();
            if (tb.val()=="")
                tb.val(".aspx");
            break;
        case "Never":
            pageExt.hide('slow');
            tb.val("");
            if (fromClick)
                showPageExtensionWarning(val);
            break;
        case "PageOnly":
            pageExt.show();
            if (tb.val()=="")
                tb.val(".aspx");
            if (fromClick)
                showPageExtensionWarning(val);

            break;
    }
}
function showPageExtensionWarning(val) {
    //862: dnn6 changes to dialog
    jQuery('.pageExtDialog').dialog({ modal: true, dialogClass:'umdialog', buttons: { "Ok": function () { jQuery(this).dialog("close"); } } });
    
}
function showDefaultRedirectWarning() {
    //862: dnn6 changes to dialog
    jQuery('.defaultRedirectDialog').dialog({ modal: true, dialogClass:'umdialog', buttons: { "Ok": function () { jQuery(this).dialog("close"); } } });
 
}
function showAdvancedSettings()
{
    //setup dialog warning on click of checkbox
    jQuery("[name$='$chkRedirectDefaultPage']").change( function () 
    { 
        if (jQuery(this).is(':checked'))
            showDefaultRedirectWarning(); 
    });
}
function show404Controls(val)
{
    var tabs404 = jQuery("#404Tabs");
    var url404 = jQuery("#404Url");
    var regex404 = jQuery("#404Regex");
    if (val.val() == "404Tab")
    {
        tabs404.show('fast');
        url404.hide('slow');
        regex404.hide('slow');
    }
    else
    {
        if (val.val() == "404Url")
        {
            tabs404.hide('slow');
            url404.show('fast');
            regex404.hide('slow');
        }
        else
        {
            if (val.val() == "404UrlRegex")
            {
                tabs404.show('fast');
                url404.show('fast');
                regex404.show('fast');
            }
            else
            {
                tabs404.hide('slow');
                url404.hide('slow');
                regex404.hide('slow');
            }
         }
     }
}
function show500Controls(val)
{
    var tabs500 = jQuery("#500Tabs");
    var url500 = jQuery("#500Url");
    var regex500 = jQuery("#500Regex");
    if (val.val() == "500Tab")
    {
        tabs500.show('fast');
        url500.hide('slow');
    }
    else
    {
        if (val.val() == "500Url")
        {
            tabs500.hide('slow');
            url500.show('fast');
        }
        else
        {
            if (val.val() == "500UrlRegex")
            {
                tabs500.show('fast');
                url500.show('fast');
            }
            else
            {
                tabs500.hide('slow');
                url500.hide('slow');
            }
         }
     }
}
function showUserProfileControls(val)
{
    var upTabs = jQuery('#userProfileTab');
    var upType = jQuery('#userProfileType');
    var upParm = jQuery('#userProfileParameter');
    var upRdir = jQuery('#userProfileRedirect');
    
    switch (val.val())
    {
        case "None":
            upTabs.hide('slow');
            upType.hide('slow');
            upParm.hide('slow');
            upRdir.hide('slow');
            break;
        case "AllTabs":
            upTabs.hide('slow');
            upType.show('fast');
            upParm.show('fast');
            upRdir.show('fast');
            break;
        case "ThisTab":
            upTabs.show('fast');
            upType.show('fast');
            upParm.show('fast');
            upRdir.show('fast');
            break;
    }
}
function checkValidators()
{
    var tabs = jQuery("#tabs").tabs();
    var tabIndex = tabs.tabs('option', 'selected');
    
    //user profile error
    var validator = jQuery(".errValidator")[0]; 
    var validator2 = jQuery(".errValidator")[1];
    var upa = jQuery("[name$='$optUserProfileAction']:checked");
    switch (upa.val())
    {
        case "None":
            //no validation required
            ValidatorEnable(validator,false);
            ValidatorEnable(validator2,false);
            break;
        default:
            var onPortalSettingsTab = (tabIndex == 1);
            //all other options
            ValidatorEnable(validator,true);
            ValidatorEnable(validator2,!onPortalSettingsTab);
            break;
    }
    
}
function showTestUrlSettings()
{
    //set dummy link up
    jQuery('.copyToTestRewrite').attr('href',"#");
    //links up the buttons to copy text into the test url rewriting.
    jQuery('.copyToTestRewrite').click(function () {
        var label = jQuery(this).siblings('.friendlyUrlExample');
        //find friendly url result
        var example = label.html();
        jQuery("[name$='$txtTestRewrite']").val(example);
        return false;
    });
}
//notification of script load
if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();

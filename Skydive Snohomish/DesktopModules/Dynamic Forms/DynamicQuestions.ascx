<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" CodeBehind="DynamicQuestions.ascx.vb"
    Inherits="DataSprings.Modules.DynamicForms.DynamicQuestions" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<script type="text/javascript">
    jQuery(function ($) {
        $('#divTabs').dnnTabs();
       $('#divValTabs').dnnTabs();
    });
</script>
<script type="text/javascript">
    jQuery(function ($) {
         var setupModule = function () {
	    $('#divTabs').dnnTabs();
            $('#divValTabs').dnnTabs();
            $('#PanelsManageQuestions').dnnPanels();
            //$('#PanelsManageQuestions .dnnFormExpandContent a').dnnExpandAll({
            //    targetArea: '#PanelsManageQuestions'
            //});

            $('#PanelsModuleConfiguration').dnnPanels();
            //$('#PanelsModuleConfiguration .dnnFormExpandContent a').dnnExpandAll({
            //    targetArea: '#PanelsModuleConfiguration'
            //});

            $('#PanelsFormCompletionEvents').dnnPanels();
            //$('#PanelsFormCompletionEvents .dnnFormExpandContent a').dnnExpandAll({
            //    targetArea: '#PanelsFormCompletionEvents'
            //});

            $('#PanelsQuestionsEvents').dnnPanels();
            //$('#PanelsQuestionsEvents .dnnFormExpandContent a').dnnExpandAll({
            //    targetArea: '#PanelsQuestionsEvents'
            //});
        };

$(document).ready(function () {
        setupModule();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            // note that this will fire when _any_ UpdatePanel is triggered,
            // which may or may not cause an issue
            setupModule();
        });
    });
});
</script>
<script language="javascript">
    // Get a reference to the PageRequestManager.
    var prm = Sys.WebForms.PageRequestManager.getInstance();

    // Using that prm reference, hook _initializeRequest
    // and _endRequest, to run our code at the begin and end
    // of any async postbacks that occur.
    if (null != prm) {
        prm.add_initializeRequest(InitializeRequest);
        prm.add_endRequest(EndRequest);
    }

    // Executed anytime an async postback occurs.
    function InitializeRequest(sender, args) {
        try {
            jQuery.blockUI({ message: '<div class="SubHead"><br /><br /><img src="<% =GetProgressURL()%>" />&nbsp;&nbsp;&nbsp;<br /><br /><% =GetProgressText()%></div><br />' });
        }
        catch (err) {
            //Handle errors here
        }


    }

    // Executed when the async postback completes.
    function EndRequest(sender, args) {
        try {
            jQuery.unblockUI();
        }
        catch (err) {
            //Handle errors here
        }

    }
</script>

<div class="dnnForm dnnEditDynFormsSettings dnnClear" id="dnnEditDynFormsSettings">


<asp:Literal ID="litJavascript" runat="server"></asp:Literal>
<style id="StylePlaceholder_DataSpringsDynamicForms" type="text/css">
    DIV.showdots
    {
        border-right: #efefef 5px dotted;
        border-top: #efefef 5px dotted;
        border-left: #efefef 5px dotted;
        border-bottom: #efefef 5px dotted;
    }
    DIV.hidedots
    {
        border-right: #efefef 0px dotted;
        border-top: #efefef 0px dotted;
        border-left: #efefef 0px dotted;
        border-bottom: #efefef 0px dotted;
    }
    DIV.showbg
    {
        border-right: #efefef 0px dotted;
        border-top: #efefef 0px dotted;
        border-left: #efefef 0px dotted;
        border-bottom: #efefef 0px dotted;
        background-color: #efefef;
        layer-background-color: #EFEFEF;
    }
    DIV.hidebg
    {
        border-right: #efefef 0px dotted;
        border-top: #efefef 0px dotted;
        border-left: #efefef 0px dotted;
        border-bottom: #efefef 0px dotted;
        background-color: #ffffff;
        layer-background-color: #FFFFFF;
    }
</style>
<script language="javascript">
    function InsertEmailToken(token, myobject) {
        var MyValue;
        MyValue = document.getElementById(token).value;



        if (window.FTB_API) {
            FTB_API[myobject].InsertHtml(MyValue);
        } else if (window.FCKeditorAPI) {
            var oEditor = FCKeditorAPI.GetInstance(myobject);
            oEditor.InsertHtml(MyValue);
        } else if (window.GetRadEditor) {
            var editor = RadEditorGlobalArray[0];
            editor.SetFocus();
            editor.SetActive();
            editor.pasteHtml(MyValue);

        } else {


            var editor = $find(myobject);
            editor.pasteHtml(MyValue);

            if (document.getElementById(myobject).createTextRange) { //Basically if the browser is IE
                var text;
                document.getElementById(myobject).focus(document.getElementById(myobject).caretPos);
                document.getElementById(myobject).caretPos = document.selection.createRange().duplicate();
                if (document.getElementById(myobject).caretPos.text.length > 0) {
                    document.getElementById(myobject).caretPos.text = document.getElementById(myobject).caretPos.text;
                } else {
                    document.getElementById(myobject).caretPos.text = MyValue;
                }
            }
            else { document.getElementById(myobject).value += MyValue; }
        }
    }

</script>
<script language="javascript">

    var globalhiddenfield


    function SetHiddenField(HiddenField) {

        globalhiddenfield = HiddenField;


    }

  function getobj(element) {
if (document.all) {
return document.all[element];
}
else if (document.getElementById) {
return document.getElementById(element);
}
else {
for (iLayer = 1; iLayer < document.layers.length; iLayer++) {
if (document.layers[iLayer].id == element)
return document.layers[iLayer];
}
}
return null;
}


    function validNumeric(e) {
        var unicode = e.charCode ? e.charCode : e.keyCode
        return (unicode >= 48 && unicode <= 57 || unicode == 8 || unicode == 9 || unicode == 13);
    }

    function evalNumber(sortfield) {
        var iNumEntered = document.getElementById(sortfield).value;
        var sText = '';
        if (iNumEntered == '' || iNumEntered == '0') {
            iNumEntered = document.getElementById(sortfield).value = '';
        }
        if (iNumEntered < MySortOrder[0]) {
            sText = 'This field would appear before ' + MyText[0];
        }
        else {
            for (var i = 0; i < MySortOrder.length; i++) {
                if (iNumEntered > MySortOrder[i] && (MySortOrder.length == i + 1 || iNumEntered < MySortOrder[i + 1])) {
                    sText = 'This field would appear after ' + MyText[i];
                    break;
                }
                else if (iNumEntered == MySortOrder[i]) {
                    sText = 'This field would have the same sort order as ' + MyText[i];
                    break;
                }
            }
        }
        document.getElementById('orderlabel').innerHTML = sText;
        return true;
    }

    function evalPanelNumber(sortfield) {
        var iNumEntered = document.getElementById(sortfield).value;
        var sText = '';
        if (iNumEntered == '' || iNumEntered == '0') {
            iNumEntered = document.getElementById(sortfield).value = '';
        }
        if (iNumEntered < MySortOrder[0]) {
            sText = 'This panel would start fields at ' + MyText[0];
        }
        else {
            for (var i = 0; i < MySortOrder.length; i++) {
                if (iNumEntered > MySortOrder[i] && (MySortOrder.length == i + 1 || iNumEntered < MySortOrder[i + 1])) {
                    sText = 'This panel would start fields after ' + MyText[i];
                    break;
                }
                else if (iNumEntered == MySortOrder[i]) {
                    sText = 'This panel would start at the field  ' + MyText[i];
                    break;
                }
            }
        }
        document.getElementById('orderlabel2').innerHTML = sText;
        return true;
    }


    function removewhite(sString) {
        while (sString.substring(0, 1) == ' ') {
            sString = sString.substring(1, sString.length);
        }
        while (sString.substring(sString.length - 1, sString.length) == ' ') {
            sString = sString.substring(0, sString.length - 1);
        }


        sString = sString.replace(/'/g, "");
        sString = sString.replace(/\r/g, "");
        sString = sString.replace(/[^ A-Za-z0-9`~!@#\$%\^&\*\(\)-_=\+\\\|\]\[\}\{'";:\?\/\.>,<]/g, "");
        sString = sString.replace(/ +/g, "");
        sString = sString.replace(/^\s/g, "");
        sString = sString.replace(/\s$/g, "");

        return sString;
    }


   


</script>
<script language="javascript">

    function trimAll(sString) {
        while (sString.substring(0, 1) == ' ') {
            sString = sString.substring(1, sString.length);
        }
        while (sString.substring(sString.length - 1, sString.length) == ' ') {
            sString = sString.substring(0, sString.length - 1);
        }


        return sString;
    }



</script>
<script language="javascript">

    function SetTextAndValue(field1, field2, myvalue) {

        document.getElementById(field1).value = myvalue.split("|")[2];
        document.getElementById(field2).value = myvalue.split("|")[1];


    }

    function DefaultValue(field1, field2, field3, strplease) {


        if (document.getElementById(field2).value == '') {
            document.getElementById(field2).value = removewhite(trimAll(document.getElementById(field1).value).substring(8, 0).replace(/^\s*|\s*$/g, ''));
        }


        if (document.getElementById(field3).value == '') {
            document.getElementById(field3).value = strplease + trimAll(document.getElementById(field1).value).replace(/^\s*|\s*$/g, '') + '.';
        }


    }


    function SetAuthParamByField(field1, field2) {



        document.getElementById(field2).value = document.getElementById(field2).value + document.getElementById(field1).value;


    }




    function SetAuthParam(field1, field2) {


        document.getElementById(field2).value = document.getElementById(field2).value + '&' + document.getElementById(field1).value + '=';


    }





    function move(hval, f, bDir) {
        var el = document.getElementById(f)
        var idx = el.selectedIndex

        if (idx == -1)
            alert("You must first select the item to reorder.")
        else {

            var i;
            var strlist;

            strlist = ""
            var nxidx = idx + (bDir ? -1 : 1)
            if (nxidx < 0) nxidx = el.length - 1
            if (nxidx >= el.length) nxidx = 0
            var oldVal = el[idx].value
            var oldText = el[idx].text
            el[idx].value = el[nxidx].value
            el[idx].text = el[nxidx].text
            el[nxidx].value = oldVal
            el[nxidx].text = oldText
            el.selectedIndex = nxidx


            for (i = el.options.length - 1; i >= 0; i--) {

                if (strlist == undefined) {
                    strlist += el.options[i].value;
                }
                else {
                    strlist += "," + el.options[i].value;
                }

            }


            document.getElementById(hval).value = strlist;
        }
    }



</script>
<script language="javascript" type="text/javascript">
    function hideBlocks(Questions) {

        hideDiv('dynamicquestionsdiv')

        hideDiv('dynamicformssettingsdiv')
        hideDiv('dynamicformseventsdiv')
        hideDiv('dynamicformsquestioneventsdiv')



    }


    function setStyle(Questions) {

        el = document.getElementById('cpiQuestions');
        el.className = "hidedots";
        el = document.getElementById('cpiConfig');
        el.className = "hidedots";
        el = document.getElementById('cpiCompletionEvents');
        el.className = "hidedots";
        el = document.getElementById('cpiQuestionEvents');
        el.className = "hidedots";


        el = document.getElementById('cplQuestions');
        el.className = "hidebg";
        el = document.getElementById('cplConfig');
        el.className = "hidebg";
        el = document.getElementById('cplCompletionEvents');
        el.className = "hidebg";
        el = document.getElementById('cplQuestionEvents');
        el.className = "hidebg";

        if (Questions == "dynamicquestionsdiv") {

            el = document.getElementById('cpiQuestions');
            el.className = "showdots";
            el = document.getElementById('cplQuestions');
            el.className = "showbg";
        }

        else if (Questions == "dynamicformssettingsdiv") {

            el = document.getElementById('cpiConfig');
            el.className = "showdots";
            el = document.getElementById('cplConfig');
            el.className = "showbg";
        }


        else if (Questions == "dynamicformseventsdiv") {

            el = document.getElementById('cpiCompletionEvents');
            el.className = "showdots";
            el = document.getElementById('cplCompletionEvents');
            el.className = "showbg";

        }

        else if (Questions == "dynamicformsquestioneventsdiv") {

            el = document.getElementById('cpiQuestionEvents');
            el.className = "showdots";
            el = document.getElementById('cplQuestionEvents');
            el.className = "showbg";
        }

    }



    function showCurrentDiv(HiddenField) {

        globalhiddenfield = HiddenField;

        try {
            showDiv(document.getElementById(HiddenField).value)
        }
        catch (err) {
            showDiv('dynamicquestionsdiv')

        }

    }


</script>
<script language="javascript" type="text/javascript">
    function hideDiv(pass) {

        var divs = document.getElementsByTagName('div');

        for (i = 0; i < divs.length; i++) {
            if (divs[i].id.match(pass)) {//if they are 'see' divs 

                if (document.getElementById) // DOM3 = IE5, NS6 
                    divs[i].style.display = 'none'; // show/hide 

                else
                    if (document.layers) // Netscape 4 
                        document.layers[divs[i]].display = 'hidden';
                    else // IE 4 
                        document.all.hideShow.divs[i].visibility = 'hidden';

            }
        }
    }

    function showDiv(pass) {
        hideBlocks('');

        try {
            document.getElementById(globalhiddenfield).value = pass;
        }
        catch (err) {

            document.getElementById(globalhiddenfield).value = pass;
        }



        setStyle(pass)


        var divs = document.getElementsByTagName('div');
        for (i = 0; i < divs.length; i++) {
            if (divs[i].id.match(pass)) {
                if (document.getElementById)

                    divs[i].style.display = ''; // show/hide 

                else
                    if (document.layers) // Netscape 4 
                        document.layers[divs[i]].display = 'visible';
                    else // IE 4 
                        document.all.hideShow.divs[i].visibility = 'visible';
            }
        }
    } 
</script>

    <asp:UpdatePanel ID="UpdatePanelExit" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkCancel" CssClass="dnnPrimaryAction" runat="server">Exit</asp:LinkButton>
        </ContentTemplate>
    </asp:UpdatePanel>

<div class="dnnForm dnnEditControlPanel dnnClear">

            <table cellspacing="1" cellpadding="1" width="100%">
                <tr>
                    <td align="left" valign="middle">
                    <h1>
                        <asp:Label ID="lblDRControlPanel" EnableViewState="False" resourcekey="ControlPanel"
                            CssClass="DynRegSubHead" runat="server"></asp:Label></h1>
                    </td>
                    <td align="center" valign="middle">
                    </td>
                    <td align="right" valign="middle">
                        <asp:Label ID="lblDRVisibility" EnableViewState="False" resourcekey="Visibility"
                            CssClass="SubHead" runat="server"></asp:Label><asp:LinkButton ID="cmdDRVisibility"
                                runat="server" CausesValidation="False">
                                <asp:Image ID="imgDFVisibility" runat="server"></asp:Image></asp:LinkButton>&nbsp;
                    </td>
                </tr>
                <tr id="rowDRControlPanel" runat="server">
                    <td colspan="4" align="center" valign="middle" style="border-top: 1px #CCCCCC dotted;">
                        <table width="100%" bgcolor="#ffffff" border="0">
                            <tr>
                                <td align="center">
                                    <div id="cpiQuestions">
                                        <a href="javascript:showDiv('dynamicquestionsdiv')">
                                            <asp:Image ID="imgManageQuestions" runat="server" AlternateText="Manage Questions"
                                                ImageUrl="~/desktopmodules/dynamic forms/questions_icon1.jpg"></asp:Image></a></div>
                                </td>
                                <td align="center">
                                    <div id="cpiConfig">
                                        <a href="javascript:showDiv('dynamicformssettingsdiv')">
                                            <asp:Image ID="imgManageQuestions3" runat="server" AlternateText="General Settings"
                                                ImageUrl="~/desktopmodules/dynamic forms/questions_icon3.jpg"></asp:Image></a></div>
                                </td>
                                <td align="center">
                                    <div id="cpiCompletionEvents">
                                        <a href="javascript:showDiv('dynamicformseventsdiv')">
                                            <asp:Image ID="imgManageQuestions4" runat="server" AlternateText="Completion Events"
                                                ImageUrl="~/desktopmodules/dynamic forms/questions_icon4.jpg"></asp:Image></a></div>
                                </td>
                                <td align="center">
                                    <div id="cpiQuestionEvents">
                                        <a href="javascript:showDiv('dynamicformsquestioneventsdiv')">
                                            <asp:Image ID="imgManageQuestions5" runat="server" AlternateText="Question Events"
                                                ImageUrl="~/desktopmodules/dynamic forms/questions_icon5.jpg"></asp:Image></a></div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <div id="cplQuestions">
                                        <asp:HyperLink ID="hypShowQuestions" runat="server" resourcekey="ControlTitle_extended" CssClass="dnnPrimaryAction"
                                            NavigateUrl="javascript:showDiv('dynamicquestionsdiv')" Visible="true"></asp:HyperLink></div>
                                </td>
                                <td align="center" >
                                    <div id="cplConfig">
                                        <asp:HyperLink ID="hypShowSetup" runat="server" resourcekey="GeneralSettingscp" NavigateUrl="javascript:showDiv('dynamicformssettingsdiv')"
                                            Visible="true" CssClass="dnnPrimaryAction"></asp:HyperLink></div>
                                </td>
                                <td align="center">
                                    <div id="cplCompletionEvents">
                                        <asp:HyperLink ID="hypShowEvents" runat="server" resourcekey="SystemEventscp" NavigateUrl="javascript:showDiv('dynamicformseventsdiv')"
                                            Visible="true" CssClass="dnnPrimaryAction"></asp:HyperLink></div>
                                </td>
                                <td align="center">
                                    <div id="cplQuestionEvents">
                                        <asp:HyperLink ID="hypShowQuestionEvents" runat="server" resourcekey="QuestionEvents" CssClass="dnnPrimaryAction"
                                            NavigateUrl="javascript:showDiv('dynamicformsquestioneventsdiv')" Visible="true"></asp:HyperLink></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        
</div>
<div id="dynamicquestionsdiv" align="left">
    <asp:UpdatePanel ID="UpdatePanelQuestions" runat="server">
        <ContentTemplate>
            <div class="dnnForm" id="PanelsManageQuestions">
                <h2 id="dshQuestions" class="dnnFormSectionHead">
                    <a href="#">
                        <%=LocalizeString("DynamicQuestions")%></a>
                </h2>
                <fieldset class="dnnClear">
                    <div class="dnnForm" id="tblQuestoins" runat="server">
                        <fieldset>
                            <div class="dnnFormItem">
                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                    <asp:Literal ID="litDynamicFields" runat="server"></asp:Literal>
                                </span>
                            </div>
                            <div class="dnnClear dnnRight">
                                <asp:ImageButton ID="imgQuestions" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1c.gif">
                                </asp:ImageButton>
                            </div>
                            <div class="dnnFormItem" id="Table7">
                                <dnn:Label ID="lblExtendedField" runat="server" Suffix=":"></dnn:Label>
                                <asp:DropDownList ID="cboDynamicFields" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                </asp:DropDownList>
                            </div>
                            <div class="dnnFormItem" id="tblSEtup" runat="server">
                                <div class="dnnForm" id="tblDetailFrame" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem" id="Table5">
                                            <div class="dnnForm">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <hr />
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <div class="dnnForm" id="Table1">
                                                            <fieldset>
                                                                <div class="dnnFormItem" id="pnlClone" runat="server">
                                                                    <div class="dnnForm" id="tblClone">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblCloneQuestion" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:DropDownList ID="cboCopyFieldFrom" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <hr />
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblQuestion" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:TextBox ID="txtQuestion" runat="server" MaxLength="1000" CssClass="NormalTextbox"></asp:TextBox>
                                                                    <dnn:TextEditor ID="txtHTML" runat="server" Height="300" Width="450"></dnn:TextEditor>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblShortName" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:TextBox ID="txtShortFieldName" runat="server" MaxLength="200" CssClass="NormalTextbox"
                                                                        name="txtShortFieldName"></asp:TextBox>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblHelp" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:TextBox ID="txtHelpText" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblSortOrder" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:TextBox ID="txtSortOrder" runat="server" MaxLength="5" CssClass="NormalTextbox"></asp:TextBox>
                                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                                        ControlToValidate="txtSortOrder" MinimumValue="0" MaximumValue="99999"></asp:RangeValidator>
                                                                </div>
                                                                <div class="dnnFormItem" id="orderlabel">
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblQuestionType" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:RadioButtonList ID="optType" runat="server" AutoPostBack="True" CssClass="dnnFormRadioButtons"
                                                                        RepeatColumns="3" RepeatDirection="Horizontal">
                                                                        <asp:ListItem Value="TextBox" Selected="True">TextBox</asp:ListItem>
                                                                        <asp:ListItem Value="CheckBox">CheckBox</asp:ListItem>
                                                                        <asp:ListItem Value="ComboBox">Combo Box</asp:ListItem>
                                                                        <asp:ListItem Value="RadioButton">Radio Button (Options)</asp:ListItem>
                                                                        <asp:ListItem Value="HTML">Text / HTML</asp:ListItem>
                                                                        <asp:ListItem Value="CheckBoxList">CheckBox Group </asp:ListItem>
                                                                        <asp:ListItem Value="Hidden">Hidden Field</asp:ListItem>
                                                                        <asp:ListItem Value="Listbox">Listbox</asp:ListItem>
                                                                        <asp:ListItem Value="Date">Date</asp:ListItem>
                                                                        <asp:ListItem Value="HR">HR Ruler</asp:ListItem>
                                                                        <asp:ListItem Value="Image">Image</asp:ListItem>
                                                                        <asp:ListItem Value="FileUpload">File Attachment</asp:ListItem>
                                                                        <asp:ListItem Value="Captcha">Captcha</asp:ListItem>
                                                                        <asp:ListItem Value="richtext">Rich Text Editor</asp:ListItem>
                                                                        <asp:ListItem Value="dnncountry">Country</asp:ListItem>
                                                                        <asp:ListItem Value="dnnregion">Region</asp:ListItem>
                                                                        <asp:ListItem Value="label">Label</asp:ListItem>
                                                                        <asp:ListItem Value="button">button</asp:ListItem>
                                                                        <asp:ListItem Value="GridView">GridView</asp:ListItem>
                                                                        <asp:ListItem Value="Rating">Rating</asp:ListItem>
                                                                        <asp:ListItem Value="DataGrid">Rating</asp:ListItem>
                                                                        <asp:ListItem Value="DNNTextSuggest"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                <dnn:Label ID="lblOptionType" runat="server" />
                                                                    <asp:RadioButtonList ID="optOptionType" runat="server" CssClass="dnnFormRadioButtons"
                                                                        RepeatDirection="Horizontal">
                                                                        <asp:ListItem Value="Vertical" Selected="True">Options are vertical</asp:ListItem>
                                                                        <asp:ListItem Value="Horizontal">Options are horizontal</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                                <div class="dnnFormItem" style="padding-left:350px;">
                                                                    <asp:Label ID="lblOptionTypeNote" ResourceKey="OptionType" runat="server"></asp:Label>
                                                                    <asp:RadioButtonList ID="optTextbox" runat="server" AutoPostBack="True" CssClass="dnnFormRadioButtons"
                                                                        name="optTextbox" RepeatColumns="2" RepeatDirection="Horizontal">
                                                                        <asp:ListItem Value="Single" Selected="True">Singleline textbox (Long)</asp:ListItem>
                                                                        <asp:ListItem Value="SingleShort">Singleline textbox (Short)</asp:ListItem>
                                                                        <asp:ListItem Value="Multi">Multiline textbox</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem" id="Table6" runat="server">
                                            <div class="dnnForm">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <div class="dnnForm" id="tblEnter" runat="server">
                                                            <fieldset>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblQuestionOptions" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:RadioButtonList ID="optEnterorSQL" runat="server" AutoPostBack="True" CssClass="dnnFormRadioButtons"
                                                                        RepeatDirection="Horizontal">
                                                                        <asp:ListItem Value="Enter Options" Selected="True">Enter Options</asp:ListItem>
                                                                        <asp:ListItem Value="SQL Driven">SQL Driven</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                                <div class="dnnFormItem" style="padding-left:230px;">
                                                                    <div class="dnnForm" id="tblSQL" runat="server">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                                    <asp:Literal ID="litSQLInstructions" runat="server"></asp:Literal>
                                                                                </span>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:TextBox ID="txtSQL" runat="server" CssClass="NormalTextBox" Height="140px" TextMode="MultiLine"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:Button ID="btnTestSQL" runat="server" CssClass="dnnPrimaryAction" Text="Test SQL"></asp:Button>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:Label ID="lblSQLStatus" runat="server"></asp:Label>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem" >
                                                                    <div class="dnnForm" id="tblAdd">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem" style="padding-left:230px;">
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtOption" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="cboAddOptionType" runat="server" CssClass="NormalTextbox">
                                                                                    <asp:ListItem Value="bottom">Add Item to the Bottom</asp:ListItem>
                                                                                    <asp:ListItem Value="top">Add Item to the Top</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="imgAdd" runat="server" AlternateText="Add Option" ImageUrl="~/images/add.gif">
                                                                                </asp:ImageButton>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem" >
                                                                    <div class="dnnForm" id="Table3">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem" style="padding-left:230px;"> 
                                                                                <table cellspacing="1" cellpadding="1" width="440" border="0">
                                                                            <tr>
                                                                                <td valign="top">
                                                                                    <asp:ListBox ID="lstOptions" runat="server" CssClass="NormalTextbox" Width="435px"
                                                                                        Height="137px"></asp:ListBox>
                                                                                </td>
                                                                                <td>
                                                                                    <table id="tblMoveOptions" border="0" runat="server">
                                                                                        <tr>
                                                                                            <td height="25">
                                                                                                <asp:ImageButton ID="imgTop" runat="server" AlternateText="Move Option to Top" ImageUrl="~/images/top.gif">
                                                                                                </asp:ImageButton>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td height="25">
                                                                                                <asp:Image ID="imgQUPQuestion" runat="server" AlternateText="Move Option Up" ImageUrl="~/images/Up.gif">
                                                                                                </asp:Image><asp:ImageButton ID="imgUp" runat="server" AlternateText="Move Option Up "
                                                                                                    ImageUrl="~/images/up.gif"></asp:ImageButton>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Image ID="imgQDownQuestion" runat="server" AlternateText="Move Option Down"
                                                                                                    ImageUrl="~/images/dn.gif"></asp:Image><asp:ImageButton ID="imgDown" runat="server"
                                                                                                        AlternateText="Move Option Down" ImageUrl="~/images/dn.gif"></asp:ImageButton>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:ImageButton ID="imgBottom" runat="server" AlternateText="Move Option to Bottom"
                                                                                                    ImageUrl="~/images/bottom.gif"></asp:ImageButton>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <div class="dnnForm" id="tblUpdateOptions" runat="server">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblUpdateTextOption" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtUpdateTextOption" runat="server" MaxLength="2400" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblUpdateValueOption" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtUpdateValueOption" runat="server" MaxLength="2400" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem" id="rowGridView" runat="server">
                                                                                <dnn:Label ID="lblGridViewColumn" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:CheckBox ID="chkRepresentsColumn" runat="server"></asp:CheckBox>
                                                                            </div>
                                                                            <div class="dnnFormItem" id="rowGridView1" runat="server">
                                                                                <dnn:Label ID="lblGridViewDefault" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:CheckBox ID="chkDefaultChecked" ResourceKey="InitiallyCheckedColumn" runat="server">
                                                                                </asp:CheckBox>
                                                                            </div>
                                                                            <div class="dnnFormItem" id="rowDataGrid" runat="server">
                                                                                <dnn:Label ID="lblDataGridFieldType" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:DropDownList ID="cboDataGridFieldType" runat="server" CssClass="NormalTextbox">
                                                                                    <asp:ListItem Value="TextBox" ResourceKey="TextBox"></asp:ListItem>
                                                                                    <asp:ListItem Value="MultiLine" ResourceKey="MultiLine"></asp:ListItem>
                                                                                    <asp:ListItem Value="ComboBox" ResourceKey="ComboBox"></asp:ListItem>
                                                                                    <asp:ListItem Value="RadioButton" ResourceKey="RadioButtonList"></asp:ListItem>
                                                                                    <asp:ListItem Value="RadioButton1" ResourceKey="RadioButtonListVertical"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="dnnFormItem" id="rowDataGrid1" runat="server">
                                                                                <dnn:Label ID="lblDataGridListName" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtDataGridListName" runat="server" MaxLength="200" CssClass="NormalTextbox">Region</asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblMoveOption" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:DropDownList ID="cboMoveOptionAfter" runat="server" CssClass="NormalTextbox">
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="dnnFormItem" style="padding-left:230px;">
                                                                                <asp:ImageButton ID="imgRemove" runat="server" AlternateText="Remove Option" ImageUrl="~/images/delete.gif">
                                                                                </asp:ImageButton>&nbsp;
                                                                                <asp:ImageButton ID="imgUpdateOption" runat="server" AlternateText="Update Option"
                                                                                    ImageUrl="~/images/save.gif"></asp:ImageButton>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblDNNTextSuggest" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMinCharacterLookup" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMinCharacterLookup" runat="server" MaxLength="4" CssClass="NormalTextbox">3</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMaxSuggestedRows" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxSuggestedRows" runat="server" MaxLength="4" CssClass="NormalTextbox">10</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblLookupDelay" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtLookupDelay" runat="server" MaxLength="5" CssClass="NormalTextbox">300</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblLookupSQL" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:Literal ID="litLookupSQL" runat="Server"></asp:Literal>
                                                        <asp:TextBox ID="txtLookupSQL" runat="server" TextMode="MultiLine" Height="200" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblListBox" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem" id="rowCheckBoxList1" runat="server">
                                                        <dnn:Label ID="lblShowCheckAll" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboDisplayCheckAll" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="None" ResourceKey="NotDisplay"></asp:ListItem>
                                                            <asp:ListItem Value="Top" ResourceKey="Above"></asp:ListItem>
                                                            <asp:ListItem Value="Bottom" ResourceKey="Below"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem" id="rowCheckBoxList2" runat="server">
                                                        <dnn:Label ID="lblCheckAllText" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtCheckAllText" runat="server" MaxLength="200" CssClass="NormalTextbox">0</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem" id="rowListBox1" runat="server">
                                                        <dnn:Label ID="lblSingleMultiple" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboSingleMultipleDisplay" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="Single">Single Select</asp:ListItem>
                                                            <asp:ListItem Value="Multi">Multi Select</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblRowNumbers" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtRowNumbers" runat="server" MaxLength="200" CssClass="NormalTextbox">0</asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblDateDisplay" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblDateDisplayType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboDateDisplayType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="0">Textbox W/ Calendar</asp:ListItem>
                                                            <asp:ListItem Value="1">Month &amp; Day</asp:ListItem>
                                                            <asp:ListItem Value="2">Month &amp; Year</asp:ListItem>
                                                            <asp:ListItem Value="3">Month, Day, Year (Textbox)</asp:ListItem>
                                                            <asp:ListItem Value="4"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblStartingYears" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtDateStartYears" runat="server" MaxLength="5" CssClass="NormalTextbox">90</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEndingYears" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtDateEndYears" runat="server" MaxLength="5" CssClass="NormalTextbox">-14</asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblComboBox" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblAllowComboBoxEdit" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkAllowComboBoxEdit" runat="server"></asp:CheckBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblFileUpload" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblFileUploadFileNameType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboFileUploadFileNameType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="UniqueFileName" Value="0"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="FriendlyFileName" Value="1"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="ExactFileName" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblFileUploadAltMapPath" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtFileUploadAltMapPath" runat="server" MaxLength="600" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblFileUploadAltPath" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtFileUploadAltPath" runat="server" MaxLength="500" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblFileUploadSaveType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboFileUploadSaveType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="FileOnly" Value="0"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="FullURL" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblAlternateAllowableExtensions" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtAlternateAllowableExtensions" runat="server" MaxLength="500"
                                                            CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblInvalidExtensionErrorMessage" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtInvalidExtensionErrorMessage" runat="server" MaxLength="500"
                                                            CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMaxFileSize" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxFileSize" runat="server" MaxLength="100" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblFieldTypeField" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboFileUploadType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="StandardFileUpload" Value="0"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="TelerikFileUpload" Value="1"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="DNNFileUpload" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblInitialFilesCount" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtInitialFilesCount" runat="server" MaxLength="20" CssClass="NormalTextbox">1</asp:TextBox>
                                                        <asp:RangeValidator ID="valRangeInitialFilesCount" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                            ControlToValidate="txtInitialFilesCount" MinimumValue="1" MaximumValue="99999"></asp:RangeValidator>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMaxNumberOfFiles" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxNumberOfFiles" runat="server" MaxLength="20" CssClass="NormalTextbox">1</asp:TextBox>
                                                        <asp:RangeValidator ID="valRangeMaxFiles" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                            ControlToValidate="txtMaxNumberOfFiles" MinimumValue="1" MaximumValue="99999"></asp:RangeValidator>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblImage" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImageType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboImaqeType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="0"></asp:ListItem>
                                                            <asp:ListItem Value="1"></asp:ListItem>
                                                            <asp:ListItem Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMaxImageHeight" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxImageHeight" runat="server" MaxLength="100" CssClass="NormalTextbox"></asp:TextBox>
                                                        <asp:RangeValidator ID="valRangeMaxImageHeight" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                            ControlToValidate="txtMaxImageHeight" MinimumValue="0" MaximumValue="99999999"></asp:RangeValidator>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMaxImageWidth" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxImageWidth" runat="server" MaxLength="100" CssClass="NormalTextbox">1</asp:TextBox>
                                                        <asp:RangeValidator ID="valRangeMaxImageWidth" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                            ControlToValidate="txtMaxImageWidth" MinimumValue="0" MaximumValue="9999999"></asp:RangeValidator>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblThumbnailType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboThumbnailType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="Relative" Value="1"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="Fixed" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImageHeight" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtThumbnailHeight" runat="server" MaxLength="200" CssClass="NormalTextbox">0</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImageWidth" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtThumbnailWidth" runat="server" MaxLength="200" CssClass="NormalTextbox">0</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImagePreview" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkImagePreview" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImagePreviewType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboPreviewImageType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="PreviewLinkButton" Value="0"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="PreviewImageButton" Value="1"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="PreviewAutomatic" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImageFileNameType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboImageFileNameType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="UniqueFileName" Value="0"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="FriendlyFileName" Value="1"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="ExactFileName" Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImageAltPath" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtImageAltPath" runat="server" MaxLength="500" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblImageSaveType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboImageSaveType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="FileOnly" Value="0"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="FullURL" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblAlternateImageAllowableExtensions" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtAlternateImageAllowableExtensions" runat="server" MaxLength="500"
                                                            CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblInvalidImageExtensionErrorMessage" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtInvalidImageExtensionErrorMessage" runat="server" MaxLength="500"
                                                            CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMaxImageFileSize" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxImageFileSize" runat="server" MaxLength="100" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem" id="Tr4" runat="server" visible="false">
                                                        <dnn:Label ID="lblFieldTypeFieldImage" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboFileUploadTypeImage" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="StandardFileUpload" Value="0"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="TelerikFileUpload" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem" id="Tr5" runat="server" visible="false">
                                                        <dnn:Label ID="lblInitialFilesCountImage" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtInitialFilesCountImage" runat="server" MaxLength="20" CssClass="NormalTextbox">1</asp:TextBox>
                                                        <asp:RangeValidator ID="valRangeInitialFilesCountImage" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                            ControlToValidate="txtInitialFilesCountImage" MinimumValue="1" MaximumValue="99999"></asp:RangeValidator>
                                                    </div>
                                                    <div class="dnnFormItem" id="Tr6" runat="server" visible="false">
                                                        <dnn:Label ID="lblMaxNumberOfFilesImage" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxNumberOfFilesImage" runat="server" MaxLength="20" CssClass="NormalTextbox">1</asp:TextBox>
                                                        <asp:RangeValidator ID="valRangeMaxFilesImage" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                            ControlToValidate="txtMaxNumberOfFilesImage" MinimumValue="1" MaximumValue="99999"></asp:RangeValidator>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblMultiLineTextbox" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMultiLineHeight" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMultiLineHeight" runat="server" MaxLength="200" CssClass="NormalTextbox">100</asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblTextbox" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblTextboxMaskEdit" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaskEdit" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblShowDefaultAsWatermark" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkShowDefaultAsWatermark" runat="server"></asp:CheckBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblGridView" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblHideHeader" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkHideGridViewHeader" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblGridType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:RadioButtonList ID="optGridType" runat="server" RepeatDirection="Horizontal"
                                                            CssClass="dnnFormRadioButtons">
                                                            <asp:ListItem Value="Radio" Selected="True" ResourceKey="Radio"></asp:ListItem>
                                                            <asp:ListItem Value="Checkbox" ResourceKey="CheckBox"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblOptionColumnWidth" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtOptionColumnWidth" runat="server" MaxLength="200" CssClass="NormalTextbox">100</asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblDataGrid" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblHideDataGridHeader" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkHideDataGridwHeader" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblDataGridColumnWidth" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtDataGridColumnWidth" runat="server" MaxLength="200" CssClass="NormalTextbox">100</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblWrapDataGridHeader" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkWrapDataGridHeader" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblHideDataGridBorder" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkHideDataGridBorder" runat="server"></asp:CheckBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblRating" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblMaxRating" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtMaxRating" runat="server" MaxLength="3" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblCurrentRating" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtCurrentRating" runat="server" MaxLength="3" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblRatingAlign" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboRatingAlign" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="Horizontal" ResourceKey="Horizontal"></asp:ListItem>
                                                            <asp:ListItem Value="Vertical" ResourceKey="Vertical"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblRatingDirection" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboRatingDirection" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="LeftToRightTopToBottom" ResourceKey="LeftToRightTopToBottom"></asp:ListItem>
                                                            <asp:ListItem Value="RightToLeftBottomToTop" ResourceKey="RightToLeftBottomToTop"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblCheckboxOptions" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblDisplayLabelonField" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkDisplayLabelonField" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblTextAlign" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboCheckAlign" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="Left">Left</asp:ListItem>
                                                            <asp:ListItem Value="Right">Right</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblHRRuleer" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblHRRuleWidth" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtHRWidth" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblHRRuleThick" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtHRThick" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblCaptcha" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblCaptchaType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboCaptchaType" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem ResourceKey="CaptchaStandard" Value="Standard"></asp:ListItem>
                                                            <asp:ListItem ResourceKey="CaptchaAdvanced" Value="Advanced">Right</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <strong>
                                                        <dnn:Label ID="lblAdvancedCaptcha" runat="server" Suffix=":"></dnn:Label>
                                                            </strong>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                        <asp:Literal ID="litAdvancedCaptchaHelp" runat="server"></asp:Literal>
                                                        </span>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <hr />
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblCaptchaStyle" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboCaptchaStyle" runat="server" CssClass="NormalTextbox">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEnableRefresh" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkEnableCaptchaRefresh" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEnableSound" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkEnableCaptchaSound" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblCaptchaHeight" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtCaptchaHeight" runat="server" MaxLength="200" CssClass="NormalTextbox">0</asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblCaptchaWidth" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtCaptchaWidth" runat="server" MaxLength="200" CssClass="NormalTextbox">0</asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="tblNewQuestion" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                        <asp:Literal ID="litNewQuestionWarning" runat="server"></asp:Literal>
                                                        </span>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="dnnFormItem">
                                            <asp:TextBox ID="txtNewQuestionID" runat="server" Visible="False"></asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="PanelsDynamicQuestions">
                                                <h2 id="dshAdvanced" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("AdvancedField")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblAdvancedField" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblDefaultValue" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:RadioButtonList ID="optTextboxDefault" runat="server" AutoPostBack="True" 
                                                                    RepeatDirection="Horizontal" CssClass="dnnFormRadioButtons">
                                                                    <asp:ListItem Value="Enter Options" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Value="SQL Driven"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                            <div class="dnnFormItem" style="padding-left:350px;">
                                                                <asp:TextBox ID="txtDefault" runat="server" CssClass="NormalTextbox" Enabled="False"></asp:TextBox>
                                                                <asp:TextBox ID="txtDefaultSQL" runat="server" CssClass="NormalTextbox" Height="200" TextMode="MultiLine"></asp:TextBox>
                                                                <span style="width:400px;">
                                                                    <asp:Literal ID="litSQLDefaultValue" runat="server"></asp:Literal>
                                                                </span>
                                                                <asp:CheckBox ID="chkNoDefault" runat="server" Visible="False" ResourceKey="NoDefaultvalue">
                                                                </asp:CheckBox><br />
                                                                <asp:DropDownList ID="cboDefault" runat="server" CssClass="NormalTextbox" Visible="False">
                                                                </asp:DropDownList>
                                                                <asp:RadioButtonList ID="optDefault" runat="server" Visible="False" CssClass="dnnFormRadioButtons">
                                                                </asp:RadioButtonList>
                                                                <asp:CheckBox ID="chkDefault" runat="server" Visible="False"></asp:CheckBox>
                                                                <asp:CheckBoxList ID="chkBoxListDefault" runat="server" Visible="False">
                                                                </asp:CheckBoxList>
                                                                <asp:ListBox ID="lstDefault" SelectionMode="Multiple" runat="server" CssClass="NormalTextBox"
                                                                    Visible="False"></asp:ListBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblDNNUserIntegration" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboDNNCoreUserIntegration" runat="server" CssClass="NormalTextbox">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblExampleText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtExampleText" runat="server" MaxLength="4000" CssClass="NormalTextbox"
                                                                    Height="100" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblReadOnly" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkReadOnly" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblJavaScriptValidation" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtJavascriptValidation" runat="server" MaxLength="200" CssClass="NormalTextbox"
                                                                    Height="78px" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideOrShow" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboHideOrShow" runat="server" CssClass="NormalTextbox" Visible="True">
                                                                    <asp:ListItem Value="0" ResourceKey="Hide"></asp:ListItem>
                                                                    <asp:ListItem Value="1" ResourceKey="Show"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
								<dnn:Label ID="lblHideOrShowGroups" runat="server" Suffix=""></dnn:Label>
                                                                <asp:DropDownList ID="cboRoleGroups" AutoPostBack="True" runat="server" />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideQuestions" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBoxList ID="chkListRoles" runat="server" CssClass="Normal" Width="325"
                                                                    DataTextField="RoleName" DataValueField="RoleID" RepeatColumns="2">
                                                                </asp:CheckBoxList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideAnonymous" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkHideAnonymous" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideBasedOnEvent" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkHideQuestionUnlessVisibleByEvent" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPullInValuesFromQueryString" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkPullInQuerySTring" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPassShortNameField" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkPassValues" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPullSession" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkPullInSession" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPassSession" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkPassSession" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPullCookie" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkPullCookie" runat="server" />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPassCookie" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkPassCookie" runat="server" />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblNoResults" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkNoResults" runat="server" />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblNoSave" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkNoSave" runat="server" />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEncyrptDecrypt" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEncyrptDecrypt" runat="server" />
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshQuestionLookAndFeel" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("QuestionLookAndFeel")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblQuestionLookAndFeel" runat="server">
                                                        <fieldset>
                                                          
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblOverRideLabelStyleClass" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtLabelClass" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblOverRideFieldStyleClass" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtFieldClass" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblColSpan" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtColSpan" runat="server" MaxLength="10" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblRowSpan" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtRowSpan" runat="server" MaxLength="10" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblTextBoxLength" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtLength" runat="server" MaxLength="200" CssClass="NormalTextbox">200</asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblForceSameLine" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkSameLineAsPrevious" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblForceSameCell" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkSameCellAsPrevious" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblFieldLabelSameLine" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkDisplayFieldLabelSameLine" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideFieldLabel" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkHideFieldLabel" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblShowHelpAsPopUp" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkShowHelpAsPopup" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPopUpWidth" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtPopUpWidth" runat="server" Text="200"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshQuestionHeaderfooter" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("QuestionHeaderFooter")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblQuestionHeaderFooter" runat="server">
                                                        <fieldset>
                                                         
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblQuestionHeader" runat="server" Suffix=":"></dnn:Label>
                                                                <div class="dnnLeft">
                                                                    <div class="dnnFormItem">
                                                                        <dnn:TextEditor ID="txtQuestionHeader" runat="server" Height="300" Width="450"></dnn:TextEditor>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblQuestionFooter" runat="server" Suffix=":"></dnn:Label>
                                                                <div class="dnnLeft">
                                                                    <div class="dnnFormItem">
                                                                        <dnn:TextEditor ID="txtQuestionFooter" runat="server" Height="300" Width="450"></dnn:TextEditor>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshValidation" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("QuestionValidation")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblValidation" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                <asp:Literal ID="litQuestionValidation" runat="server"></asp:Literal></span>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblTextboxMaxLength" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtMaxLength" runat="server" MaxLength="3" CssClass="NormalTextbox">50</asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblRequired" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkRequired" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblRequiredFieldText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtRequiredFieldText" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblRequiredFieldErrorText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtREquiredFieldVAlidation" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblUseRegularExpression" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkUseRegularExpression" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblRegularExpression" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtRegularExpression" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblRegularExpresstionValidationText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtRegularExpressionValidationText" runat="server" MaxLength="200"
                                                                    CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblRegularExpressErrorText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtRegularExpressionText" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableCompareValidator" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEnableCompare" runat="server"></asp:CheckBox>
                                                                <asp:Literal ID="litCompareError" runat="server"></asp:Literal>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblCompareField" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboCompareFields" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblCompareValError" runat="server" CssClass="Error"></asp:Label>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblCompareText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtCompareText" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblCompareError" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtCompareError" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableSQLValidationForField" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEnableSQLValidationForField" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSQLValidationQueryForField" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtSQLValidationQueryForField" runat="server" CssClass="NormalTextbox"
                                                                    MaxLength="2000" Height="100" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSQLValidationErrorMessageForField" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtSQLValidationErrorMessageForField" runat="server" CssClass="NormalTextbox"
                                                                    MaxLength="4000" Height="100" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </fieldset>
                <ul class="dnnActions dnnClear">
                    <li>
                        <asp:LinkButton ID="lnkUpdateAndExit" CssClass="dnnPrimaryAction" runat="server">Update Question</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="lnkDelete" CssClass="dnnSecondaryAction" runat="server">Delete Question</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="lnkUpdate" CssClass="dnnSecondaryAction" runat="server">Update Question</asp:LinkButton>
                    </li>
                </ul>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div id="dynamicformssettingsdiv" align="left">
    <asp:UpdatePanel ID="UpdatePanelModuleConfig" runat="server">
        <ContentTemplate>
            <div class="dnnForm dnnClear">
                <fieldset>
                    <div class="dnnFormItem">
                        <div class="dnnForm" id="PanelsModuleConfiguration">
                            <h2 id="dshGeneral" class="dnnFormSectionHead">
                                <a href="#">
                                    <%=LocalizeString("General")%></a>
                            </h2>
                            <fieldset class="dnnClear">
                                <div class="dnnForm" id="tblGeneral" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                    <asp:Literal ID="litGeneral" runat="server"></asp:Literal>
                                            </span>
                                        </div>
                                            <div class="dnnClear dnnRight">
                                                <asp:ImageButton ID="imgGeneral" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1d.gif">
                                                </asp:ImageButton>
                                            </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblSummaryField" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboSummaryField" runat="server" CssClass="NormalTextbox">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblTestMode" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkTestMode" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisableInLineEditor" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDisableEditor" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAllignLinkButtons" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboAlign" runat="server" CssClass="NormalTextbox">
                                                <asp:ListItem Value="Left">Left</asp:ListItem>
                                                <asp:ListItem Value="Center">Right</asp:ListItem>
                                                <asp:ListItem Value="Right">Right</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisableDragDropAbility" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDisableDragDrop" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAlignLabels" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboAlignLabels" runat="server" CssClass="NormalTextbox">
                                                <asp:ListItem Value="Left">Left</asp:ListItem>
                                                <asp:ListItem Value="Center">Right</asp:ListItem>
                                                <asp:ListItem Value="Right">Right</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisableHelpQuick" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDisableHelpMenu" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblLabelVerticalAlignment" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboLabelVerticalAlignment" runat="server" CssClass="NormalTextbox">
                                                <asp:ListItem Value="Top">Top</asp:ListItem>
                                                <asp:ListItem Value="Middle">Middle</asp:ListItem>
                                                <asp:ListItem Value="Bottom">Bottom</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisableQuickStats" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDisableQuickStats" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblFieldVerticalAlignement" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboFieldVerticalAlignement" runat="server" CssClass="NormalTextbox">
                                                <asp:ListItem Value="Top">Top</asp:ListItem>
                                                <asp:ListItem Value="Middle">Middle</asp:ListItem>
                                                <asp:ListItem Value="Bottom">Bottom</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisableQuickEdit" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDisableQuickEdit" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblLabelCellWidth" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtLabelCellWidth" runat="server" CssClass="NormalTextbox" Width="40px">150</asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisableEditMode" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDisableEdit" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblHideHelpImage" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkHideHelp" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblNoSaveResultsToDatabase" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDoNotSaveResultsGlobal" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblOnlyAllowOneSubmission" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkOnlyAllowOnce" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDoNotSaveResultsToRepository" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDoNotSaveResultsToRepository" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblLimitBySubmissionCount" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtLimitBySubmissionCount" runat="server" CssClass="NormalTextbox"
                                                MaxLength="5"></asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblLogDetailsOfAllEvents" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkLogDetailsOfAllEvents" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblForceSameLineOnLabels" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkForceFieldsSameLine" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblWrapAllFieldsWithinDiv" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkWrapAllFieldsWithinDiv" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblEnterKeyForcesSubmit" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkEnterKeyForcesSubmit" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblFocusOnFirstField" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkFocusOnFirstField" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblPassUniqueCompletionID" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkPassUniqueCompletionID" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisplayAfterMessage" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkDisplayAfterMessage" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisplayAfterContinue" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtContinueText" runat="server" CssClass="NormalTextbox">Continue</asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDefaultShortTextbox" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtDefaultShortTextbox" runat="server" CssClass="NormalTextbox"
                                                Width="40px">20</asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDefaultLongTextbox" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtDefaultLong" runat="server" CssClass="NormalTextbox">50</asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblSuffix" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtSuffix" runat="server" CssClass="NormalTextbox">:</asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblCheckBlackList" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkBlackList" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblWordWrapOfQuestions" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkWordWrap" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblRedirectAfterSave" runat="server" Suffix=":"></dnn:Label>
                                            <div class="dnnLeft">
                                                <div class="dnnFormItem">
                                                    <Portal:URL ID="ctlURLRegister" runat="server" Width="300" ShowTrack="False" ShowNewWindow="False"
                                                        ShowLog="False" UrlType="F" ShowUrls="True" ShowFiles="False" ShowTabs="True">
                                                    </Portal:URL>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </fieldset>
                            <h2 id="dshFormLayout" class="dnnFormSectionHead">
                                <a href="#">
                                    <%=LocalizeString("FormLayout")%></a>
                            </h2>
                            <fieldset class="dnnClear">
                                <div class="dnnForm">
                                    <fieldset>
                                        <div class="dnnForm" id="divTabs">
                                            <ul class="dnnAdminTabNav">
                                                <li><a href="#divVal">
                                                    <%=LocalizeString("ResponsiveLayout")%></a></li>
                                                <li><a href="#divSecurity">
                                                    <%=LocalizeString("FormPanels")%></a></li>
                                                <li><a href="#divSystemMessages">
                                                    <%=LocalizeString("HeaderFooter")%></a></li>
                                                <li><a href="#divOptInIntegration">
                                                    <%=LocalizeString("DNNQuestionSortOrder")%></a></li>
                                            </ul>
                                            <div id="divVal" class="dnnClear">
                                                <div class="dnnForm">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <dnn:label id="lblFormLayoutMethod" runat="server" suffix=":"></dnn:label>
                                                                <asp:RadioButtonList ID="optFormLayoutMethod" runat="server" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Value="Responsive" ResourceKey="Responsive" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Value="Tables" ResourceKey="Tables"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblLineBreakHTML" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtLineBreakHTML" runat="server"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                            </div>
                                            <div id="divSecurity" class="dnnClear">
                                                <div class="dnnForm">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litFormPanels" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                            <div class="dnnClear dnnRight">
                                                                <asp:ImageButton ID="imgFormPanels" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1e.gif">
                                                                </asp:ImageButton>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableFormPanelsWithinConfig" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboPanelType" runat="server" CssClass="NormalTextbox">
                                                                    <asp:ListItem Value="Disabled" ResourceKey="Disabled" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Value="DNNSection" ResourceKey="DNNSection"></asp:ListItem>
                                                                    <asp:ListItem Value="DNNPanel" ResourceKey="DNNPanel"></asp:ListItem>
                                                                    <asp:ListItem Value="DNNTab" ResourceKey="DNNTab"></asp:ListItem>
                                                                    <asp:ListItem Value="DNNDiv" ResourceKey="DNNDiv"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <hr />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblFormPanels" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboFormPanels" runat="server" AutoPostBack="True" CssClass="NormalTextbox">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPanelName" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtPanelName" runat="server" MaxLength="1000" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPanelSortOrder" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtPanelSortOrder" runat="server" MaxLength="5" CssClass="NormalTextbox"></asp:TextBox>
                                                                <asp:RangeValidator ID="RangePanelSortOrder" runat="server" ErrorMessage="* Must be integer 0-99999"
                                                                    ControlToValidate="txtPanelSortOrder" MinimumValue="0" MaximumValue="99999"></asp:RangeValidator>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <hr />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <asp:Literal ID="litFormPanels2" runat="server"></asp:Literal>
                                                            </div>
                                                            <div class="dnnFormItem" id="orderlabel2">
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPanelQuestionStartSortOrder" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboPanelStartField" runat="server" CssClass="NormalTextbox">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblPanelQuestionendSortOrder" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboPanelEndField" runat="server" CssClass="NormalTextbox">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <hr />
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblIncludeRule" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkIncludeRule" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblIsExpanded" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkIsExpanded" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblAltPanelCSS" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtAltPanelCSS" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideOrShowPanel" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboHideOrShowPanel" runat="server" CssClass="NormalTextbox"
                                                                    Visible="True">
                                                                    <asp:ListItem Value="0" ResourceKey="Hide"></asp:ListItem>
                                                                    <asp:ListItem Value="1" ResourceKey="Show"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHidePanels" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBoxList ID="chkListRolesForPanels" runat="server" CssClass="dnnFormRadioButtons"
                                                                    DataTextField="RoleName" DataValueField="RoleID" RepeatColumns="2">
                                                                </asp:CheckBoxList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHidePanelsAnonymous" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkHidePanelsAnonymous" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHidePanelsBasedOnEvent" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkPanelsHideQuestionUnlessVisibleByEvent" runat="server"></asp:CheckBox>
                                                            </div>
                                                        </fieldset>
                                                        <ul class="dnnActions dnnClear">
                                                            <li>
                                                                <asp:LinkButton ID="lnkUpdatePanel" CssClass="dnnPrimaryAction" resourcekey="UpdatePanel"
                                                                    runat="server"> Add / Update Panel</asp:LinkButton>
                                                            </li>
                                                            <li>
                                                                <asp:LinkButton ID="lnkDeletePanel" CssClass="dnnSecondaryAction" resourcekey="DeletePanel"
                                                                    runat="server"> Delete Panel </asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                            </div>
                                            <div id="divSystemMessages">
                                                <div class="dnnForm" id="tblMessages" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litSystemMessages" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                            <div class="dnnClear dnnRight">
                                                                <asp:ImageButton ID="imgSystemMessages" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1e.gif">
                                                                </asp:ImageButton>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblMessages" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboMessages" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                                                                <asp:Label ID="lblMessageParameters" runat="server" CssClass="SubHead" Visible="False">Message Parameters</asp:Label>
                                                            </div>
                                                            <div class="dnnFormItem" style="padding-left:350px;">
                                                                <div class="dnnLeft">
                                                                    <div class="dnnFormItem">
                                                                        <dnn:TextEditor ID="txtMessages" runat="server" Height="300" Width="450"></dnn:TextEditor>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <asp:Literal ID="litParameters3" runat="server"></asp:Literal>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <asp:ListBox ID="lstDynamicMessageTokens" runat="server" CssClass="NormalTextBox"
                                                                    Visible="False" Width="160px" Height="325"></asp:ListBox>
                                                            </div>
                                                        </fieldset>
                                                        <ul class="dnnActions dnnClear">
                                                            <li>
                                                                <asp:LinkButton ID="lnkUpdateMessage" CssClass="dnnPrimaryAction" runat="server">Update Message</asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                            </div>
                                            <div id="divOptInIntegration" class="dnnClear">
                                                <div class="dnnForm" id="tblSortOrder" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litSortOrder" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgSortOrder" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1g.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <table>
                                                                    <tr>
                                                                        <td align="left" width="385" height="24">
                                                                            <asp:ListBox ID="lstQuestionSortOrder" runat="server" CssClass="NormalTextbox" Width="100%"
                                                                                Height="192px"></asp:ListBox>
                                                                        </td>
                                                                        <td align="center" width="50" height="24">
                                                                            <p>
                                                                                <asp:Image ID="imgQUP" runat="server" AlternateText="Move Option Up" ImageUrl="~/images/Up.gif">
                                                                                </asp:Image></p>
                                                                            <p>
                                                                                <asp:Image ID="imgQDown" runat="server" AlternateText="Move Option Down" ImageUrl="~/images/dn.gif">
                                                                                </asp:Image></p>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <input id="txthiddensortorder" type="hidden" value="MySortTest" name="txthiddensortorder"
                                                                    runat="server" />
                                                            </div>
                                                        </fieldset>
                                                        <ul class="dnnActions dnnClear">
                                                            <li>
                                                                <asp:LinkButton ID="lnkUpdateQuestionOrder" CssClass="dnnPrimaryAction" runat="server">Update Question Order</asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </fieldset>
                            <h2 id="dshFormFormatting" class="dnnFormSectionHead">
                                <a href="#">
                                    <%=LocalizeString("FormFormatting")%></a>
                            </h2>
                            <fieldset class="dnnClear">
                                <div class="dnnForm">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="PanelsFormatting">
                                                <h2 id="dshStyleSheet" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNStyleSheet")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblStyleSheet" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litStyleSheet" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgStyleSheet" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1h.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <asp:RadioButtonList ID="optStyleSheet" runat="server" AutoPostBack="True" CssClass="dnnFormRadioButtons">
                                                                    <asp:ListItem Value="Standard">Use Standard DNN Style Sheet</asp:ListItem>
                                                                    <asp:ListItem Value="Custom">Use Dynamic Forms Custom Style Sheet</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <asp:TextBox ID="txtStyleSheet" runat="server" CssClass="NormalTextBox" Width="552px"
                                                                    Height="252px" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                        <ul class="dnnActions dnnClear">
                                                            <li>
                                                                <asp:LinkButton ID="lnkUpdateStyleSheet" CssClass="dnnPrimaryAction" runat="server">Update Style Sheet</asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshContentLocalization" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNContentLocalization")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblContentLocalization" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litContentLocalization" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgLocal" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1j.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <div class="dnnForm" id="PanelsContentLocalization">
                                                                    <h2 id="dshFormLocal" class="dnnFormSectionHead">
                                                                        <a href="#">
                                                                            <%=LocalizeString("DNNFormLocal")%></a>
                                                                    </h2>
                                                                    <fieldset class="dnnClear">
                                                                        <div class="dnnForm" id="tblPageLocalization" runat="server">
                                                                            <fieldset>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblFormLocalField" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:DropDownList ID="cboFormLocalField" runat="server" CssClass="NormalTextbox"
                                                                                        AutoPostBack="True">
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblContinueLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtContinueLocal" runat="server" CssClass="NormalTextbox">Continue...</asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem" id="tblLocalMessages" runat="server">
                                                                                    <div class="dnnForm">
                                                                                        <fieldset>
                                                                                            
                                                                                            <div class="dnnFormItem">
                                                                                                <dnn:Label ID="lblLocalMessages" runat="server" Suffix=":"></dnn:Label>
                                                                                                <asp:DropDownList ID="cboLocalFormMessages" runat="server" CssClass="NormalTextbox"
                                                                                                    AutoPostBack="True">
                                                                                                </asp:DropDownList>
                                                                                            </div>
                                                                                            <div class="dnnFormItem">
                                                                                                <asp:Label ID="lblErrorLocal" runat="server" ForeColor="Red"></asp:Label>
                                                                                            </div>
                                                                                            <div class="dnnFormItem">
                                                                                                <asp:Label ID="lblLocalParameters" runat="server" CssClass="SubHead" Visible="False">Message Parameters</asp:Label>
                                                                                                <dnn:TextEditor ID="txtLocalFormHeader" runat="server" Height="300" Width="450">
                                                                                                </dnn:TextEditor>
                                                                                                <dnn:TextEditor ID="txtLocalFormFooter" runat="server" Visible="False" Height="300"
                                                                                                    Width="450"></dnn:TextEditor>
                                                                                                <dnn:TextEditor ID="txtLocalFormAfter" runat="server" Visible="False" Height="300"
                                                                                                    Width="450"></dnn:TextEditor>
                                                                                                <dnn:TextEditor ID="txtLocalFormAfterSaveForLater" runat="server" Visible="False"
                                                                                                    Height="300" Width="450"></dnn:TextEditor>
                                                                                            </div>
                                                                                           
                                                                                        </fieldset>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="dnnFormItem" id="Table4" runat="server">
                                                                                    <div class="dnnForm">
                                                                                        <fieldset>
                                                                                            
                                                                                            <div class="dnnFormItem" style="padding-left:350px;">
                                                                                                <asp:RadioButtonList ID="optLocalSubmit" runat="server" CssClass="dnnFormRadioButtons">
                                                                                                    <asp:ListItem Value="LinkButton">Use Submit Linkbutton</asp:ListItem>
                                                                                                    <asp:ListItem Value="ImageButton">Use Custom Image Submit Button</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </div>
                                                                                            <div class="dnnFormItem">
                                                                                                <dnn:Label ID="lblLocalSubmit" runat="server" Suffix=":"></dnn:Label>
                                                                                                <asp:TextBox ID="txtLocalSubmit" runat="server" CssClass="NormalTextbox">Save</asp:TextBox>
                                                                                            </div>
                                                                                            <div class="dnnFormItem">
                                                                                                <dnn:Label ID="lblLocalImage" runat="server" Suffix=":"></dnn:Label>
                                                                                                <div class="dnnLeft">
                                                                                                    <div class="dnnFormItem">
                                                                                                        <Portal:URL ID="UrlLocalImage" runat="server" ShowTrack="False" ShowNewWindow="False"
                                                                                                            ShowLog="False" UrlType="F" ShowUrls="False" ShowFiles="True" ShowTabs="False">
                                                                                                        </Portal:URL>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </fieldset>
                                                                                        <ul class="dnnActions dnnClear">
                                                                                            <li>
                                                                                                <asp:LinkButton ID="lnkUpdateFormLocal" CssClass="dnnPrimaryAction" runat="server">Update Form Localization</asp:LinkButton>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </fieldset>
                                                                        </div>
                                                                    </fieldset>
                                                                    <h2 id="dshQuestionLocal" class="dnnFormSectionHead">
                                                                        <a href="#">
                                                                            <%=LocalizeString("DNNQuestionLocal")%></a>
                                                                    </h2>
                                                                    <fieldset class="dnnClear">
                                                                        <div class="dnnForm" id="tblQuestionLocalization" runat="server">
                                                                            <fieldset>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblLocalfield" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:DropDownList ID="cblLocalDynamicField" runat="server" CssClass="NormalTextbox"
                                                                                        AutoPostBack="True">
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:DropDownList ID="cboLocalLanguageQuestion" runat="server" CssClass="NormalTextbox"
                                                                                        AutoPostBack="True">
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <hr />
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblFieldLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtLabelLocal" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblHelpLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtHelpLocal" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblExampleTextLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtQuestionExampleLocal" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblRequiredFieldLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtRequiredFieldLocal" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblRequiredValLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtRequiredValLocal" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblExpressionLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtExpressionLocal" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <dnn:Label ID="lblExpressionTextLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                    <asp:TextBox ID="txtRegExpressionLocal" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                </div>
                                                                                <div class="dnnFormItem">
                                                                                    <div class="dnnForm" id="PanelsQuestionLocalization">
                                                                                        <h2 id="dshQuestionHeaderFooterLocal" class="dnnFormSectionHead">
                                                                                            <a href="#">
                                                                                                <%=LocalizeString("DNNSQuestionHeaderFooterLocal")%></a>
                                                                                        </h2>
                                                                                        <fieldset class="dnnClear">
                                                                                            <div class="dnnForm" id="tblQuestionHeaderfooterLocal" runat="server">
                                                                                                <fieldset>
                                                                                                    <div class="dnnFormItem">
                                                                                                        <dnn:Label ID="lblQuestionHeaderLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                                        <dnn:TextEditor ID="txtQuestionHeaderLocal" runat="server" Height="300" Width="450">
                                                                                                        </dnn:TextEditor>
                                                                                                    </div>
                                                                                                    <div class="dnnFormItem">
                                                                                                        <dnn:Label ID="lblQuestionFooterLocal" runat="server" Suffix=":"></dnn:Label>
                                                                                                        <dnn:TextEditor ID="txtQuestionFooterLocal" runat="server" Height="300" Width="450">
                                                                                                        </dnn:TextEditor>
                                                                                                    </div>
                                                                                                </fieldset>
                                                                                                <ul class="dnnActions dnnClear">
                                                                                                    <li>
                                                                                                        <asp:LinkButton ID="lnkUpdateQuestionLocalization" CssClass="dnnPrimaryAction" runat="server">Update Question Localization</asp:LinkButton>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </div>
                                                                                        </fieldset>
                                                                                    </div>
                                                                                </div>
                                                                            </fieldset>
                                                                        </div>
                                                                    </fieldset>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </fieldset>
                          
<h2 id="dnnFormValidationAndSecurity" class="dnnFormSectionHead" runat="server"><a href=""><%=LocalizeString("ValidationConfiguration")%></a></h2>
<fieldset>
<div id="divValTabs">
 <ul class="dnnAdminTabNav">
<li><a href="#divVal"><%=LocalizeString("FormValidation")%></a></li>
<li><a href="#divViewResults"><%=LocalizeString("ViewResultsAndOptions")%></a></li>

<li><a href="#divBlackList"><%=LocalizeString("DNNBlackList")%></a></li>

</ul>
    <fieldset class="dnnClear">
                                <div class="dnnForm" id="tblFormValidation" runat="server">
                                    <fieldset>
                        <div id="divVal" class="dnnClear">
   
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableClient" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkClientValidation" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblASPErrorMessageLocation" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboValErrorMessageLocation" runat="server" CssClass="NormalTextbox">
                                                                    <asp:ListItem Value="Right" resourcekey="RightField"> </asp:ListItem>
                                                                    <asp:ListItem Value="Left" resourcekey="LeftField"> </asp:ListItem>
                                                                    <asp:ListItem Value="Below" resourcekey="BelowField"> </asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableServerValidation" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkServerValidation" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblAutomaticallyShowAsterik" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkShowAsterik" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideValidationSummary" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkHideValidationSummary" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSummaryLocation" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboValLocation" runat="server" CssClass="NormalTextbox">
                                                                    <asp:ListItem Value="Top" resourcekey="lblTop"></asp:ListItem>
                                                                    <asp:ListItem Value="Bottom" resourcekey="lblBottom"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblGlobalValidationMessage" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkGlobalValidationMessage" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblErrorCSSClass" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkShowErrorCSSClass" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblScrollTopBottom" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboValScroll" runat="server" CssClass="NormalTextbox">
                                                                    <asp:ListItem Value="None" resourcekey="lblNone"></asp:ListItem>
                                                                    <asp:ListItem Value="Top" resourcekey="lblTop"></asp:ListItem>
                                                                    <asp:ListItem Value="Bottom" resourcekey="lblBottom"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSetFocusAfterValidation" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkSetFocusAfterValidation" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableSQLValidation" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEnableSQLValidation" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSQLValidationQuery" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtSQLValidationQuery" runat="server" CssClass="NormalTextbox" MaxLength="2000"
                                                                    Height="100" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSQLValidationErrorMessage" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtSQLValidationErrorMessage" runat="server" CssClass="NormalTextbox"
                                                                    MaxLength="4000" Height="100" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                    </div>
 <div id="divViewResults" class="dnnClear">
 
                                <div class="dnnForm" id="tblViewResults" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblViewResultsSecurity" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboDNNRoleViewResults" runat="server" CssClass="NormalTextbox">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAllowNonAdminToDelete" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkAllowNonAdminToDelete" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAllowNonAdminToExport" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkAllowNonAdminToExport" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAllowNonAdminToManageTemplate" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkAllowNonAdminToManageTemplate" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblExportType" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboExportType" runat="server" CssClass="NormalTextbox">
                                                <asp:ListItem Value="Excel" ResourceKey="Excel"></asp:ListItem>
                                                <asp:ListItem Value="Text" ResourceKey="CSV"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblExcelExportDelimiter" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtExcelExportDelimiter" runat="server" MaxLength="2" CssClass="NormalTextbox"></asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAlternateExportMapPath" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtAlternateExportMapPath" runat="server" MaxLength="400" CssClass="NormalTextbox"></asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAlternateExportFolder" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtAlternateExportFolder" runat="server" MaxLength="200" CssClass="NormalTextbox"></asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblExcelExportByShortFieldName" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkExportResultsToExcelViaShortFieldNameForColumns" runat="server">
                                            </asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblDisplayResultsOnUserFacingModule" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboDisplayResultsOnUserFacingModule" runat="server" CssClass="NormalTextbox">
                                                <asp:ListItem Value="None" ResourceKey="NotDisplay"></asp:ListItem>
                                                <asp:ListItem Value="Top" ResourceKey="Above"></asp:ListItem>
                                                <asp:ListItem Value="Bottom" ResourceKey="Below"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </fieldset>
                               </div>
</div>

						<div id="divBlackList">
							<div class="dnnFormItem">
							     <span class='dnnFormMessage dnnFormInfo dynreginfo'>
							<asp:Literal ID="litBlacklist" runat="server"></asp:Literal>
							         </span>

                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgBlacklist" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1f.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <asp:DataGrid ID="dgBlackList" runat="server" CssClass="dnnGrid" ShowFooter="True"
                                                                    AllowSorting="True" AutoGenerateColumns="False" EnableViewState="false" >
                                                                    <footerstyle cssclass="dnnGridFooter" />
                                                                    <alternatingitemstyle cssclass="dnnGridAltItem" />
                                                                    <itemstyle cssclass="dnnGridItem" horizontalalign="Left" />
                                                                    <headerstyle cssclass="dnnGridHeader" verticalalign="Top"/>
                                                                    <Columns>
                                                                        <asp:BoundColumn Visible="False" DataField="DynamicBlackListID" ReadOnly="True">
                                                                        </asp:BoundColumn>
                                                                        <asp:TemplateColumn HeaderText="Blacklisted">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.BlackListResponse") %>'>
                                                                                </asp:Label>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                <asp:TextBox ID="txtBlackListResponse" runat="server" CssClass="normaltextbox" Width="200px"></asp:TextBox>
                                                                            </FooterTemplate>
                                                                            <EditItemTemplate>
                                                                                <asp:TextBox ID="txtEditType" runat="server" CssClass="normaltextbox" Text='<%# DataBinder.Eval(Container, "DataItem.BlackListResponse") %>'>
                                                                                </asp:TextBox>
                                                                            </EditItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn>
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imgDelete" runat="server" AlternateText="Delete" CommandName="Delete"
                                                                                    ImageUrl="~/images/delete.gif"></asp:ImageButton>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                <asp:ImageButton ID="Imagebutton1" runat="server" AlternateText="Add" CommandName="AddType"
                                                                                    ImageUrl="~/images/add.gif"></asp:ImageButton>
                                                                            </FooterTemplate>
                                                                        </asp:TemplateColumn>
                                                                        <asp:TemplateColumn>
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imgEdit" runat="server" AlternateText="Edit" CommandName="Edit"
                                                                                    ImageUrl="~/images/edit.gif"></asp:ImageButton>
                                                                            </ItemTemplate>
                                                                            <EditItemTemplate>
                                                                                <asp:LinkButton runat="server" resourcekey="dgupdatetext" CommandName="Update" ID="Linkbutton1"
                                                                                    NAME="Linkbutton1"></asp:LinkButton>&nbsp;
                                                                                <asp:LinkButton runat="server" Text="Cancel" resourcekey="dgcanceltext" CommandName="Cancel"
                                                                                    CausesValidation="false" ID="Linkbutton3" NAME="Linkbutton2"></asp:LinkButton>
                                                                            </EditItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                    </Columns>
                                                                </asp:DataGrid>
                                                            </div>
                                                </fieldset>
                                               
                                                    </div>
                                                </fieldset>
                                         
                            <h2 id="dshPaymentGateway" class="dnnFormSectionHead">
                                <a href="#">
                                    <%=LocalizeString("PaymentGateway")%></a>
                            </h2>
                            <fieldset class="dnnClear">
                                <div class="dnnForm" id="tblPayment" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                <asp:Literal ID="litPaymentGateway" runat="server"></asp:Literal>
                                            </span>
                                        </div>
                                            <div class="dnnClear dnnRight">
                                                <asp:ImageButton ID="Imagebutton2" runat="server" ImageUrl="~/desktopmodules/dynamic forms/CC.gif">
                                                </asp:ImageButton>
                                            </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="Table4Auth" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEnablePaymentGateway" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboEnablePaymentGateway" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="No" ResourceKey="No"></asp:ListItem>
                                                            <asp:ListItem Value="Yes" ResourceKey="Yes"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblPaymentGateway" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboPaymentGateway" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="Authorizenet" ResourceKey="Authorizenet"></asp:ListItem>
                                                            <asp:ListItem Value="AuthARB" ResourceKey="AuthorizenetARB"></asp:ListItem>
                                                            <asp:ListItem Value="PayPal" ResourceKey="PayPal"></asp:ListItem>
                                                            <asp:ListItem Value="PayFlowPro" ResourceKey="PayFlowPro"></asp:ListItem>
                                                            <asp:ListItem Value="Verifi" ResourceKey="Verifi"></asp:ListItem>
                                                            <asp:ListItem Value="IPPAY" ResourceKey="IPPay"></asp:ListItem>
                                                            <asp:ListItem Value="PaymentsGateway" ResourceKey="PaymentsGateway"></asp:ListItem>

                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblPaymentTestMode" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:CheckBox ID="chkPaymentTestMode" runat="server"></asp:CheckBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblCalculationField" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtCalcField" runat="server" CssClass="NormalTextbox" Height="82px"
                                                            TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <div class="dnnForm">
                                                            <fieldset>
                                                                <div class="dnnFormItem">
                                                                    <div class="dnnForm" id="PanelsPaymentGateway">
                                                                        <h2 id="dshAuthorizeNet" class="dnnFormSectionHead">
                                                                            <a href="#">
                                                                                <%=LocalizeString("AuthorizenetGateway")%></a>
                                                                        </h2>
                                                                        <fieldset class="dnnClear">
                                                                            <div class="dnnForm" id="tblAuthorizenet" runat="server">
                                                                                <fieldset>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblAuthLogin" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtAuthLogin" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblAuthTokens" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstAuthTokens" runat="server" CssClass="NormalTextBox" Width="180px"
                                                                                            Height="300">
                                                                                            <asp:ListItem Value="x_first_name" ResourceKey="x_first_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_last_name" ResourceKey="x_last_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_company" ResourceKey="x_company"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_address" ResourceKey="x_address"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_city" ResourceKey="x_city"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_state" ResourceKey="x_state"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_zip" ResourceKey="x_zip"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_country" ResourceKey="x_country"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_email" ResourceKey="x_email"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_phone" ResourceKey="x_phone"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_fax" ResourceKey="x_fax"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_invoice_num" ResourceKey="x_invoice_num"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_description" ResourceKey="x_description"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_cust_id" ResourceKey="x_cust_id"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_method" ResourceKey="x_method"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_amount" ResourceKey="x_amount"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_recurring_billing" ResourceKey="x_recurring_billing"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_currency_code" ResourceKey="x_currency_code"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_card_num" ResourceKey="x_card_num"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_exp_date" ResourceKey="x_exp_date"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_card_code" ResourceKey="x_card_code"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_echeck_type" ResourceKey="x_echeck_type"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_bank_acct_name" ResourceKey="x_bank_acct_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_bank_acct_num" ResourceKey="x_card_code"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_bank_acct_type" ResourceKey="x_bank_acct_type"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_bank_name" ResourceKey="x_bank_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_bank_aba_code" ResourceKey="x_bank_aba_code"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_customer_organization_type" ResourceKey="x_customer_organization_type"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_customer_tax_id" ResourceKey="x_customer_tax_id"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_drivers_license_num" ResourceKey="x_drivers_license_num"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_drivers_license_state" ResourceKey="x_drivers_license_state"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_drivers_license_dob" ResourceKey="x_drivers_license_dob"></asp:ListItem>
                                                                                            <asp:ListItem Value="x_customer_ip" ResourceKey="x_customer_ip"></asp:ListItem>
                                                                                        </asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblDynamicTokens" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstDynamicTokens" runat="server" CssClass="NormalTextBox" Width="160px"
                                                                                            Height="300"></asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblVerificationCode" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtAuthCode" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblGatewayURL" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:DropDownList ID="cboAuthGateway" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                                                                            <asp:ListItem Value="https://secure.authorize.net/gateway/transact.dll" ResourceKey="AuthProdSite"></asp:ListItem>
                                                                                            <asp:ListItem Value="https://test.authorize.net/gateway/transact.dll" ResourceKey="AuthTestSite"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <asp:Literal ID="litExampleAuthorizenet" runat="server"></asp:Literal>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblAdditionalParameters" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtAuthorizenetParams" runat="server" CssClass="NormalTextbox" Height="124px"
                                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                                    </div>
                                                                                </fieldset>
                                                                            </div>
                                                                        </fieldset>
                                                                        <h2 id="dshPayPal" class="dnnFormSectionHead">
                                                                            <a href="#">
                                                                                <%=LocalizeString("PayPalGateway")%></a>
                                                                        </h2>
                                                                        <fieldset class="dnnClear">
                                                                            <div class="dnnForm" id="tblPayPalGateway" runat="server">
                                                                                <fieldset>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayPalPaymentLogin" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtPayPalLogin" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayPalTokens" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstPayPalTokens" runat="server" CssClass="NormalTextBox" Width="180px"
                                                                                            Height="300">
                                                                                            <asp:ListItem Value="item_name" ResourceKey="item_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="item_number" ResourceKey="item_number"></asp:ListItem>
                                                                                            <asp:ListItem Value="amount" ResourceKey="amount"></asp:ListItem>
                                                                                            <asp:ListItem Value="shipping" ResourceKey="shipping"></asp:ListItem>
                                                                                            <asp:ListItem Value="page_style" ResourceKey="page_style"></asp:ListItem>
                                                                                            <asp:ListItem Value="no_shipping" ResourceKey="no_shipping"></asp:ListItem>
                                                                                            <asp:ListItem Value="currency_code" ResourceKey="currency_code"></asp:ListItem>
                                                                                            <asp:ListItem Value="cn" ResourceKey="cn"></asp:ListItem>
                                                                                            <asp:ListItem Value="quantity" ResourceKey="quantity"></asp:ListItem>
                                                                                            <asp:ListItem Value="handling" ResourceKey="handling"></asp:ListItem>
                                                                                            <asp:ListItem Value="no_note" ResourceKey="no_note"></asp:ListItem>
                                                                                            <asp:ListItem Value="on0" ResourceKey="on0"></asp:ListItem>
                                                                                            <asp:ListItem Value="os0" ResourceKey="os0"></asp:ListItem>
                                                                                            <asp:ListItem Value="on1" ResourceKey="on1"></asp:ListItem>
                                                                                            <asp:ListItem Value="invoice" ResourceKey="invoice"></asp:ListItem>
                                                                                            <asp:ListItem Value="image_url" ResourceKey="image_url"></asp:ListItem>
                                                                                            <asp:ListItem Value="cs" ResourceKey="cs"></asp:ListItem>
                                                                                            <asp:ListItem Value="email" ResourceKey="email"></asp:ListItem>
                                                                                            <asp:ListItem Value="first_name" ResourceKey="first_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="last_name" ResourceKey="last_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="address1" ResourceKey="address1"></asp:ListItem>
                                                                                            <asp:ListItem Value="address2" ResourceKey="address2"></asp:ListItem>
                                                                                            <asp:ListItem Value="city" ResourceKey="city"></asp:ListItem>
                                                                                            <asp:ListItem Value="state" ResourceKey="state"></asp:ListItem>
                                                                                            <asp:ListItem Value="zip" ResourceKey="zip"></asp:ListItem>
                                                                                            <asp:ListItem Value="night_phone_a" ResourceKey="night_phone_a"></asp:ListItem>
                                                                                            <asp:ListItem Value="night_phone_b" ResourceKey="night_phone_b"></asp:ListItem>
                                                                                            <asp:ListItem Value="day_phone_a" ResourceKey="day_phone_a"></asp:ListItem>
                                                                                            <asp:ListItem Value="day_phone_b" ResourceKey="day_phone_b"></asp:ListItem>
                                                                                        </asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblDynamicTokens2" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstDynamicTokens2" runat="server" CssClass="NormalTextBox" Height="300">
                                                                                        </asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayPalPaymentType" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:DropDownList ID="cboPayPalPaymentType" runat="server" CssClass="NormalTextbox">
                                                                                            <asp:ListItem Value="Purchase" ResourceKey="PayPalPurchase">Purchase</asp:ListItem>
                                                                                            <asp:ListItem Value="Subscription" ResourceKey="PayPalSubscription">Subscription</asp:ListItem>
                                                                                            <asp:ListItem Value="Donation" ResourceKey="PayPalDonation"></asp:ListItem>
                                                                                            <asp:ListItem Value="Cart" ResourceKey="PayPalShoppingCart"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayPalURL" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:DropDownList ID="cboPayPalURL" runat="server" CssClass="NormalTextbox">
                                                                                            <asp:ListItem Value="https://www.paypal.com/cgi-bin/webscr" ResourceKey="PayPalProdSite"></asp:ListItem>
                                                                                            <asp:ListItem Value="https://www.sandbox.paypal.com" ResourceKey="PayPalTestSite"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <asp:Literal ID="litExamplePayPal" runat="server"></asp:Literal>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayPalParameters" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtPayPalParams" runat="server" CssClass="NormalTextbox" Height="141px"
                                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayPalLastStatus" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:DropDownList ID="cboPayPalLastStatus" runat="server" CssClass="NormalTextbox"
                                                                                            AutoPostBack="False">
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblFormCompletionEvents" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:DropDownList ID="cboCompletionEventsForPayPal" runat="server" CssClass="NormalTextbox"
                                                                                            AutoPostBack="True">
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayPalPaymentStatus" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:CheckBoxList ID="chkPayPalStatusCodes" runat="server" RepeatColumns="1" CssClass="dnnFormRadioButtons">
                                                                                            <asp:ListItem Value="BeforePayPal" ResourceKey="BeforePayPal"></asp:ListItem>
                                                                                            <asp:ListItem Value="RedirectSucess" ResourceKey="RedirectSucess"></asp:ListItem>
                                                                                            <asp:ListItem Value="RedirectCancel" ResourceKey="RedirectAfterCancel"></asp:ListItem>
                                                                                            <asp:ListItem Value="web_accept" ResourceKey="Completed_Standard">Completed (Standard)</asp:ListItem>
                                                                                            <asp:ListItem Value="Pending" ResourceKey="Pending">Pending</asp:ListItem>
                                                                                            <asp:ListItem Value="subscr_signup" ResourceKey="Completed_SubscriptionSignUp">Completed (Subscription Sign Up)</asp:ListItem>
                                                                                            <asp:ListItem Value="subscr_payment" ResourceKey="Completed_SubscriptionPayment">Completed (Subscription Payment)</asp:ListItem>
                                                                                            <asp:ListItem Value="subscr_failed" ResourceKey="Completed_SubscriptionFailed">Completed (Subscription Payment Failed)</asp:ListItem>
                                                                                            <asp:ListItem Value="subscr_cancel" ResourceKey="Completed_Cancelled">Completed (Subscription Cancellation)</asp:ListItem>
                                                                                            <asp:ListItem Value="subscr_eot" ResourceKey="Completed_SubscriptionEOT">Completed (Subscription End of Terms)</asp:ListItem>
                                                                                            <asp:ListItem Value="Failed" ResourceKey="Failed">Failed</asp:ListItem>
                                                                                            <asp:ListItem Value="Denied" ResourceKey="Denied">Denied</asp:ListItem>
                                                                                            <asp:ListItem Value="Refunded" ResourceKey="Refunded"></asp:ListItem>
                                                                                        </asp:CheckBoxList>
                                                                                    </div>
                                                                                </fieldset>
                                                                                <ul class="dnnActions dnnClear">
                                                                                    <li>
                                                                                        <asp:LinkButton ID="lnkEventPayPalStatus" ResourceKey="lnkEventPayPalStatus" CssClass="dnnPrimaryAction"
                                                                                            runat="server"></asp:LinkButton>
                                                                                    </li>
                                                                                </ul>
                                                                            </div>
                                                                        </fieldset>
                                                                        <h2 id="dshPayFlowPro" class="dnnFormSectionHead">
                                                                            <a href="#">
                                                                                <%=LocalizeString("PayFlowPro")%></a>
                                                                        </h2>
                                                                        <fieldset class="dnnClear">
                                                                            <div class="dnnForm" id="tblPayFlowPro" runat="server">
                                                                                <fieldset>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayFlowProLogin" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtPayFlowProLogin" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayFlowProTokens" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstPayFlowProTokens" runat="server" CssClass="NormalTextBox" Width="180px"
                                                                                            Height="300">
                                                                                            <asp:ListItem Value="AMT"></asp:ListItem>
                                                                                            <asp:ListItem Value="TRXTYPE"></asp:ListItem>
                                                                                            <asp:ListItem Value="TENDER"></asp:ListItem>
                                                                                            <asp:ListItem Value="EXPDATE"></asp:ListItem>
                                                                                            <asp:ListItem Value="ACCT"></asp:ListItem>
                                                                                            <asp:ListItem Value="CVV2"></asp:ListItem>
                                                                                            <asp:ListItem Value="FIRSTNAME"></asp:ListItem>
                                                                                            <asp:ListItem Value="EMAIL"></asp:ListItem>
                                                                                            <asp:ListItem Value="LASTNAME"></asp:ListItem>
                                                                                            <asp:ListItem Value="STREET"></asp:ListItem>
                                                                                            <asp:ListItem Value="STATE"></asp:ListItem>
                                                                                            <asp:ListItem Value="CITY"></asp:ListItem>
                                                                                            <asp:ListItem Value="ZIP"></asp:ListItem>
                                                                                            <asp:ListItem Value="COUNTRY"></asp:ListItem>
                                                                                            <asp:ListItem Value="COMMENT1"></asp:ListItem>
                                                                                        </asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblDynamicTokens3" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstDynamicTokens3" runat="server" CssClass="NormalTextBox" Width="160px"
                                                                                            Height="300"></asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayFlowProPassword" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtPayFlowProPassword" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayFlowProPartner" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtPayFlowProPartner" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayFlowProVendor" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtPayFlowProVendor" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayFlowProURL" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:DropDownList ID="cboPayFlowProURL" runat="server" CssClass="NormalTextbox">
											<asp:ListItem Value="https://pilot-payflowpro.paypal.com" ResourceKey="PayFlowProPilot"></asp:ListItem>
											<asp:ListItem Value="https://payflowpro.paypal.com" ResourceKey="PayFlowProProd"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <asp:Literal ID="litExamplePayFlowPro" runat="server"></asp:Literal>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblPayFlowProParameters" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtPayFlowProParams" runat="server" CssClass="NormalTextbox" Height="141px"
                                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                                    </div>
                                                                                </fieldset>
                                                                            </div>
                                                                        </fieldset>
                                                                        <h2 id="dshVerifi" class="dnnFormSectionHead">
                                                                            <a href="#">
                                                                                <%=LocalizeString("Verifi")%></a>
                                                                        </h2>
                                                                        <fieldset class="dnnClear">
                                                                            <div class="dnnForm" id="tblVerifi" runat="server">
                                                                                <fieldset>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblVerifiUsername" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtVerifiUsername" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblVerifiTokens" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstVerifiTokens" runat="server" CssClass="NormalTextBox" Height="300">
                                                                                            <asp:ListItem Value="AMT"></asp:ListItem>
                                                                                        </asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblDynamicTokens4" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:ListBox ID="lstDynamicTokens4" runat="server" CssClass="NormalTextBox" Width="160px"
                                                                                            Height="300"></asp:ListBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblVerifiPassword" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtVerifiPassword" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblVerifiURL" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:DropDownList ID="cboVerifiURL" runat="server" CssClass="NormalTextbox">
                                                                                            <asp:ListItem Value="https://secure.verifi.com/gw/api/transact.php" ResourceKey="VerifiTest"></asp:ListItem>
                                                                                            <asp:ListItem Value="https://secure.verifi.com/gw/api/transact.php" ResourceKey="VerifiProd"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <asp:Literal ID="litExampleVerifi" runat="server"></asp:Literal>
                                                                                    </div>
                                                                                    <div class="dnnFormItem">
                                                                                        <dnn:Label ID="lblVerifiParameters" runat="server" Suffix=":"></dnn:Label>
                                                                                        <asp:TextBox ID="txtVerifiParams" runat="server" CssClass="NormalTextbox" Height="141px"
                                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                                    </div>
                                                                                </fieldset>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </fieldset>
                            <h2 id="dshFormLinks" class="dnnFormSectionHead">
                                <a href="#">
                                    <%=LocalizeString("FormLinks")%></a>
                            </h2>
                            <fieldset class="dnnClear">
                                <div class="dnnForm" id="tblFormLinks" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="PanelsLinks">
                                                <h2 id="dshSaveButton" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNSaveButton")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litSaveLinkButton" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                            <div class="dnnClear dnnRight">
                                                                <asp:ImageButton ID="imgSaveButton" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1i.gif">
                                                                </asp:ImageButton>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <asp:RadioButtonList ID="optSaveType" runat="server" AutoPostBack="True" CssClass="dnnFormRadioButtons">
                                                                    <asp:ListItem Value="LinkButton">Use Submit Linkbutton</asp:ListItem>
                                                                    <asp:ListItem Value="ImageButton">Use Custom Image Submit Button</asp:ListItem>
                                                                    <asp:ListItem Value="HTMLInputButton"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblInitiallyHide" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkInitiallyHideSubmitButton" runat="server" Visible="True"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblDisplayToRight" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkDisplaySubmitToRight" runat="server" Visible="True"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSaveText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtSaveText" runat="server" CssClass="NormalTextbox">Save</asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblImage" runat="server" Suffix=":"></dnn:Label>
                                                                <div class="dnnLeft">
                                                                    <div class="dnnFormItem">
                                                                        <Portal:URL ID="ctlImage" runat="server" Width="300" ShowTrack="False" ShowNewWindow="False"
                                                                            ShowLog="False" UrlType="F" ShowUrls="False" ShowFiles="True" ShowTabs="False">
                                                                        </Portal:URL>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshSaveForLaterButton" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNSaveForLaterButton")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblSaveForLaterButton" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litSaveForLaterLinkButton" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgSaveForLaterButton" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1i.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <asp:RadioButtonList ID="optSaveForLaterType" runat="server" AutoPostBack="False"
                                                                    CssClass="dnnFormRadioButtons">
                                                                    <asp:ListItem Value="LinkButton">Use Save for Later Linkbutton</asp:ListItem>
                                                                    <asp:ListItem Value="ImageButton">Use Custom Image Save for Later Button</asp:ListItem>
                                                                    <asp:ListItem Value="HTMLInputButton">Use Save for Later HTML Input Button</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableSaveForLaterButton" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEnableSaveForLaterButton" runat="server" Visible="True"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSaveForLaterText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtSaveForLaterText" runat="server" CssClass="NormalTextbox">Save for Later</asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblImageForLater" runat="server" Suffix=":"></dnn:Label>
                                                                <div class="dnnLeft">
                                                                    <div class="dnnFormItem">
                                                                        <Portal:URL ID="ctlImageForLater" runat="server" Width="300" ShowTrack="False" ShowNewWindow="False"
                                                                            ShowLog="False" UrlType="F" ShowUrls="False" ShowFiles="True" ShowTabs="False">
                                                                        </Portal:URL>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshClearButton" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNClearButton")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblClearButton" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                    <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                        <asp:Literal ID="litClearLinkButton" runat="server"></asp:Literal>
                                                                    </span>
                                                            </div>  
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgClearButton" runat="server" ImageUrl="~/desktopmodules/dynamic forms/RefreshIcon2.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableClearButton" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEnableClearButton" runat="server" Visible="True"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblClearButtonType" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:RadioButtonList ID="optClearType" runat="server" CssClass="dnnFormRadioButtons">
                                                                    <asp:ListItem Value="LinkButton" ResourceKey="UseClearLinkButton"></asp:ListItem>
                                                                    <asp:ListItem Value="ImageButton" ResourceKey="UseClearImageButton"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblClearFunctionality" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:RadioButtonList ID="optClearFunctionality" runat="server" CssClass="dnnFormRadioButtons">
                                                                    <asp:ListItem Value="JavascriptReset" ResourceKey="JavascriptClear"></asp:ListItem>
                                                                    <asp:ListItem Value="PageRefresh" ResourceKey="ReloadPage"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblClearText" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtClearText" runat="server" CssClass="NormalTextbox">Clear Results</asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblClearMessage" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtClearMessage" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblClearImage" runat="server" Suffix=":"></dnn:Label>
                                                                <div class="dnnLeft">
                                                                    <div class="dnnFormItem">
                                                                        <Portal:URL ID="ctlClearImage" runat="server" Width="300" ShowTrack="False" ShowNewWindow="False"
                                                                            ShowLog="False" UrlType="F" ShowUrls="False" ShowFiles="True" ShowTabs="False">
                                                                        </Portal:URL>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </fieldset>
                           
                           
                            <h2 id="dshFormCoding" class="dnnFormSectionHead">
                                <a href="#">
                                    <%=LocalizeString("FormCoding")%></a>
                            </h2>
                            <fieldset class="dnnClear">
                                <div class="dnnForm" id="tblFormCoding" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="PanelsFormCoding">
                                                <h2 id="dshAJAX" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("AJAXJQUERY")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblAJAX" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                    <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                        <asp:Literal ID="litAJAX" runat="server"></asp:Literal>
                                                                    </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgAJAX" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1e.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblDisableAJAXWithinConfig" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkDisableConfigAJAX" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblDisableFormAJAX" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboFormAJAX" runat="server" CssClass="NormalTextbox">
                                                                    <asp:ListItem Value="True" resourcekey="Disabled"> </asp:ListItem>
                                                                    <asp:ListItem Value="Processing" resourcekey="AJAXProcessing"> </asp:ListItem>
                                                                    <asp:ListItem Value="Both" resourcekey="AJAXBoth"> </asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnableEZCheckboxjQuery" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEnablejQueryEZCheckbox" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblEnablejQueryHighlights" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkEnablejQueryHighlights" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideModalPopup" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkHideModalPopup" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblHideModalPopupImage" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkHideModalPopupImage" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblAltModalPopupImage" runat="server" Suffix=":"></dnn:Label>
                                                                <div class="dnnLeft">
                                                                    <div class="dnnFormItem">
                                                                        <Portal:URL ID="ctlAltModalPopupImage" runat="server" Width="300" Required="False"
                                                                            ShowTrack="False" ShowNewWindow="False" ShowNone="True" ShowLog="False" UrlType="F"
                                                                            ShowUrls="False" ShowFiles="True" ShowTabs="False"></Portal:URL>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <asp:HyperLink ID="hypAJAXImage" runat="server" Target="_blank" resourcekey="GenerateImage"
                                                                    CssClass="dnnPrimaryAction" NavigateUrl="http://www.ajaxload.info" Visible="true"></asp:HyperLink>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblAltModalPopupMessage" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtAltModalPopupMessage" runat="server" CssClass="NormalTextbox"
                                                                    MaxLength="2000" Height="100" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshJavascriptFile" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNCustomJavaScript")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblJavaScriptFile" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litJavaScriptFile" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgJavascriptFile" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1h.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblInitialJavascript" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtInitialJavascript" runat="server" CssClass="NormalTextbox" Height="82px"
                                                                    TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblSaveJavascript" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtSaveJavascript" runat="server" CssClass="NormalTextbox" Height="82px"
                                                                    TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblInitialJavascriptFile" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtJavaScriptFile" runat="server" CssClass="NormalTextBox" Height="252px"
                                                                    TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                        <ul class="dnnActions dnnClear">
                                                            <li>
                                                                <asp:LinkButton ID="lnkUpdateJavaScriptFile" CssClass="dnnPrimaryAction" runat="server">Update Javascript File</asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshInitialSQLBind" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNInitialSQLBind")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblInitialSQLBind" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litInitialSQLBind" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgInitialSQLBind" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1m.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblInitialSQLBindEnabled" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:CheckBox ID="chkInitialSQLBindEnabled" runat="server"></asp:CheckBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblInitialSQLBindAttachedToQuery" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtInitialBindQuerystringOnly" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblInitialSQLBind" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtInitialSQLBind" runat="server" CssClass="NormalTextBox" Width="475px"
                                                                    Height="252px" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblExternalConnectionDataBind" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:TextBox ID="txtExternalConnectionDataBind" runat="server" CssClass="NormalTextbox"
                                                                    Height="50" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                                <h2 id="dshDatabaseProviderType" class="dnnFormSectionHead">
                                                    <a href="#">
                                                        <%=LocalizeString("DNNDatabaseProvider")%></a>
                                                </h2>
                                                <fieldset class="dnnClear">
                                                    <div class="dnnForm" id="tblDatabaseProvider" runat="server">
                                                        <fieldset>
                                                            <div class="dnnFormItem">
                                                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                    <asp:Literal ID="litDatabaseProvider" runat="server"></asp:Literal>
                                                                </span>
                                                            </div>
                                                                <div class="dnnClear dnnRight">
                                                                    <asp:ImageButton ID="imgDataBindBind" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1m.gif">
                                                                    </asp:ImageButton>
                                                                </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblDBType" runat="server" Suffix=":"></dnn:Label>
                                                                <asp:DropDownList ID="cboDBType" runat="server" CssClass="NormalTextbox">
                                                                    <asp:ListItem Value="SQL" ResourceKey="SQLServer"></asp:ListItem>
                                                                    <asp:ListItem Value="Oracle" ResourceKey="Oracle"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="dnnFormItem">
                                                                <dnn:Label ID="lblDatabaseProviderExternalConnectionDataBind" runat="server" Suffix=":">
                                                                </dnn:Label>
                                                                <asp:TextBox ID="txtDatabaseProviderExternalConnection" runat="server" CssClass="NormalTextbox"
                                                                    Height="50" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </fieldset>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div id="dynamicformseventsdiv" align="left">
    <asp:UpdatePanel ID="UpdatePanelEvents" runat="server">
        <ContentTemplate>
            <div class="dnnForm dnnClear">
                <fieldset>
                    <div class="dnnFormItem">
                        <div class="dnnForm" id="PanelsFormCompletionEvents">
                            <h2 id="dshEvents" class="dnnFormSectionHead">
                                <a href="#">
                                    <%=LocalizeString("SystemEvents")%></a>
                            </h2>
                            <fieldset class="dnnClear">
                                <div class="dnnForm" id="tblEvents" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                <asp:Literal ID="litEventsInfo" runat="server"></asp:Literal>
                                            </span>
                                        </div>
                                        <div class="dnnClear dnnRight">
                                            <asp:ImageButton ID="imgevents" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1k.gif">
                                            </asp:ImageButton>
                                        </div>
                                        <div class="dnnFormItem">
                                            <div class="dnnForm" id="Table10" runat="server">
                                                <fieldset>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEvent" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboEvents" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem" id="rowCloneEvents" runat="server">
                                                        <dnn:Label ID="lblCloneEvents" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboCloneEvents" runat="server" CssClass="NormalTextbox" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEventName" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtEventName" runat="server" CssClass="NormalTextbox" Enabled="False"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEventSortOrder" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:TextBox ID="txtEventSortOrder" runat="server" CssClass="NormalTextbox" Enabled="False"></asp:TextBox>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEventType" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:RadioButtonList ID="optEventType" runat="server" AutoPostBack="True" CssClass="dnnFormRadioButtons"
                                                            RepeatColumns="2" RepeatDirection="Horizontal" Enabled="False">
                                                            <asp:ListItem Value="redirect">Redirect After Registration</asp:ListItem>
                                                            <asp:ListItem Value="SQL">SQL Database Insert</asp:ListItem>
                                                            <asp:ListItem Value="Email">Distribute Email</asp:ListItem>
                                                            <asp:ListItem Value="Role">Add User to Role</asp:ListItem>
                                                            <asp:ListItem Value="FormPost">HTTP Form Post</asp:ListItem>
                                                            <asp:ListItem Value="PDF">Create PDF File</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                    <div class="dnnFormItem" id="rowFireEventWhen" runat="server">
                                                        <dnn:Label ID="lblFireThisEvent" runat="server" Suffix=":"></dnn:Label>
                                                        <asp:DropDownList ID="cboFireEvent" runat="server" CssClass="NormalTextbox">
                                                            <asp:ListItem Value="0"></asp:ListItem>
                                                            <asp:ListItem Value="1"></asp:ListItem>
                                                            <asp:ListItem Value="2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="dnnFormItem">
                                                        <dnn:Label ID="lblEventDetails" runat="server" Suffix=":"></dnn:Label>
                                                    </div>
                                                    <div class="dnnFormItem" id="pnlEventDetails" runat="server">
                                                        <div class="dnnForm">
                                                            <fieldset>
                                                                <div class="dnnFormItem">
                                                                    <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                                                        <asp:Literal ID="litEventsDetails" runat="server"></asp:Literal>
                                                                    </span>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblUserInputField" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:DropDownList ID="cboEventDynamicFields" runat="server" CssClass="NormalTextbox"
                                                                        AutoPostBack="True" Enabled="False">
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblUserInputResponse" runat="server" Suffix=":"></dnn:Label>
                                                                    <asp:DropDownList ID="cboEventCondition" runat="server" CssClass="NormalTextbox"
                                                                        AutoPostBack="False" Enabled="True">
                                                                        <asp:ListItem Value="0" ResourceKey="equals"></asp:ListItem>
                                                                        <asp:ListItem Value="1" ResourceKey="notequal"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="dnnFormItem" style="padding-left:350px;">
                                                                        <asp:TextBox ID="txtEventTextbox" runat="server" CssClass="NormalTextbox" Enabled="False"></asp:TextBox>
                                                                    <asp:DropDownList ID="optEventDropdownlist" runat="server" CssClass="NormalTextBox"
                                                                        Visible="False">
                                                                    </asp:DropDownList>
                                                                    <asp:RadioButtonList ID="optEventRadioList" runat="server" Visible="False" CssClass="dnnFormRadioButtons">
                                                                    </asp:RadioButtonList>
                                                                    <asp:CheckBox ID="chkEventCheckbox" runat="server" Visible="False"></asp:CheckBox>
                                                                    <asp:ListBox ID="lstEventListbox" runat="server" CssClass="NormalTextbox" Visible="False">
                                                                    </asp:ListBox>
                                                                    <asp:CheckBoxList ID="chkEventCheckBoxList" runat="server" Visible="False" CssClass="dnnFormRadioButtons">
                                                                    </asp:CheckBoxList>
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <hr />
                                                                </div>
                                                                <div class="dnnFormItem">
                                                                    <dnn:Label ID="lblLinkedAction" runat="server" Suffix=":"></dnn:Label>
                                                                </div>
                                                                <div class="dnnFormItem" id="pnlHTTPEvent" runat="server">
                                                                    <div class="dnnForm">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblHTTPPost" runat="server" Suffix=":"></dnn:Label>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblHTTPEventURL" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtHTTPEventURL" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblHTTPEventPost" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtHttpPostEvent" runat="server" CssClass="NormalTextbox" TextMode="MultiLine"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblEmailResultsToAdmin" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:CheckBox ID="chkEmailResultsToAdmin" runat="server" CssClass="NormalTextbox">
                                                                                </asp:CheckBox>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem" id="pnlRoleEvents" runat="server">
                                                                    <div class="dnnForm">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblRole" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:DropDownList ID="cboDNNRole" runat="server" CssClass="NormalTextbox" Enabled="False">
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblRoleEventType" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:DropDownList ID="cboRoleEventType" runat="server" CssClass="NormalTextbox" Enabled="False"
                                                                                    RepeatDirection="Horizontal">
                                                                                    <asp:ListItem Value="0" ResourceKey="AddRemove"></asp:ListItem>
                                                                                    <asp:ListItem Value="1" ResourceKey="AddOnly"></asp:ListItem>
                                                                                    <asp:ListItem Value="2" ResourceKey="RemoveOnly"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblExpireType" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:RadioButtonList ID="optRoleEventStaticOrDays" runat="server" AutoPostBack="False"
                                                                                    CssClass="dnnFormRadioButtons" Enabled="False" RepeatDirection="Horizontal">
                                                                                    <asp:ListItem Value="0" ResourceKey="Days"></asp:ListItem>
                                                                                    <asp:ListItem Value="1" ResourceKey="StaticDate"></asp:ListItem>
                                                                                </asp:RadioButtonList>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblExpireDates" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtRoleExpiredate" runat="server" CssClass="NormalTextbox" Enabled="true"></asp:TextBox>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem" id="pnlEventPage" runat="server" visible="false">
                                                                    <div class="dnnForm" id="Table9">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblPage" runat="server" Suffix=":"></dnn:Label>
                                                                                <div class="dnnLeft">
                                                                                    <div class="dnnFormItem">
                                                                                        <Portal:URL ID="ctlURLEventURL" runat="server" Width="300" ShowTabs="True" ShowFiles="False"
                                                                                            ShowUrls="True" UrlType="F" ShowLog="False" ShowNewWindow="False" ShowTrack="False">
                                                                                        </Portal:URL>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem" id="pnlSQLDatabaseInsert" runat="server" visible="true">
                                                                    <div class="dnnForm" id="tblSQLEvents">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblSQLStatement" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtSQLStatement" runat="server" CssClass="NormalTextBox" Height="400"
                                                                                    TextMode="MultiLine"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:Literal ID="litParameters2" runat="server"></asp:Literal>
                                                                                <asp:ListBox ID="lstDynamicSQLTokens" runat="server" CssClass="NormalTextBox" Visible="True"
                                                                                    Height="340"></asp:ListBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:Label ID="lblMessageParameters2" runat="server" CssClass="SubHead" Visible="False"
                                                                                    Width="244px">Message Parameters</asp:Label><br />
                                                                                <asp:Label ID="lblSQLHelp" runat="server" CssClass="SubHead" Visible="False" Width="250px">SQL Help</asp:Label><br />
                                                                                <asp:LinkButton ID="lnkGenCreateTable" runat="Server" ResourceKey="GenCreateTable"></asp:LinkButton><br />
                                                                                <asp:LinkButton ID="lnkGenInsertStatement" runat="Server" ResourceKey="GenInsert"></asp:LinkButton><br />
                                                                                <asp:LinkButton ID="lnkGenUpdateStatement" runat="Server" ResourceKey="GenUpdate"></asp:LinkButton><br />
                                                                                <asp:LinkButton ID="lnkGenDeleteStatement" runat="Server" ResourceKey="GenDelete"></asp:LinkButton><br />
                                                                                <br />
                                                                                <dnn:Label ID="lblExternalConnection" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtExternalConnection" runat="server" CssClass="NormalTextbox" Height="50"
                                                                                    TextMode="MultiLine"></asp:TextBox>
                                                                                <br />
                                                                                <dnn:Label ID="lblSQLFailedRedirect" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtSQLFailedRedirectURL" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem" id="pnlPDFCreation" runat="server" visible="false">
                                                                    <div class="dnnForm" id="tblPDF">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblPDFDoc" runat="server" Suffix=":"></dnn:Label>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblPDFHeader" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtPDFHeader" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:LinkButton ID="lnkGenResultsPDF" runat="Server" ResourceKey="GenResults"></asp:LinkButton><br />
                                                                                <asp:LinkButton ID="lnkGenFullResultsPDF" runat="Server" ResourceKey="GenFullResults"></asp:LinkButton>
                                                                                <asp:Label ID="lblParametersPDF" runat="server" CssClass="SubHead" Visible="False"
                                                                                    Width="144px">Message Parameters</asp:Label>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblPDFFooter" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtPDFFooter" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblPDFDesc" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtPDFDESC" runat="server" CssClass="NormalTextbox" Height="50"
                                                                                    TextMode="MultiLine"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:Literal ID="litParametersPDF" runat="server"></asp:Literal>
                                                                                <asp:ListBox ID="lstDynamicPDFTokens" runat="server" CssClass="NormalTextBox" Visible="True"
                                                                                    Width="160px" Height="325"></asp:ListBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblShowPageNumbers" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:DropDownList ID="cboPDFPageNumbers" runat="server" CssClass="NormalTextbox"
                                                                                    Enabled="True" RepeatDirection="Horizontal">
                                                                                    <asp:ListItem Value="0" ResourceKey="No"></asp:ListItem>
                                                                                    <asp:ListItem Value="1" ResourceKey="Yes"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:TextEditor ID="txtPDFTemplate" runat="server" Width="450" Height="300"></dnn:TextEditor>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                                <div class="dnnFormItem" id="pnlEmailEvent" runat="server" visible="false">
                                                                    <div class="dnnForm" id="Table12">
                                                                        <fieldset>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblEmailMessage" runat="server" Suffix=":"></dnn:Label>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblEmailFrom" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtEmailFrom" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:LinkButton ID="lnkGenResults" runat="Server" ResourceKey="GenResults"></asp:LinkButton><br />
                                                                                <asp:LinkButton ID="lnkGenFullResults" runat="Server" ResourceKey="GenFullResults"></asp:LinkButton>
                                                                                <asp:Label ID="lblParameters" runat="server" CssClass="SubHead" Visible="False" Width="144px">Message Parameters</asp:Label>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblFromEmailName" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtEmailFromName" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblEmailTo" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtEmailTo" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <asp:Literal ID="litParameters" runat="server"></asp:Literal>
                                                                                <asp:ListBox ID="lstDynamicEmailTokens" runat="server" CssClass="NormalTextBox" Visible="True"
                                                                                    Width="160px" Height="325"></asp:ListBox>
                                                                            </div>
                                                                            <div class="dnnFormItem">
                                                                                <dnn:Label ID="lblEmailSubject" runat="server" Suffix=":"></dnn:Label>
                                                                                <asp:TextBox ID="txtEmailSubject" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                            </div>


                                                                            <div class="dnnFormItem">
                                                                                <div class="dnnForm" id="PanelsAdvacedEmailProperties">
                                                                                    <h2 id="dshAdvancedEmailProperties" class="dnnFormSectionHead">
                                                                                        <a href="#">
                                                                                            <%=LocalizeString("AdvancedEmailProperties")%></a>
                                                                                    </h2>
                                                                                    <fieldset class="dnnClear">
                                                                                        <div class="dnnForm" id="tblAdvancedEmailEvent" runat="server">
                                                                                            <fieldset>
                                                                                                <div class="dnnFormItem">
                                                                                                    <dnn:Label ID="lblCC" runat="server" Suffix=":"></dnn:Label>
                                                                                                    <asp:TextBox ID="txtCC" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                                </div>
                                                                                                <div class="dnnFormItem">
                                                                                                    <dnn:Label ID="lblBCC" runat="server" Suffix=":"></dnn:Label>
                                                                                                    <asp:TextBox ID="txtBCC" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                                </div>
                                                                                                <div class="dnnFormItem">
                                                                                                    <dnn:Label ID="lblAltEncoding" runat="server" Suffix=":"></dnn:Label>
                                                                                                    <asp:TextBox ID="txtAltEncoding" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                                                                                </div>
                                                                                                <div class="dnnFormItem">
                                                                                                    <dnn:Label ID="lblEmailFormat" runat="server" Suffix=":"></dnn:Label>
                                                                                                    <asp:DropDownList ID="cboEmailFormat" runat="server">
                                                                                                        <asp:ListItem resourcekey="HTML" Value="0"></asp:ListItem>
                                                                                                        <asp:ListItem resourcekey="Text" Value="1"></asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div class="dnnFormItem">
                                                                                                    <dnn:Label ID="lblPriority" runat="server" Suffix=":"></dnn:Label>
                                                                                                    <asp:DropDownList ID="cboEmailPriority" runat="server" CssClass="NormalTextbox">
                                                                                                        <asp:ListItem Value="Normal" ResourceKey="Normal">Normal</asp:ListItem>
                                                                                                        <asp:ListItem Value="Low" ResourceKey="Low">Low</asp:ListItem>
                                                                                                        <asp:ListItem Value="High" ResourceKey="High">High</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div class="dnnFormItem">
                                                                                                    <dnn:Label ID="lblAttachFiletoEmail" runat="server" Suffix=":"></dnn:Label>
                                                                                                    <asp:CheckBox ID="chkAttachFileToEmail" runat="server"></asp:CheckBox>
                                                                                                </div>
                                                                                                <div class="dnnFormItem">
                                                                                                    <dnn:Label ID="lblFileAttachment" runat="server" Suffix=":"></dnn:Label>
                                                                                                    <div class="dnnLeft">
                                                                                                        <div class="dnnFormItem">
                                                                                                            <Portal:URL ID="ctlFileAttachment" runat="server" Width="300" ShowTabs="False" ShowFiles="True"
                                                                                                                ShowUrls="False" UrlType="F" ShowLog="False" ShowNewWindow="False" ShowTrack="False">
                                                                                                            </Portal:URL>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </fieldset>
                                                                                        </div>

                                                                                    </fieldset>
<div class="dnnRight">

<dnn:texteditor id="txtEventEmailMessage" runat="server" width="600" height="400"></dnn:texteditor>
</div>

                                                                                </div>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                    <ul class="dnnActions dnnClear">
                                        <li>
                                            <asp:LinkButton ID="lnkUpdateEvent" CssClass="dnnPrimaryAction" runat="server">Update Event</asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="lnkDeleteEvent" CssClass="dnnSecondaryAction" runat="server">DeleteEvent</asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </fieldset>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="lnkGenCreateTable" />
            <asp:PostBackTrigger ControlID="lnkGenInsertStatement" />
            <asp:PostBackTrigger ControlID="lnkGenUpdateStatement" />
            <asp:PostBackTrigger ControlID="lnkGenDeleteStatement" />
        </Triggers>
    </asp:UpdatePanel>
</div>
<div id="dynamicformsquestioneventsdiv" align="left">
    <asp:UpdatePanel ID="UpdatePanelQuestionEvents" runat="server">
        <ContentTemplate>
            <div class="dnnForm" id="PanelsQuestionsEvents">
                <h2 id="dshQuestionEvents" class="dnnFormSectionHead">
                    <a href="#">
                        <%=LocalizeString("QuestionEvents")%></a>
                </h2>
                <fieldset class="dnnClear">
                    <div class="dnnForm" id="tblQuestionEvents" runat="server">
                        <fieldset>
                            <div class="dnnFormItem">
                                <span class='dnnFormMessage dnnFormInfo dynreginfo'>
                                    <asp:Literal ID="litQuestionEvents" runat="server"></asp:Literal>
                                </span>
                            </div>
                                <div class="dnnClear dnnRight">
                                    <asp:ImageButton ID="imgQuestionEvents" runat="server" ImageUrl="~/desktopmodules/dynamic forms/DS_Icon1l.gif">
                                    </asp:ImageButton>
                                </div>
                            <div class="dnnFormItem">
                                <div class="dnnForm" id="tblQuestionEvents1" runat="server">
                                    <fieldset>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblQuestionEvent" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboDynamicQuestionEvents" runat="server" CssClass="NormalTextbox"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblQuestionEventName" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtQuestionEvent" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblIsDisabled" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkQuestionEventDisabled" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblQuestionEventType" runat="server" Suffix=":"></dnn:Label>
                                            <asp:RadioButtonList ID="optQuestionEventType" runat="server" AutoPostBack="True"
                                                RepeatColumns="1" CssClass="dnnFormRadioButtons">
                                                <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                <asp:ListItem Value="4">4</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblCausesQuestion" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboQuestionEventQuestionOne" runat="server" CssClass="NormalTextbox"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblFireForAny" runat="server" Suffix=":"></dnn:Label>
                                            <asp:CheckBox ID="chkFireForAny" runat="server"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblCausesQuestionResponse" runat="server" Suffix=":"></dnn:Label>
                                            <asp:TextBox ID="txtQuestionEventQuestionResponse" runat="server" Visible="False"
                                                CssClass="NormalTextbox"></asp:TextBox>
                                            <asp:DropDownList ID="cboQuestionEventQuestionResponse" runat="server" CssClass="NormalTextBox"
                                                Visible="False">
                                            </asp:DropDownList>
                                            <asp:RadioButtonList ID="optQuestionEventQuestionResponse" CssClass="dnnFormRadioButtons"
                                                runat="server" Visible="False">
                                            </asp:RadioButtonList>
                                            <asp:CheckBox ID="chkQuestionEventQuestionResponse" runat="server" CssClass="dnnFormRadioButtons"
                                                Visible="False"></asp:CheckBox>
                                        </div>
                                        <div class="dnnFormItem">
                                            <dnn:Label ID="lblAffectedQuestion" runat="server" Suffix=":"></dnn:Label>
                                            <asp:DropDownList ID="cboQuestionEventQuestionTwo" runat="server" CssClass="NormalTextbox"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="dnnFormItem" style="padding-left:350px;">
                                            <asp:CheckBoxList ID="chkQuestionEventAffectedFields" runat="server" CssClass="dnnFormRadioButtons"
                                                Visible="True" RepeatColumns="3" ReapeatLayout="Flow">
                                            </asp:CheckBoxList>
                                        </div>
                                        <div class="dnnFormItem" id="rowDefaultValue" runat="server" visible="false">
                                            <dnn:Label ID="lblAffectedDefaultValue" runat="server" Suffix=":"></dnn:Label>
                                            <asp:RadioButtonList ID="optTextboxDefaultQuestionEvent" runat="server" Enabled="False"
                                                AutoPostBack="True" CssClass="dnnFormRadioButtons" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="Enter Options" Selected="True"></asp:ListItem>
                                                <asp:ListItem Value="SQL Driven"></asp:ListItem>
                                            </asp:RadioButtonList>
                                            <asp:TextBox ID="txtDefaultSQLQuestionEvent" Visible="False" runat="server" CssClass="NormalTextbox"
                                                Width="300" Height="200" TextMode="MultiLine"></asp:TextBox>
                                            <asp:Literal ID="litSQLDefaultValueQuestionEvent" Visible="False" runat="server"></asp:Literal>
                                            <asp:TextBox ID="txtQuestionEventAffectedDefaultValue" runat="server" CssClass="NormalTextbox"></asp:TextBox>
                                            <asp:DropDownList ID="cboQuestionEventAffectedResponse" runat="server" CssClass="NormalTextBox"
                                                Visible="False">
                                            </asp:DropDownList>
                                            <asp:RadioButtonList ID="optQuestionEventAffectedResponse" CssClass="dnnFormRadioButtons"
                                                runat="server" Visible="False">
                                            </asp:RadioButtonList>
                                            <asp:CheckBox ID="chkQuestionEventAffectedResponse" runat="server" Visible="False">
                                            </asp:CheckBox>
                                        </div>
                                    </fieldset>
                                    <ul class="dnnActions dnnClear">
                                        <li>
                                            <asp:LinkButton ID="lnkUpdateQuestionEvent" CssClass="dnnPrimaryAction" runat="server"></asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="lnkDeleteQuestionEvent" CssClass="dnnSecondaryAction" runat="server"></asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </fieldset>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div class="dnnForm">
    <input id="CurrentDiv" type="hidden" runat="server" value="dynamicquestionsdiv" />
    <asp:UpdatePanel ID="UpdatePanelUpdateSettings" runat="server">
        <ContentTemplate>
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkUpdateSettings" CssClass="dnnPrimaryAction" runat="server">Update Settings</asp:LinkButton>
                </li>
                <li>
                    <asp:LinkButton ID="Linkbutton2" CssClass="dnnSecondaryAction" runat="server">Exit</asp:LinkButton>
                </li>
            </ul>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
</div>
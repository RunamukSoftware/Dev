<%@ Control Language="vb" Inherits="DataSprings.Modules.DynamicForms.DynamicForms"
    AutoEventWireup="false" Explicit="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke.WebControls" %>
<div class="dnnForm dnnDynForms dnnClear" id="EntryForm">
    <a name="dftoppage"></a>
    <dnn:DNNMenu ID="myDNNMenu" runat="Server" Orientation="Horizontal">
    </dnn:DNNMenu>
    
    <script language="javascript">
  // Get a reference to the PageRequestManager.
  var prm = Sys.WebForms.PageRequestManager.getInstance();
 
  // Using that prm reference, hook _initializeRequest
  // and _endRequest, to run our code at the begin and end

 // of any async postbacks that occur.
if (null != prm)
{
  prm.add_initializeRequest(InitializeRequest);
  prm.add_endRequest(EndRequest);
}
 
  // Executed anytime an async postback occurs.
  function InitializeRequest(sender, args) 
  {
    // Change the Container div's CSS class to .Progress.
   // $get('dnn_ctr455_DynamicForms_tblQuestions').className = 'Progress';
   // $get('Body').className = 'Progress';
 
     jQuery('input[type=radio].star').rating();

     <% if CStr(Settings("HideModal")) <> "True" then %>

    try
     {

     jQuery.blockUI({ message: '<div class="DynamicForms_AJAXModalMessage"><% =GetProgressURL()%><% =GetProgressText()%></div><BR>' });
    

      }
    catch(err)
    {
    //Handle errors here
     }

    <%
      end if
     %>




  }
 
  // Executed when the async postback completes.
  function EndRequest(sender, args) 
  {
    // Change the Container div's class back to .Normal.
   //$get('dnn_ctr455_DynamicForms_tblQuestions').className = 'DynamicForms_MainTable';

    //jQuery('#dynamicforms_ajaxbackground').remove();
 
    // Get a reference to the element that raised the postback
    //   which is completing, and enable it.
    // $get(sender._postBackSettings.sourceElement.id).disabled = false;
    //$get('dnn_ctr455_DynamicForms_lnkSave').disabled = false;

     
<% if CStr(Settings("HideModal")) <> "True" then %>
     
    try
     {

    jQuery.unblockUI();
    }
    catch(err)
    {
    //Handle errors here
     }

    <%
      end if
     %>

   try
     {
    
    //call initial JavaScript
   <% =GetInitialJavaScript()%>

    }
    
     catch(err)
    {
    //Handle er
 
      }


    try
     {

     loadMask();	
    }
    catch(err)
    {
    //Handle errors here
     }


    try
     {

     loadCombo();	
    }
    catch(err)
    {
    //Handle errors here
     }

    try
     {

   jQuery('input[type=radio].star').rating();

      }
    catch(err)
    {
    //Handle errors here
     }



   try
     {

   dynamicforms_watermark();
       }
    catch(err)
    {
    //Handle errors here
     }



   }
    </script>
    <script language="javascript" type="text/javascript">
        jQuery(document).ready(function () {

            dynamicforms_watermark();

        }
);

        function dynamicforms_watermark() {
            swapValues = [];
            jQuery(".dynamicforms_watermark").each(
            function (i) {
                swapValues[i] = jQuery(this).val();
                jQuery(this).focus(function () {
                    if (jQuery(this).val() == swapValues[i]) {
                        jQuery(this).val("")
                        jQuery(this).removeClass("dynamicforms_watermark");
                        jQuery(this).addClass("dynamicforms_textbox")
                    }
                }
                ).blur(function () {
                    if (jQuery.trim(jQuery(this).val()) == "") {
                        jQuery(this).val(swapValues[i])
                        jQuery(this).addClass("dynamicforms_watermark")
                    }
                }
                 )
            }
      )

        }



        function dynamicforms_checkall(id, pID) {
            jQuery("#" + pID + " :checkbox").attr('checked', jQuery('#' + id).is(':checked'));
        }
    </script>
    <script type="text/javascript">



        function showWait(myfile) {
            if ($get(myFile).value.length > 0) {
                $get('UpdateProgress1').style.display = 'block';
            }
        }
    </script>
    <script language="javascript" type="text/javascript">

        jQuery.fn.highlight = function (selector, className, eventStart, eventEnd) {

            // variables
            var className = className || 'highlight';
            if (eventStart == undefined && eventEnd == undefined) {
                var eventStart = 'mouseover';
                var eventEnd = 'mouseout';
            }
            else if (eventStart == eventEnd || eventStart != undefined && eventEnd == undefined) {
                var toggle = true;
            }

            // code
            this.each
				(
				function () {

				    var tagName = this.tagName.toLowerCase();

				    if (tagName == 'form') {

				        selector = selector || 'li';
				        var elements = jQuery("textarea, select, multi-select, :text, :image, :password, :radio, :checkbox, :file", this);

				        elements.bind
							(
							'focus',
							function () {
							    var parents = jQuery(this).parents(selector)
							    var parent = jQuery(parents.get(0))
							    parent.addClass(className);
							}
							);

				        elements.bind
							(
							'blur',
							function () {
							    var parents = jQuery(this).parents(selector)
							    var parent = jQuery(parents.get(0))
							    parent.removeClass(className);
							}
							);

				    }

				    else {


				        if (tagName.match(/^(table|tbody)$/) != null) {
				            selector = selector || 'tr';
				        }
				        else if (tagName.match(/^(ul|ol)$/) != null) {
				            selector = selector || 'li';
				        }
				        else {
				            selector = '*';
				        }

				        var elements = jQuery(selector, this);

				        if (toggle) {
				            elements.bind
								(
								eventStart,
								function () {
								    if (jQuery(this).hasClass(className)) {
								        jQuery(this).removeClass(className);
								    }
								    else {
								        jQuery(this).addClass(className);
								    }
								}
								);

				        }

				        else {
				            elements.bind
								(
								eventStart,
								function () {
								    jQuery(this).addClass(className);
								}
								);

				            elements.bind
								(
								eventEnd,
								function () {
								    jQuery(this).removeClass(className);
								}
								);
				        }

				    }
				}
				);

        }


        function save_rate(myratingid, myhiddenratingid) {
            var state = $find(myratingid).get_Rating();
            document.getElementById(myhiddenratingid).value = state;

        }


        function checkEnter(event, buttonId) {

            NS4 = (document.layers) ? true : false;

            var code = 0;

            if (NS4)

                code = event.which;

            else

                code = event.keyCode;

            if (code == 13) {

                ForceClick(buttonId);

                return (false);

            }

        }



        function ForceClick(buttonId) {

            button = document.getElementById(buttonId);

            if (button)

                button.click();

        }



        function clearfields(stralert) {

            var answer = confirm(stralert)
            if (answer)

                document.forms[0].reset();
            else
                stralert == '';
        }



        function hidehtml(pass) {

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


        function showhtml(pass) {

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
   
    <asp:Literal ID="litStyle" runat="server"></asp:Literal>
    <asp:Literal ID="litDragDrop" runat="server"></asp:Literal>
    <asp:Panel ID="pnlRegistration" runat="server" Visible="true" CssClass="DynamicForms_MainPanel">
        <table id="tblHeader" cellspacing="0" cellpadding="0" width="100%" align="left" border="0"
            runat="server" class="DynamicForms_HeaderTable">
            <tr>
                <td>
                    <asp:Literal ID="litAdmin" runat="server"></asp:Literal>
                    <dnn:DNNToolBar ID="tbDynamicH" runat="server" CssClass="eipbackimg" DefaultButtonHoverCssClass="eipborderhover"
                        DefaultButtonCssClass="eipbuttonbackimg" ReuseToolBar="true" Visible="True">
                        <dnn:DNNToolBarButton ID="tbEdit" runat="server" CssClass="eipbutton_edit" ToolTip="Edit"
                            ControlAction="edit">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbSave" runat="server" CssClass="eipbutton_save" ToolTip="Update"
                            ControlAction="save">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbCancel" runat="server" ToolTip="Cancel" ControlAction="cancel">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbBold" runat="server" ToolTip="Bold" ControlAction="bold">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbItalic" runat="server" ToolTip="Italic" ControlAction="italic">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbUnderline" runat="server" ToolTip="Underline" ControlAction="underline">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbJustifyLeft" runat="server" ToolTip="Justify Left" ControlAction="justifyleft">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbJustifyCenter" runat="server" ToolTip="Justify Center"
                            ControlAction="justifycenter">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbJustifyRight" runat="server" ToolTip="Justify Right"
                            ControlAction="justifyright">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbOrderedList" runat="server" ToolTip="Ordered List" ControlAction="insertorderedlist">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbUnorderedList" runat="server" ToolTip="Unordered List"
                            ControlAction="insertunorderedlist">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbOutdent" runat="server" ToolTip="Outdent" ControlAction="outdent">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbIndent" runat="server" ToolTip="Indent" ControlAction="indent">
                        </dnn:DNNToolBarButton>
                        <dnn:DNNToolBarButton ID="tbCreateLink" runat="server" ToolTip="Create Link" ControlAction="createlink">
                        </dnn:DNNToolBarButton>
                    </dnn:DNNToolBar>
                    <asp:Literal ID="litHeader" runat="server"></asp:Literal>
                </td>
            </tr>
        </table>
        <asp:Panel ID="pnlAJAXFields" runat="server" Visible="True">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="DynamicForms_Summary">
            </asp:ValidationSummary>
            <dnn:DNNLabelEdit ID="lblHeader" runat="server" WorkCssClass="" LabelEditScriptPath=""
                ClientAPIScriptPath="" CallBackType="Simple" LostFocusSave="False" EventName="none"
                RenderAsDiv="True" ToolBarId="tbDynamicH" RichTextEnabled="True" MultiLine="True"
                EditEnabled="False" LabelEditCssClass="LabelEditTextClass" MouseOverCssClass="LabelEditOverClassML"
                EnableViewState="False" CssClass="Normal">
            </dnn:DNNLabelEdit>
            <div class="dnnFormItem">
                <asp:Label ID="lblAlreadyExists" runat="server" CssClass="NormalRed"></asp:Label>
            </div>
            <table class="DynamicForms_Maintable" id="tblQuestions" border="0" runat="server" visible="false">
            </table>
            <asp:Panel ID="pnlQuestions" CssClass="DynamicForms_MainPanel" runat="server"
                Visible="True">
            </asp:Panel>
            <div id='SaveForm_<% =ModuleID.TosTring %>' class="DynamicForms_SaveFormDiv">
                <p align="<%=ButtonAlign()%>">
                    <asp:Literal ID="litValBottom" runat="server"></asp:Literal>
                    <asp:Label ID="lblValBottom" runat="server" ForeColor="Red"></asp:Label>
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server"></asp:ValidationSummary>
                    <asp:LinkButton ID="lnkSave" CausesValidation="True" runat="server">Save</asp:LinkButton>&nbsp;&nbsp;
                    <asp:ImageButton ID="imgSave" CausesValidation="True" runat="server" Visible="False">
                    </asp:ImageButton>&nbsp;
                    <input id="btnSave" causesvalidation="True" type="button" runat="server" value="Submit for Later" />
                    <asp:LinkButton ID="lnkSaveForLater" CausesValidation="False" runat="server" Visible="False">Save for Later</asp:LinkButton>&nbsp;&nbsp;
                    <asp:ImageButton ID="imgSaveForLater" CausesValidation="false" runat="server" Visible="False">
                    </asp:ImageButton>&nbsp;
                    <input id="btnSaveForLater" causesvalidation="False" type="button" runat="server"
                        visible="False" value="Submit for Later" />
                    <asp:HyperLink ID="lnkClear" runat="server"></asp:HyperLink>&nbsp;
                </p>
            </div>
        </asp:Panel>
        <asp:Literal ID="litFooter" runat="server"></asp:Literal>
        <asp:Panel ID="pnlHidden" runat="server" Visible="true">
        </asp:Panel>
        <dnn:DNNLabelEdit ID="lblFooter" runat="server" WorkCssClass="" LabelEditScriptPath=""
            ClientAPIScriptPath="" CallBackType="Simple" LostFocusSave="False" EventName="none"
            RenderAsDiv="True" ToolBarId="tbDynamicH" RichTextEnabled="True" MultiLine="True"
            EditEnabled="False" LabelEditCssClass="LabelEditTextClass" MouseOverCssClass="LabelEditOverClassML"
            EnableViewState="False" CssClass="Normal">
        </dnn:DNNLabelEdit>
        <asp:Literal ID="litHiddenFieldMenu" runat="server"></asp:Literal>
    </asp:Panel>
    <asp:Panel ID="pnlAfterMessage" runat="server" Visible="false">
        <asp:Literal ID="litAfterMessage" runat="server"></asp:Literal>
        <asp:HyperLink ID="lnkContinue" runat="server">Continue</asp:HyperLink>&nbsp;&nbsp;&nbsp;
        <asp:HyperLink ID="hypBack" runat="server" NavigateUrl="Javascript:history.go(-1)">Back</asp:HyperLink>
        <asp:TextBox ID="txtForgottenUsername" runat="server" Visible="False"></asp:TextBox></asp:Panel>
    <asp:Panel ID="pnlHiddenAJAX" runat="server" Visible="true">
    </asp:Panel>
    <table id="tblTest" cellspacing="1" cellpadding="1" border="0" runat="server">
        <tr>
            <td>
                <asp:Literal ID="litTest" runat="server"></asp:Literal>
            </td>
        </tr>
    </table>
    <a name="dfbottompage"></a>
    <style type="text/css">
        #dhtmltooltip
        {
            position: absolute;
            left: -500px;
            width: 450px;
            border: 1px solid black;
            padding: 2px;
            background-color: lightblue;
            visibility: hidden;
            z-index: 300; /*Remove below line to remove shadow. Below line should always appear last within this CSS*/
            filter: progid:DXImageTransform.Microsoft.Shadow(color=black,direction=135);
        }
        
        #dhtmlpointer
        {
            position: absolute;
            left: -300px;
            z-index: 201;
            visibility: hidden;
        }
        
        .highlight
        {
            background-color: #e2e2e2;
            background-image: url(../images/delete.gif);
        }

      .df_newfield
        {
          
	   padding: 4pt;
	   

        }

    </style>
</div>
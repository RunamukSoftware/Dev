<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ToPazSignature.ascx.vb" Inherits="DataSprings.Modules.DynamicForms.TopazSignature" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>





		<SCRIPT language="Javascript">
function OnClear() {

document.getElementById('<% =GetID()%>').ClearTablet(); //Clears the signature, in case of error or mistake
document.getElementById('<% =GetID()%>').TabletState = 1;
}


function OnSign() {
document.getElementById('<% =GetID()%>').TabletState = 1; //Turns tablet on
}




function OnSave() {


if(document.getElementById('<% =GetID()%>').NumberOfTabletPoints > 0)
{
   document.getElementById('<% =GetID()%>').TabletState = 0; //Turns tablet off
   document.getElementById('<% =GetID()%>').AutoKeyStart();
   
   document.getElementById('<% =GetID()%>').AutoKeyData = 'Dynamic Forms';
   //pass here the data you want to use to encrypt the signature
   //this demo simply encrypts to the name typed in by the user
   //you'll probably want to make sure your encryption data you use is
   //more useful...that you encrypt the signature to the data important
   //to your app, and what the client has agreed to
   
    document.getElementById('<% =GetID()%>').AutoKeyFinish();
    document.getElementById('<% =GetID()%>').EncryptionMode = 2;
    document.getElementById('<% =GetID()%>').SigCompressionMode = 1; 
   
  
   document.getElementById('<% =GetHiddenID()%>').value = document.getElementById('<% =GetID()%>').SigString;

     //pass the signature ASCII hex string to the hidden field,
   //so it will be automatically passed when the page is submitted
   
   //document.FORM1.submit();
}
}

</script>


<asp:panel id="pnlSignature" runat="server">
	<OBJECT id=<% =GetID()%> style="LEFT: 0px; WIDTH: 350px; TOP: 0px; HEIGHT: 130px" height="75"
							classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" name="SigPlus1">
							<PARAM NAME="_Version" VALUE="131095">
							<PARAM NAME="_ExtentX" VALUE="8467">
							<PARAM NAME="_ExtentY" VALUE="4763">
						    <PARAM NAME="_StockProps" VALUE="9">
	</OBJECT>
	<BR>
    <INPUT id="btnClear" onclick="OnClear()" type="button" value="Clear" name="ClearBtn">&nbsp;&nbsp;&nbsp;
  
</asp:panel>

<asp:HiddenField ID="SigValue" Runat="Server" />



<%@ Control Language="VB" AutoEventWireup="false" CodeFile="checkout_ALS.ascx.vb" Inherits="checkout_ALS" %>
<%@ Register Assembly="PSWebEnrolmentKit" Namespace="CompassCC.ProSolution.PSWebEnrolmentKit"
    TagPrefix="cc1" %>

<%--<ol class="breadcrumb" runat="server">
<li class="active">Results Day</li>
</ol>--%>


					<div class="intro-block">
							
								<h1>Addititonal Learning Supprt <span class="last-word"> Form</span></h1>
					
						</div>

<br />
<br />

 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="courselistgrid table table-striped table-bordered text-center" Visible="false"
    DataKeyNames="OfferingID" CellSpacing="-1" BorderStyle="None" GridLines="none" Caption='<h4>Your Course</h4>'
CaptionAlign="Top">

        
    <Columns>
        <asp:BoundField DataField="Code" HeaderText="Course Code">
            <ControlStyle CssClass="searchgridfield" />
        </asp:BoundField>
        <asp:BoundField DataField="Name" HeaderText="Course Name">
            <ControlStyle CssClass="searchgridfield" />
        </asp:BoundField>
        <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Start Date"
            HtmlEncode="False">
            <ControlStyle CssClass="searchgridfield" />
        </asp:BoundField>
        <asp:BoundField DataField="DayOfWeek" HeaderText="Day" />
        <asp:BoundField DataField="StartTime" DataFormatString="{0:HH:mm}" HeaderText="Time"
            HtmlEncode="False">
            <ControlStyle CssClass="searchgridfield" />
        </asp:BoundField>
        <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="End Date"
            HtmlEncode="False">
            <ControlStyle CssClass="searchgridfield" />
        </asp:BoundField>
        <asp:BoundField DataField="SiteDescription" HeaderText="Venue"
            HtmlEncode="false" > 
            <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
      <%--  <asp:TemplateField HeaderText="Full Fee">
            <ItemTemplate>
                <asp:Label ID="lblStandardFee" runat="server" Visible="false" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Concession Fee">
            <ItemTemplate>
                <asp:Label ID="lblConcessionFee" runat="server" Visible="false" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Remission Fee">
            <ItemTemplate>
                <asp:Label ID="lblBenefitsFee" runat="server" Visible="false" />
            </ItemTemplate>
        </asp:TemplateField>--%>
    </Columns>
    <RowStyle CssClass="searchgridcell" />
    <HeaderStyle CssClass="searchgridheader" />
    <EmptyDataTemplate>
                <p>No Actual Courses Found for you to Enrol on / Apply for, please try searching for 
                    another course.</p>
            </EmptyDataTemplate>
        </asp:GridView>

  





<div class="form-field-section grey" id="divmain" runat="server">


    <br />
    <h2 class="app-title">Details</h2>
    <p>Please enter your details - this is needed to match to your record</p>

     <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="RefNo" ID="RefNoField" runat="server" IsRequired="True" LabelWidth="300" CustomCaption="Student Reference Number (Found in your Email)" />
    </div>
    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="FirstForename" ID="StudentEnrolmentField1" runat="server" IsRequired="true" LabelWidth="300" CustomCaption="First Name" />
    </div>
    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Surname" ID="fldSurname" runat="server" IsRequired="true" LabelWidth="300" CustomCaption="Surname" />
    </div>  
     <div class="form-input">
        <cc1:StudentEnrolmentField id="datepicker" runat="server" IsRequired="true" StudentEnrolmentFieldType="DateOfBirth"  LabelWidth="300" ClientIDMode="Static"/>
    </div>    


    
    <div class=" form-group">
        <span class="textfieldlabelrequired">Do you have an Education HealthCare Plan (EHCP)? <i>If you are unsure, please select 'No'</i></span>
        <asp:RadioButtonList runat="server" ID="HasEHCP">
            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            <asp:ListItem Text="No" Value="0"></asp:ListItem>

        </asp:RadioButtonList>

    </div>

    
        <div class="displaynone">
            <cc1:StudentEnrolmentField StudentEnrolmentFieldType="HasEducationHealthCarePlan" ID="fldEHCP" runat="server" IsRequired="false" LabelWidth="300" CustomCaption="EHCP" Enabled="True" CustomFieldType="TickBox" />
        </div>


       
    <script>


        $(document).ready(function () {




            var rdo = document.getElementsByName("<%= HasEHCP.UniqueID%>")
            if (rdo[0].checked) {
                $('#ctl00_MainContentPlaceholder_ctl00_fldEHCP_chkHasEducationHealthCarePlan').prop('checked', true);
            }
            else {
                $('#ctl00_MainContentPlaceholder_ctl00_fldEHCP_chkHasEducationHealthCarePlan').prop('checked', false);
            }

            // Set EU Fields visibility when 'Yes' radio button is clicked
            var RadioButtonListEU = document.getElementById("<%= HasEHCP.ClientID%>")
            RadioButtonListEU.onchange = function () {
                var rdo = document.getElementsByName("<%= HasEHCP.UniqueID%>")
                if (rdo[0].checked) {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldEHCP_chkHasEducationHealthCarePlan').prop('checked', true);
                }
                else {
                    $('#ctl00_MainContentPlaceholder_ctl00_fldEHCP_chkHasEducationHealthCarePlan').prop('checked', false);
                }



            };
        });

    </script>

</div>




 <div class="form-field-section grey" id="panel1" runat="server">

         <h2 class="app-title">Learning support</h2>
    
     <p>Because you have selected <b>yes</b> to whether you had any support needs whilst at college, we ask that you could complete the few questions below so we can ensure we support your needs as best as possible and give you the greatest chance of success at Plumpton College</p>


     <h4 class="app-title">Disabilties / difficulties</h4>

     

    <div class="form-input">
        <span class="textfieldlabelrequired">Do you have any disabilities or learning difficulties?</span>
        <asp:RadioButtonList runat="server" ID="rdoLearnDiff" CssClass="form-input">
            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            <asp:ListItem Text="No" Value="2"></asp:ListItem>
       
        </asp:RadioButtonList>
     
    </div>


    

    <div class="disFields">
        <div class="form-input">
            <p class="textfieldlabelrequired">Primary Disability/Learning Difficulty</p>
            <cc1:StudentEnrolmentField runat="server" ID="fldDisabilityCategory1ID" CustomCaption="Primary Disability/Learning Difficulty" StudentEnrolmentFieldType="DisabilityCategory1ID" LabelWidth="0" />
        </div>
        <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="fldDisabilityCategory2ID" CustomCaption="Secondary Disability/Learning Difficulty" StudentEnrolmentFieldType="DisabilityCategory2ID" LabelWidth="300" />
        </div>
          <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField19" CustomCaption="Notes" StudentEnrolmentFieldType="DisabilityNotes" LabelWidth="300" />
        </div>
     </div>


 <br />
     <hr />
     <br />
     



     <h2 class="app-title">Medical conditions</h2>


       <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField3" CustomCaption="Medical condition 1" StudentEnrolmentFieldType="StudentDetailUserDefined37" LabelWidth="300" CustomFieldType="Lookup" />
        </div>
     
       <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmedntField3" CustomCaption="Medical condition 2" StudentEnrolmentFieldType="StudentDetailUserDefined38" LabelWidth="300" CustomFieldType="Lookup" />
        </div>
     
       <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmaentField3" CustomCaption="Medical condition 3" StudentEnrolmentFieldType="StudentDetailUserDefined39" LabelWidth="300" CustomFieldType="Lookup"/>
        </div>


 <br />
     <hr />
     <br />
    


     <h2 class="app-title">Support needs</h2>

     
       <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField4" CustomCaption="Support need 1" StudentEnrolmentFieldType="StudentDetailUserDefined28" LabelWidth="300" />
        </div>
     
       <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField5" CustomCaption="Support need 2" StudentEnrolmentFieldType="StudentDetailUserDefined29" LabelWidth="300" />
        </div>
     
       <div class="form-input">
            <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField6" CustomCaption="Support need 3" StudentEnrolmentFieldType="StudentDetailUserDefined30" LabelWidth="300" />
        </div>



 <br />

          <h2 class="app-title">Uploads (Formal diagnosis / EHCP letter) </h2>


     <b> If you would also like to upload your character reference, you can do so below</b>

     
    <div class="row">
<div class="col-md-3">
Type of Evidence
                            <asp:DropDownList ID="ddlTypeOfEvidence" runat="server">
                                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                <asp:ListItem Text="EHCP letter" Value="EHCP letter"></asp:ListItem>
                                <asp:ListItem Text="Formal Diagnosis" Value="Formal Diagnosis"></asp:ListItem>
                                <asp:ListItem Text="Other…" Value="Other…"></asp:ListItem>
                            </asp:DropDownList>
</div>
<div class="col-md-3">
Notes
<asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="8" Width="100%"></asp:TextBox>
</div>
<div class="col-md-3">
Upload File
                            <%--
                                Following properties are there to use in the File Upload control
                                - IsRequired (To set control mandatory)
                                - RequiredErrorMessage (A message to display when user is not uploading file)
                                - MaxAllowedFileSize (Maximum size allowed for a file upload in KB). Use this to override value set in System Setting of same name.
                                - MaxAllowedFileSizeErrorMessage  (A message to display when user has uploaded larger file than allowed)
                                - SupportedFileTypes (File Types supported by the control (.jpg, .png, .xlsx)). Use this to override value set in System Setting of same name.
                                - SupportedFileTypesErrorMessage (A message to display when user has uploaded file of type which is not valid)
                                - HideUserInfoOnTooltip (To prevent showing of information related to file upload requirements)
                                - UserInfo (User Information related to file upload requirements - if need to display at any specific location manually)
                                --%>
                            <cc1:CCCFileUpload ID="fuAttachment" SupportedFileTypes=".jpg,.png,.xlsx" runat="server" data-html="true"  ClientIDMode="static"  IsRequired="true" />
</div>
<div class="col-md-3">
<asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-success" CausesValidation="true" />
</div>
</div>    
  

    <br />
    <asp:ValidationSummary ID="vsAttachments" runat="server" CssClass="alert alert-danger" />
    <hr />
    <div>
        <table id="tblUploadedInfo" class="table table-striped table-bordered text-center" style="border-style: None;">
            <tbody>
                <asp:Repeater ID="rptAttachments" runat="server" OnItemCommand="rptAttachments_ItemCommand">
                    <HeaderTemplate>
                        <tr class="searchgridheader">
                            <th scope="col" style="width: 20%">Type of Evidence</th>
                            <th scope="col">Notes</th>
                            <th scope="col" style="width: 15%">Attachment</th>
                            <th scope="col" style="width: 10%">Remove</th>
                        </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr class="searchgridcell text-left">
                            <td><%#: Eval("TypeOfEvidence") %></td>
                            <td><%#: Eval("Notes") %></td>
                            <td><%#: Eval("FileName") %></td>
                            <td class="text-center">
                                <asp:Button ID="btnRemove" runat="server" Text="X" CssClass="btn btn-danger" CommandName="RemoveAttachment" CommandArgument='<%#: Eval("AttachmentID") %>' OnClientClick="return confirmDeletion()" /></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr id="trNoItems" runat="server" class="searchgridcell" visible="false">
                    <td colspan="4">No attachments uploaded yet
                    </td>
                </tr>
            </tbody>
        </table>
    </div>






     <hr />
     <br />

  
   <cc1:CCCButton ID="btnContinue" runat="server" Text="Continue" CausesValidation="true" />
</div>
<script>

    $(document).ready(function () {
        //disability stuff
        $('.disFields').hide();

        // Hide or Show Learning Difficulty 
        var rdo = document.getElementsByName("<%= rdoLearnDiff.UniqueID%>")
        if (rdo[0].checked) {
            $(".disFields").show();
        }
        else {
            $(".disFields").hide();
        }

        // Set Learning Difficulty Fields visibility when Learning Difficulty 'Yes' radio button is clicked
        var rdoLearnDiff = document.getElementById("<%= rdoLearnDiff.ClientID%>")
        rdoLearnDiff.onchange = function () {
            var rdo = document.getElementsByName("<%= rdoLearnDiff.UniqueID%>")
            if (rdo[0].checked) {
                $(".disFields").slideDown();
            }
            else {
                $(".disFields").slideUp();
            }


            $("#txtDisabilityNotes").keyup(function () {
                var charsLeft = (8000 - $(this).val().length);
                $('#charsLeft2').text(charsLeft + ' characters left');

            });
        };
    });

</script>
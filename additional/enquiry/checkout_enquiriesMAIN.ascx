<%@ Control Language="VB" AutoEventWireup="false" CodeFile="checkout_enquiriesMAIN.ascx.vb" Inherits="webcontrols_checkout_enquiriesMAIN" %>
<%@ Register Assembly="PSWebEnrolmentKit" Namespace="CompassCC.ProSolution.PSWebEnrolmentKit"
    TagPrefix="cc1" %>


<div class="form-field-section grey">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="courselistgrid table table-striped table-bordered text-center"
        DataKeyNames="OfferingID" CellSpacing="-1" BorderStyle="None" GridLines="none" Visible="true">


        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Course Name">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
            <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Start Date"
                HtmlEncode="False">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
            <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="End Date"
                HtmlEncode="False">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
            <asp:BoundField DataField="SiteDescription" HeaderText="Site" />
            <asp:BoundField DataField="TotalFeeAmount" HeaderText="Total Fees" DataFormatString="{0:c}" Visible="false">
                <ControlStyle CssClass="searchgridfield" />
            </asp:BoundField>
        </Columns>
        <RowStyle CssClass="searchgridcell" />
        <HeaderStyle CssClass="searchgridheader" />
        <EmptyDataTemplate>
            <p>
                No Actual Courses Found for you to Enrol on / Apply for, please try searching for 
                    another course.
            </p>
        </EmptyDataTemplate>
    </asp:GridView>
</div>


<div class="form-field-section grey">
    <h2 class="app-title">Course Enquiries </h2>
    
 
<br />
    <br />

 
  
    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="FirstForename" ID="StudentEnrolmentField1" runat="server" IsRequired="true" LabelWidth="200" CustomCaption="First Name" />
    </div>

      <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Surname" ID="fldSurname" runat="server" IsRequired="true" LabelWidth="200"  AutoFocus="true"/>
    </div>


      <div class=" form-group">
        <cc1:StudentEnrolmentField ID="datepicker" runat="server" IsRequired="true" StudentEnrolmentFieldType="DateOfBirth" LabelWidth="200" ClientIDMode="Static" />
    </div>

    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Enquiry" ID="StudentEnrolmentFieldEnquiry" runat="server" IsRequired="true" 
            LabelWidth="200" CustomFieldType="Other" HTML5InputType="text" Placeholder="If there are any other courses you are interested in, or have any questions for us, please let us know here" />
    </div>


    

     <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Email" ID="StudentEnrolmentField3" runat="server" IsRequired="true" LabelWidth="200" HTML5InputType="email" Placeholder="e.g. name@domain.com" Pattern="^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" />
    </div>
   
    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Tel" ID="StudentEnrolmentField4" runat="server" CustomCaption="Contact Number (Main Number)" IsRequired="true" LabelWidth="300" Pattern="^(0[\d]{8,12}|447[\d]{7,11})$" Title="Please enter a valid Telephone Number No spaces" />
    </div>

    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="MobileTel" ID="StudentEnrolmentField2" runat="server" CustomCaption="Mobile" IsRequired="false" LabelWidth="500" Pattern="(07\d{9}|447\d{9})$" Title="Please enter a valid Mobile Telephone Number No spaces" />
    </div>
   

    
     <br />

     <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="SubjectID" ID="fldSubjectID" runat="server" IsRequired="false" LabelWidth="400"
            CustomCaption="Which course/s are you interested in? (choose up to 5) " />
    </div>
    
     <a href="#" class="show_hide btn btn-primary">Add more</a>
    <br />
    <br />
<div class="slidingDiv">
    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Subject2ID" ID="fldSubject2ID" runat="server" IsRequired="false" LabelWidth="200"
            CustomCaption=" " />
    </div>
    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Subject3ID" ID="fldSubject3ID" runat="server" IsRequired="false" LabelWidth="200"
            CustomCaption=" " />
    </div>
    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Subject4ID" ID="fldSubject4ID" runat="server" IsRequired="false" LabelWidth="200"
            CustomCaption=" " />
    </div>
    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Subject5ID" ID="fldSubject5ID" runat="server" IsRequired="false" LabelWidth="200"
            CustomCaption=" " />
    </div>

    </div>


    
     <div class=" form-group">
      
     <p class="textfieldlabelrequired">How did you find out about college?</p>
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="HeardAboutCollegeID" ID="StudentEnrolmentField8" runat="server" IsRequired="true" LabelWidth="0"
            CustomCaption="How did you find out about college?" />
    </div>

   
        <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EnquiryUserDefined1" ID="StudentEnrolmentField5" runat="server" IsRequired="true" LabelWidth="400" CustomFieldType="Lookup"
            CustomCaption="I am currently... " />
    </div>







    
    


    <p>We would like to send you occasional relevant information about courses, forthcoming events and news from SHCG. You can join our mailing list by checking this box. You may withdraw from these communications at any time by contacting the Marketing Department via marketing@SHCG.ac.uk or by write to, South Hampshire College Group,</p>
    <asp:CheckBox ID="acceptmarketing" runat="server" Text="Marketing consent">
     
    </asp:CheckBox>

    <div class="displaynone">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="AcceptMarketingConsent" ID="AcceptMarketingTick" runat="server" LabelWidth="400" />
        </div>
    <br />
        <br />

        <br />
 
    <p>SHCG is committed to protecting the rights of individuals in line with Data Protection legislation. In checking this box, I am consenting to my data being processed in accordance with the SHCG privacy notice (https://www.SHCG.ac.uk/privacy-notice/)</p>
      
   
    <p class="textfieldlabelrequired">Data processing consent</p>
     <asp:CheckBox ID="chkData" runat="server" >
     
    </asp:CheckBox>

    <div class="displaynone">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="SentMarketingInfo" ID="fldData" runat="server" LabelWidth="400" />
        </div>
    <br />
        <br />

        <br />









        <cc1:CCCButton id="btnBack" runat="server" Text="Back" ImageResource="btnBack" LinkResource="checkout_aspx" Visible="false"/>
        <cc1:CCCButton ID="btnContinue" runat="server" Text="Submit" LinkResource="checkout_makepayment_aspx" CausesValidation="true" CssClass="button" />
    <br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" ForeColor="" />

    </div>

<script>

    $(document).ready(function () {




        var rdo = document.getElementsByName("<%= acceptmarketing.UniqueID%>")
        if (rdo[0].checked) {
            $('#ctl00_MainContentPlaceholder_ctl00_AcceptMarketingTick_chkAcceptMarketingConsent').prop('checked', true);
        }
        else {
            $('#ctl00_MainContentPlaceholder_ctl00_AcceptMarketingTick_chkAcceptMarketingConsent').prop('checked', false);
        }

        // Set EU Fields visibility when 'Yes' radio button is clicked
        var RadioButtonListEU = document.getElementById("<%= acceptmarketing.ClientID%>")
        RadioButtonListEU.onchange = function () {
            var rdo = document.getElementsByName("<%= acceptmarketing.UniqueID%>")
            if (rdo[0].checked) {
                $('#ctl00_MainContentPlaceholder_ctl00_AcceptMarketingTick_chkAcceptMarketingConsent').prop('checked', true);
            }
            else {
                $('#ctl00_MainContentPlaceholder_ctl00_AcceptMarketingTick_chkAcceptMarketingConsent').prop('checked', false);
            }



        };
    });
</script>


<script>

    $(document).ready(function () {




        var rdo = document.getElementsByName("<%= chkData.UniqueID%>")
        if (rdo[0].checked) {
            $('#ctl00_MainContentPlaceholder_ctl00_fldData_chkSentMarketingInfo').prop('checked', true);
        }
        else {
            $('#ctl00_MainContentPlaceholder_ctl00_fldData_chkSentMarketingInfo').prop('checked', false);
        }

        // Set EU Fields visibility when 'Yes' radio button is clicked
        var RadioButtonListEU = document.getElementById("<%= chkData.ClientID%>")
        RadioButtonListEU.onchange = function () {
            var rdo = document.getElementsByName("<%= chkData.UniqueID%>")
            if (rdo[0].checked) {
                $('#ctl00_MainContentPlaceholder_ctl00_fldData_chkSentMarketingInfo').prop('checked', true);
            }
            else {
                $('#ctl00_MainContentPlaceholder_ctl00_fldData_chkSentMarketingInfo').prop('checked', false);
            }



        };
    });
</script>


<script type="text/javascript">

    $(document).ready(function () {
        // Hide & show details on fees (without popping the browser window to the top on each click!)
        $(".slidingDiv").hide();
        $(".show_hide").show();

        $('.show_hide').click(function (e) {
            $(".slidingDiv").slideToggle();
            e.preventDefault();
        });
        // End hide & show


    });



</script>

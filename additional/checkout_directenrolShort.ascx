<%@ Control Language="VB" AutoEventWireup="false" CodeFile="checkout_directenrolShort.ascx.vb" Inherits="checkout_directenrolShort" %>
<%@ Register Assembly="PSWebEnrolmentKit" Namespace="CompassCC.ProSolution.PSWebEnrolmentKit"
    TagPrefix="cc1" %>
<%@ Register Src="~/webcontrols/StudentSignature.ascx" TagPrefix="uc1" TagName="StudentSignature" %>

<style>

    .app-title{

        margin-bottom:40px!important;
        margin-top:40px!important;
    }
</style>


<div class="form-field-section grey">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="courselistgrid table table-striped table-bordered text-center"
        DataKeyNames="OfferingID" CellSpacing="-1" BorderStyle="None" GridLines="none">


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
            <asp:BoundField DataField="SiteDescription" HeaderText="College" />
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
    <h2 class="app-title">Personal Details</h2>
    <hr />



    <br />
          <p class="textfieldlabelrequired"> Denotes a mandatory field : </p>

    <br />
    <br />


    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="FirstForename" Placeholder="As it appears on legal documents i.e. Birth Certificate, Passport etc" ID="StudentEnrolmentField1" runat="server" IsRequired="true" CustomCaption="First Name" />
    </div>

    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="KnownAs" Placeholder="If different to Legal First Name, otherwise leave blank" ID="StudentEnrolmentField11" runat="server" IsRequired="false" CustomCaption="Known As" />
    </div>

    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Surname" Placeholder="As it appears on legal documents i.e. Birth Certificate, Passport etc"  ID="StudentEnrolmentField10" runat="server" IsRequired="true" CustomCaption="Last Name" />
    </div>


    
    <p class="textfieldlabelrequired">Sex</p>
    <asp:DropDownList ID="Sex" runat="server" CssClass="textfield form-control">
         <asp:ListItem Value="" Text="--please select legal sex--"></asp:ListItem>
        <asp:ListItem Value="M" Text="Male"></asp:ListItem>
        <asp:ListItem Value="F" Text="Female"></asp:ListItem>
    </asp:DropDownList>

<br/>

    <div class=" form-group">
        <cc1:StudentEnrolmentField ID="datepicker" runat="server" IsRequired="true" StudentEnrolmentFieldType="DateOfBirth" LabelWidth="200" ClientIDMode="Static" />
    </div>

                     <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="NI" ID="NINum" runat="server" IsRequired="false" LabelWidth="400"
            CustomCaption="National Insurance No." Pattern="^(?!BG|GB|NK|KN|TN|NT|ZZ)[ABCEGHJ-PRSTW-Z][ABCEGHJ-NPRSTW-Z]\d{6}[A-D]$" Title="Please match requested format (AB123456C) all caps with no spaces" Placeholder="Please enter in the format AB123456C without spaces" />

    </div>

    
    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Tel" ID="StudentEnrolmentField4" runat="server" CustomCaption="Personal Contact Number (Main Number)" IsRequired="true" LabelWidth="300" Pattern="^(0[\d]{8,12}|447[\d]{7,11})$" Title="Please enter a valid Telephone Number No spaces" Placeholder="Please enter 11 digits no spaces" />
    </div>

  <div class="form-input">
     <cc1:StudentEnrolmentField StudentEnrolmentFieldType="MobileTel" ID="StudentEnrolmentField2" runat="server" CustomCaption="Mobile" IsRequired="false" LabelWidth="500" Pattern="(07\d{9}|447\d{9})$"  Placeholder="If different from main number - Please enter 11 digits no spaces"  Title="Please enter a valid Mobile Telephone Number No spaces" />
 </div>


 
    <div class="form-input">
        <cc1:StudentEmailField StudentEnrolmentFieldType="Email" ID="StudentEnrolmentField7" runat="server" IsRequired="true" LabelWidth="300" Pattern="^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" Title="Please enter a valid email address - a@b.c" CustomCaption="Personal Email Address" />
    </div>
    <p><i>A personal email address is preferred (not a school or work email address)</i></p>




    <br />
    <br />





    <%--  <p class="alert alert-info">For the questions below - if you prefer not to say, please select 'Prefer not to say'</p>
    <div class="form-input">
        <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField22" CustomCaption="Your Religion" StudentEnrolmentFieldType="StudentDetailUserDefined12" CustomFieldType="Lookup" LabelWidth="300" IsRequired="true" />
    </div>
    <div class="form-input">
        <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField23" CustomCaption="Sexual Orientation" StudentEnrolmentFieldType="StudentDetailUserDefined13" CustomFieldType="Lookup" LabelWidth="300" IsRequired="true" />
    </div>
    <div class="form-input">
        <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField24" CustomCaption="Gender Identity" StudentEnrolmentFieldType="StudentDetailUserDefined14" CustomFieldType="Lookup" LabelWidth="300" IsRequired="true" />
    </div>--%>





    <%--



    <h3>Upload Photo - A headshot photograph for your student record
    </h3>
    <p><i>We will need you to provide a photograph this is so we can ensure the safety and security of everyone at the College and we�ll keep this photo with your student record for 6 years after your course ends.</i></p>
    <hr />
    <br />

    <p>4MB Maximum file size, only jpg, png, jpeg and gif files are accepted</p>

    <div class="form-input">
        <asp:Image runat="server" CssClass="img img-responsive" />
        <asp:FileUpload ID="FileUpload1" runat="server" accept=".png,.jpg,.jpeg,.gif" Width="100%" />
        <br />

        <p><b>Click 'preview' to view a preview of your photo - if you are happy then click 'Upload' below the photo, otherwise you can cancel and upload another</b></p>
        <p><i>Please ensure your photo is oriented the correct way round</i></p>
        <asp:Button ID="Button1" runat="server" Text="Preview" OnClick="Upload" CssClass="button" CausesValidation="false" />


    </div>

    <asp:RegularExpressionValidator ID="RegExValFileUploadFileType" runat="server"
        ControlToValidate="FileUpload1"
        ErrorMessage="Only .jpg,.png,.jpeg,.gif Files are allowed" Font-Bold="True"
        Font-Size="Medium"
        ValidationExpression="(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$"></asp:RegularExpressionValidator>

    <asp:Panel ID="Panel1" runat="server" Visible="false">

        <asp:Image ID="Image1" runat="server" />
        <br />
        <asp:Button ID="btnSave" runat="server" Text="Upload" OnClick="Save" CssClass="button" CausesValidation="false" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="Cancel" CssClass="button" CausesValidation="false" />


    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" Visible="false" CssClass="alert alert-success">

        <p><i>Thank you - File Uploaded</i></p>
    </asp:Panel>


    --%>



    <h2 class="app-title">Address Details</h2>
    <hr />


    <p> Use the postcode look-up below or enter manually</p>


    <h4>Please enter your postcode or partial address below:</h4>
    <p>
        Search:
        <asp:TextBox ID="txtLookup" runat="server" CssClass="formtext"></asp:TextBox>
        <asp:Button ID="btnFind" runat="server" Text="Find" CausesValidation="False" CssClass="button" UseSubmitBehavior="false" />
		<asp:Button ID="btnCSA" runat="server" Text="" AccessKey="S" CausesValidation="False" UseSubmitBehavior="false" style="display:none;" />
    </p>

    <br>
    <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="alert-danger" />

    <div id="Div1" runat="server">
        <div class="panel-heading">Search Results - Select correct address and click on 'Fetch Selected Address'</div>
        <div class=" form-group">
            <asp:ListBox ID="lstresult" runat="server" Width="100%"></asp:ListBox>
            <br />
			<asp:Button ID="btnFetchAddress" runat="server" Text="Fetch Selected Address" CssClass="button" CausesValidation="False" UseSubmitBehavior="false" />
        </div>

        <div class=" form-group">
            <cc1:StudentEnrolmentField ID="txtAddress1" runat="server" CustomCaption="House No./Name and street (Address Line 1)"
                IsRequired="true" StudentEnrolmentFieldType="Address1" LabelWidth="400" />
        </div>

        <div class=" form-group">
            <cc1:StudentEnrolmentField ID="txtAddress2" runat="server" CustomCaption="Address Line 2"
                IsRequired="false" StudentEnrolmentFieldType="Address2" LabelWidth="300" />
        </div>
        <div class=" form-group">
            <cc1:StudentEnrolmentField ID="txtAddress3" runat="server" CustomCaption="Town / City"
                IsRequired="true" StudentEnrolmentFieldType="Address3" LabelWidth="200" />
        </div>
        <div class=" form-group">
            <cc1:StudentEnrolmentField ID="txtAddress4" runat="server" CustomCaption="County"
                IsRequired="false" StudentEnrolmentFieldType="Address4" LabelWidth="200" />
        </div>


        <div class=" form-group">

            <p class="textfieldlabelrequired">Postcode</p>
            <input type="text" runat="server" id="postcode" title="Postcode" />

        </div>
    </div>


    <hr />


   
    <br />


    <h2 class="app-title">Review & Submit

    </h2>

        <p class="textfieldlabelrequired">Do you have an Employer who will be sponsoring your Apprenticeship? Yes/No</p>
    <asp:RadioButtonList ID="employersponsored" runat="server">
                <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
        <asp:ListItem Value="0" Text="No"></asp:ListItem>

    </asp:RadioButtonList>

    <div class="openemp">

          <br />


  
  <br />



           
    <h4>Employer</h4>   

     <div class="form-input">
         <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerName" ID="StudentEnrolmentField25" runat="server" IsRequired="false" LabelWidth="300"
           CustomCaption="Employer Name" ClientIDMode="Static"/>
    </div>

          <div class="form-input">
      <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerEmail" ID="StudentEnrolmentField35" runat="server" IsRequired="false" LabelWidth="300"
          CustomCaption="Employer Email" Pattern="^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" />
  </div>
  <div class="form-input">
      <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerTel" ID="StudentEnrolmentField36" runat="server" IsRequired="false" LabelWidth="300"
          CustomCaption="Employer Contact Number" />
  </div>
      


    </div>

    
<script>

    $(document).ready(function () {

        $('.openemp').hide()

        var ele = document.getElementsByName("<%= employersponsored.UniqueID%>")
        if (ele[0].checked) {
            $(".openemp").show();
           
        }
        else {
            $(".openemp").hide();
           
        }

        // Set EU Fields visibility when 'Yes' radio button is clicked
        var rdoele = document.getElementById("<%= employersponsored.ClientID%>")
        rdoele.onchange = function () {
            var ele = document.getElementsByName("<%= employersponsored.UniqueID%>")
            if (ele[0].checked) {
                $(".openemp").slideDown();
                
            }          

            else {
                $(".openemp").slideUp();
                
            }


        };
    });
</script>




      <br />


  <hr />
  <br />

    <p>I consent to receive marketing communications from South Hampshire College Group via the following methods regarding their courses and further learning opportunities, events, and related offerings. I understand that I can unsubscribe at any time. </p>

<%--    <div class="form-input">
        <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField34" CustomCaption="Marketing consent" StudentEnrolmentFieldType="AcceptMarketingConsent" LabelWidth="400" IsRequired="False" />
    </div>--%>



   <div class="form-input">
       <cc1:StudentEnrolmentField runat="server" ID="GDPRAllowContactByEmail" CustomCaption="By Email" StudentEnrolmentFieldType="GDPRAllowContactByEmail" LabelWidth="400" IsRequired="False" />
   </div>



   <div class="form-input">
       <cc1:StudentEnrolmentField runat="server" ID="GDPRAllowContactBySMS" CustomCaption="By Text" StudentEnrolmentFieldType="GDPRAllowContactByPhone" LabelWidth="400" IsRequired="False" />
   </div>

      <section class="sectiontext1">


<b>By submitting this form, I agree to South Hampshire College Group contacting me by the methods I have ticked above.</b>

    <%-- <div class="form-input">
        <cc1:StudentEnrolmentField runat="server" ID="StudentEnrolmentField16" CustomCaption="Data processing consent" StudentEnrolmentFieldType="SentMarketingInfo" LabelWidth="400" IsRequired="true" />
    </div>--%>


<p>South Hampshire College Group is committed to doing the right thing when it comes to how we collect, use and protect your personal data.</p>
        <br />

<p>Data Controller: South Hampshire College Group</p>
            <br />
<p>Our address is: Bishopsfield Road, Fareham PO14 1NH
</p>

<p>Please familiarise yourself with our Data Protection Policy and GDPR Pack which will provide you with further information about use of and access to your personal data, and details of organisations with whom we regularly share data:
<a href="https://www.shcg.ac.uk/policies/">https://www.shcg.ac.uk/policies/</a>
    <br />
If you have any questions about this policy or the ways in which we use your personal information, please contact our Data Protection Officer at <a href="mailto:dp@shcg.ac.uk">dp@shcg.ac.uk</a>.
</p>
        <br />
<p>This policy has been prepared in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and the Data Protection Act 2018.</p>

<br />

<section>The personal information you provide is passed to the Chief Executive of Skills Funding (the Skills Funding Agency) and the Department for Business, Innovation and Skills (BIS). Where necessary, it is also shared with the Department for Education, including Education Funding Agency. The information is used for the exercise of functions of these government departments and to meet statutory responsibilities, including under the Apprenticeships, Skills, Children and Learning Act 2009, and to create and maintain a Unique Learner Number (ULN) and a Personal Learning Record (PLR).
</section>

        <br />
<section>If the course is government funded either through the EFA or the agency, it could also be eligible for match funding and can therefore be partially funded by the ESF. I consent to the college and the partner (where applicable) processing and using the personal and sensitive data set out in this form (the data) and any other stats which the college and the partner (where applicable) may obtain from me or other people about me for the purpose stated on this form or connected with my studies or any other legitimate reason.
</section>

<br />

<section>South Hampshire College Group will contact you (and named parents/guardians for students aged 16 to 18 years old) via email and text in relation to the progress of your application, events you need to attend as part of the application and enrolment process and information about South Hampshire College Group on the lawful basis of legitimate interest in accordance with the General Data Protection Regulation 2018. The information submitted is processed by South Hampshire College Group on the lawful basis of legal obligation, public task and legitimate interest in accordance with the General Data Protection Regulation 2018. For information on how long we hold your personal data, your rights of access and deletion of personal data, please view our Data Protection policy which can be found at https://www.shcg.ac.uk/policies/.</section>


      <br />
</section>
<br /> 


    <p class="textfieldlabelrequired">
        Please confirm the data processing consent 
    </p>


    <asp:CheckBox ID="DPC" runat="server" />

    <br />
    <hr />
    <br />

<h2 class="app-title">Declaration</h2>


        <section class="sectiontext1">
<b>Please take time to read through this declaration before proceeding</b>
<br />

<p>If I am accepted on the course(s) for which I am now applying, I agree to observe all campus regulations. I understand that College will store the information on this form and other information while attending the College subject to the provisions of the Data Protection Act 2018 and the registration of the College under the Act.</p>

            <br />
<p>I confirm that the information given on this form is true, complete and accurate and no information or other material information has been omitted. I accept that if this is not the case, the College shall have the right to cancel my application and any offer of a place on a course maybe withdrawn. I shall also have no claim against the College (where this data will be recorded for statistical purposes) or any other education institution relation thereto.</p>
</section>

    <br />
    <hr />
    <br />


    <p class="textfieldlabelrequired">
       I agree to the data protection declaration. By submitting this form I am confirming that I am mentally and physically fit enough to embark on this programme of learning
    </p>
    <asp:CheckBox ID="chkConfirm" runat="server" />


    <br />
    <hr />








   <%-- <uc1:StudentSignature ID="signature" runat="server" />--%>









    <cc1:CCCButton ID="btnBack" runat="server" Text="Back" LinkResource="checkout_home_aspx" CssClass="button" />
    <cc1:CCCButton ID="btnContinue" runat="server" Text="Continue" CausesValidation="true" CssClass="button" />

</div>
<br />
<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" ForeColor="" />



<%@ Control Language="VB" AutoEventWireup="false" CodeFile="checkout_bursary.ascx.vb" Inherits="checkout_bursary" %>
<%@ Register Assembly="PSWebEnrolmentKit" Namespace="CompassCC.ProSolution.PSWebEnrolmentKit"
    TagPrefix="cc1" %>

<%--<div class="intro-block"><h1>Bursary Application Form</h1></div>--%>


<div class ="panel panel-info" hidden="hidden">
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="courselistgrid table table-striped table-bordered text-center"
    DataKeyNames="OfferingID" CellSpacing="-1" BorderStyle="None" GridLines="none" Caption='<h4>Your Course(s)</h4>'
CaptionAlign="Top">

        
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
                <asp:BoundField DataField="TotalFeeAmount" HeaderText="Total Fees" DataFormatString="{0:c}">
                    <ControlStyle CssClass="searchgridfield" />
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="searchgridcell" />
            <HeaderStyle CssClass="searchgridheader" />
            <EmptyDataTemplate>
                <p>No Actual Courses Found for you to Enrol on / Apply for, please try searching for 
                    another course.</p>
            </EmptyDataTemplate>
        </asp:GridView>
  
    </div>
  <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="alert alert-danger" ForeColor="" />
    <div class="form-field-section grey">
<section>   
   <h2 class="app-title">Financial Support
Application Form <span id="AcYr" runat="server"></span></h2> 

      <br />
<p>At the end of this form, you will need to upload a copy of your household income evidence. Accepted file types are PDF, scanned images, or you may upload a photo. Please have this ready before you continue with your application.</p>
    </section>
   

   <br />
   
 

   

     <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="RefNo" ID="Reference" runat="server" IsRequired="false" IsReadOnly="True"  LabelWidth="400" CustomCaption="Student Reference Number" />
    </div>
    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="FirstForename" ID="StudentEnrolmentField1" runat="server" IsRequired="true"  LabelWidth="400" CustomCaption="First Name" />
    </div>
    <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Surname" ID="fldSurname" runat="server" IsRequired="true"  LabelWidth="400" CustomCaption="Surname" />
    </div>
     
     <div class=" form-group">
        <cc1:StudentEnrolmentField id="datepicker" runat="server" IsRequired="true" StudentEnrolmentFieldType="DateOfBirth"   LabelWidth="400" ClientIDMode="Static"/>
    </div>

           <p class="textfieldlabelrequired">Gender </p>
    <asp:DropDownList ID="Sex" runat="server" CssClass="textfield form-control">
        <asp:ListItem Value="" Text="--please select--"></asp:ListItem>
        <asp:ListItem Value="M" Text="Male"></asp:ListItem>
        <asp:ListItem Value="F" Text="Female"></asp:ListItem>
    </asp:DropDownList>
        
    <script>

        $("#txtDateOfBirth").datepicker({

            dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, yearRange: "-100:-14",
            onSelect: function (dateText) {
                var textbox = $("input[id$='txtDateOfBirth']")
                __doPostBack($(textbox).attr("id"), dateText); //Call postback manually
            }
        });



    </script>


         <div class=" form-group">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined24" ID="ApplicationUserDefined24" runat="server" IsRequired="true" CustomFieldType="Lookup" LabelWidth="400" CustomCaption="Do you have access to the following IT?" />
    </div>

</div>

    
 <div class="form-field-section grey">
     <h3>Living arrangements</h3>

     <p>We require details of all household income, whether earned or from benefits before we can assess your application. Along with this completed application form you are required to provide evidence of all income. Without the appropriate evidence we will not be able to process your application and this will delay any award. </p>
         
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined21" ID="fldLives" runat="server" IsRequired="true"  LabelWidth="400" CustomCaption="Who do you live with?" CustomFieldType="Lookup" />
   </div>

          <div id="IfOther" runat="server" class="IfOther">
              <p class="textfieldlabelrequired">If other please specify</p>
                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined22" ID="StudentEnrolmentField2" runat="server" IsRequired="false"  LabelWidth="0" CustomCaption="If other please specify" />
   </div>

     
          <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined23" ID="StudentEnrolmentField17" runat="server" IsRequired="true" CustomFieldType="Lookup" LabelWidth="400" CustomCaption="How many dependants live with you?" />
   </div>

     <p><b>If you are under the age of 20 and require childcare support, please contact Care to Learn.
For more information visit <a href="https://www.gov.uk/care-to-learn">www.gov.uk/care-to-learn</a></b></p>

     </div>




 <div class="form-field-section grey">  
     <h3>Travel</h3>

 <%--    <p>Please select all that you would like to apply for:</p>--%>
         
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined12" ID="StudentEnrolmentField3" runat="server" IsRequired="true"  LabelWidth="400" CustomCaption="Do you own either an Apple or Android smartphone?" CustomFieldType="lookup" />
   </div>

     <p class="textfieldlabelrequired">How do you travel to college? (select all that apply)</p>
     <asp:CheckBoxList ID="travelQ" runat="server">
         <asp:ListItem Value="1" Text ="Bus"></asp:ListItem>
            <asp:ListItem Value="2" Text ="Train"></asp:ListItem>
            <asp:ListItem Value="3" Text ="Bike"></asp:ListItem>
            <asp:ListItem Value="4" Text ="Car"></asp:ListItem>
            <asp:ListItem Value="5" Text ="Tram"></asp:ListItem>
            <asp:ListItem Value="6" Text ="Walk"></asp:ListItem>
     </asp:CheckBoxList>



     <br/>

     <h3>

        Household income

     </h3>


     <p>We require details of all household income, whether earned or from benefits before we can assess your application. Along with this completed application form you are required to provide evidence of all income. Without the appropriate evidence we will not be able to process your application and this will delay any award. The types of evidence you can provide are detailed below.</p>

     <br />
     <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined5" ID="StudentEnrolmentField4" runat="server" IsRequired="True"  LabelWidth="400" CustomCaption="Please select your gross annual household income?" CustomFieldType="Lookup" />
   </div>
     <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined10" ID="StudentEnrolmentField5" runat="server" IsRequired="True"  LabelWidth="400" CustomCaption="Do you receive any of these benefits?" CustomFieldType="Lookup" />
   </div>


     <p><b>For assessment purposes, you will be required to supply Employment/Self-Employment evidence at the end of this form. Accepted evidence guidance can be found in the upload section at the bottom of this form</b></p>
     
     </div>

<%--<div class="form-field-section grey">
     <h3>
Personal circumstances
</h3>

     <p>Please answer the following questions so that we can identify what financial support you may be eligible for.</p>
         
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined13" ID="StudentEnrolmentField9" runat="server" IsRequired="true"  LabelWidth="400" CustomCaption="Do you have access to ICT (i.e. laptop or PC) outside of the College?" CustomFieldType="Lookup" />
   </div>
    
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined14" ID="StudentEnrolmentField10" runat="server" IsRequired="true"  LabelWidth="400" CustomCaption="Do you have access to the Internet outside of the College?" CustomFieldType="Lookup" />
   </div>
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined23" ID="StudentEnrolmentField11" runat="server" IsRequired="true"  LabelWidth="400" CustomCaption="How will you mainly be travelling to college?" CustomFieldType="Lookup" />
   </div>
     </div>--%>
<div class="form-field-section grey">
     <h3>
Bank details
</h3>

     <p>Some of the financial support you may be entitled to could be paid to you through BACS transfer into your nominated bank account. Please complete the following details accurately to ensure payment into the correct account.</p>

    <p><b>*Please note we can only make a payment to your own bank account. We are unable to accept bank details which are not in your name.</b></p>
         
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined12" ID="StudentEnrolmentField12" runat="server" IsRequired="False"  LabelWidth="400" CustomCaption="Name of Account Holder as it appears on your card" CustomFieldType="Text" />
   </div>
    
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined14" ID="StudentEnrolmentField13" runat="server" IsRequired="False"  LabelWidth="400" CustomCaption="Sort Code" CustomFieldType="Text" Pattern="^(\d){2}-(\d){2}-(\d){2}$" Title="Please enter a valid Sort Code - Include dashes (XX-XX-XX)" />
   </div>
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined13" ID="StudentEnrolmentField14" runat="server" IsRequired="False"  LabelWidth="400" CustomCaption="Account Number" CustomFieldType="Text" Pattern="^(\d){8}$" Title="Please enter a valid account number(8 digits no spaces) For 7 Digit account numbers, add a 0 at the beginning" />
   </div>
 
     <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined15" ID="StudentEnrolmentField16" runat="server" IsRequired="False"  LabelWidth="400" CustomCaption="Building Society Ref Number (if applicable)" CustomFieldType="Text" />
   </div>
     </div>


<div class="form-field-section grey">
    <div id="u19hide" runat="server" visible="false">
     <h3>
Free College Meals
</h3>

     <p>If your parent(s), guardian or partner receive the following you may be entitled to free college meals.  You will also be required to provide evidence. The college supports learners who are not in receipt of the below listed benefits, thorugh our discretionary fund.</p>

 
         
         <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined11" ID="fldMeals" runat="server" IsRequired="True"  LabelWidth="400" CustomCaption="Are your Parent(s) Guardian or Partner in receipt of any of the following?" CustomFieldType="Lookup" />
   </div>



       <h3>
Vulnerable Bursary
</h3>
    
       


    <p>Students in most need may be eligible to receive an extra bursary of up to £30 per week. In order to qualify for this you must fit into one of the categories below and demostrate the specific needs for additional support.</p>

    <p>To be assessed for the bursary you the Student must provide proof of the following with this application (evidence must be dated within the last 3 months)</p>

    <ul>

        <li>
Local Authority Letter confirming Care status</li>
<li>A recent Income Support letter</li>
<li> A recent PIP and ESA letter / Universal Credit Award Notice</li>
<li> A recent Universal Credit Award Notice and additional proof of independence such as tenancy agreement / child benefit / utility bill / children's birth certificate.</li>
    </ul>


          <div class="form-group">
             <p class="textfieldlabelrequired">Please select which category applies to you</p>
                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined14" ID="fldVun" runat="server" IsRequired="false"  LabelWidth="0" CustomCaption="Please select which category applies to you" CustomFieldType="Lookup" />
   </div>

        </div>


       <h3>
Work Placement
</h3>


    <p>Please detail expected and necessary purchases required for your work placement and the costs.  This will be verified by your department.</p>



      <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined17" ID="StudentEnrolmentField8" runat="server" IsRequired="false"  LabelWidth="400" CustomCaption="Description and costs" />
   </div>

       <div class="form-group">

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined15" ID="StudentEnrolmentField9" runat="server" IsRequired="false"  LabelWidth="400" CustomCaption="If you are required to undertake work placement, please indicate how many days will you be attending?" CustomFieldType="text" />
   </div>

    
       <h3>
Tuition Fees
</h3>

    <p>Your application will be assessed for tuition and exam fees where applicable. Support can be provided for the cost of tuition and exam fees in certain circumstances. Your application will be assessed for tuition and exam fee support automatically and your fees paid for if you are eligible. You will remain liable for tuition and exam fees until your application has been assessed and approved.</p>


    <p>You will be required to provide evidence of your income to be assessed for help with paying for your tuition and exam fees</p>


    <p>If found ineligible for financial support,  you will remain liable for the full cost of course and exam fees associated with your courses. </p>

    <p>This is a provisional award and you will be notified of the final award within four weeks of your application</p>


     
       <h3>
Childcare Support -  Students aged 20+
</h3>

    <p>We can help with the costs of childcare whilst you study - up to a maximum of £65 per day. Childcare must be provided by an Ofsted registered provider. </p>

    <p>Funding will be paid for the days you are timetabled to be at college,
including planned placements. Please note you may be expected to make some contribution to
your own childcare cost</p>
        
    <p>Where government funding is available, you will be expected to fully use this funding prior to
requesting support from the college. Further information can be found on te Gov.UK website below.
</p>

    <p><a href="https://www.gov.uk/help-with-childcare-costs/freechildcare-and-education-for-2-to-4-year-olds">https://www.gov.uk/help-with-childcare-costs/freechildcare-and-education-for-2-to-4-year-olds</a></p>



    <p>
All 3 to 4 year olds in England can get 570 free hours per year. It’s usually taken as 15 hours a week for 38 weeks of the year. Some 3 to 4 year olds in England can get up to 1,140 hours per year, 30 hours a week for 38 weeks of the year. All payments for childcare will be made directly to your provider by monthly invoice in arrears.
</p>

    <p>Please do not commit to any childcare you cannot self-fund without seeking prior confirmation of support (being available from Student Services).</p>


    <p class="textfieldlabelrequired">
Would you like to apply for childcare support?
    </p>
    <asp:RadioButtonList ID="childcaresupport" runat="server" AutoPostBack="true">
        <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
            <asp:ListItem Value="0" Text="No"></asp:ListItem>
    </asp:RadioButtonList>



    <div id="Childcare" runat="server" visible="false">

        <h3>Childcare - Introduction</h3>


        <p>Please read the following information before completing your application for childcare support and keep for reference.</p>

        <p>In order for us to assess you for childcare support you need to complete the application and return it to us along with a copy of your current proof of income or benefits and a copy of your child’s birth certificate.</p>

        <p>Below are the details of the childcare support available:</p>

        <ul>
            <li>Childcare support will be paid directly to an Ofsted registered childcare provider.

</li>
            <li>We will pay up to £65 per day for days you are timetabled to be in college (including agreed placement days)</li>

            <li>You will only be funded for days you are timetabled to be in college (Incudes exams, assessments and classes).
</li>


        </ul>

        <p>Please note you will be liable to pay the remainder of any fees not covered by your financial support award directly to your childcare provider.</p>

        <p>All childcare funding is based on you achieving and maintaining a satisfactory level of attendance of 89% or above, failure to do so will result in your childcare financial support being withdrawn.</p>

        <p>Please return your completed application to us as soon as possible, we will then assess the form and let you know the outcome of your application as soon as possible. We cannot guarantee your form will be assessed and awarded before the start of term.</p>

        <p>Please note this application does not constitute an award for childcare funding. We cannot guarantee funding upon application and all applications received are subject to assessment and availability of childcare funds.</p>

        <p>If you require further information please do not hesitate to contact the Student Services Finance team on 0121 446 4545.</p>



        <h3>Child Details</h3>

         <div class="form-group">
             <p class="textfieldlabelrequired">Name of child</p>

                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined16" ID="ChildName" runat="server" IsRequired="false"  LabelWidth="0" CustomCaption="Name of child (firstname and surname only)" CustomFieldType="text" />
   </div>


              <div class="form-group">

               <%-- <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined17" ID="StudentEnrolmentField11" runat="server" IsRequired="false"  LabelWidth="400" CustomCaption="Date of birth of child" CustomFieldType="date" HTML5InputType="date" />
 --%> <p class="textfieldlabelrequired">Date of birth of child</p>
<input id="DOC" runat="server" type="date" />

              </div>


        
              <div class="form-group">
                    <p class="textfieldlabelrequired">Do you receive free government funded hours?</p>
                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined18" ID="ChildHours" runat="server" IsRequired="false"  LabelWidth="0" CustomCaption="Do you receive free government funded hours?" CustomFieldType="Lookup" />
   </div>


            <h3>Provider Details</h3>

         
              <div class="form-group">
                         <span class="textfieldlabelrequired">Name of Childcare Provider (Nursery/Child Minder) </span>
                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="ApplicationUserDefined19" ID="ProvName" runat="server" IsRequired="false"  LabelWidth="0" CustomCaption="Name of Childcare Provider (Nursery/Child Minder)" CustomFieldType="text" />
   </div>


        <!--Need to sort provider details, Organisation in WTK uses Employer fields   -->


      <%--  <div class="form-input">
            <span class="textfieldlabelrequired">Address of Childcare Provider </span>
            <cc1:StudentEmploymentHistoryField StudentEmploymentHistoryFieldType="EmployerAddress1" ID="EmpName" runat="server" IsRequired="false" LabelWidth="300"
                CustomCaption=" " />
        </div>--%>

        <p>Provider Address</p>
       
            <span class="textfieldlabelrequired">No. & street</span>
            <input id="empad1" runat="server" />
            <br />
            <span class="textfieldlabelrequired">District</span>
                     <input id="empad2" runat="server" />
       <%--     <div class=" form-group">
                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerAddress2" ID="StudentEnrolmentField32" runat="server" IsRequired="false" LabelWidth="300"
                    CustomCaption="District" />
            </div>--%>
            <br />
            <div class=" form-group">
                <span class="textfieldlabelrequired">Town/city</span>
               <%-- <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerAddress3" ID="StudentEnrolmentField33" runat="server" IsRequired="false" LabelWidth="300"
                    CustomCaption=" " />--%>
                  <input id="empad3" runat="server" />
            </div>
           <%-- <div class=" form-group">
                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerAddress4" ID="StudentEnrolmentField34" runat="server" IsRequired="false" LabelWidth="300"
                    CustomCaption="County" />
            </div>--%>

               <div class=" form-group">
                <span class="textfieldlabelrequired">County</span>
               <%-- <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerAddress3" ID="StudentEnrolmentField33" runat="server" IsRequired="false" LabelWidth="300"
                    CustomCaption=" " />--%>
                  <input id="empad4" runat="server" />
            </div>
            <div class=" form-group">
                <p class="textfieldlabelrequired">Postcode</p>
                <input type="text" class="form-control" runat="server" id="employerpostcode" title="Postcode" placeholder="Enter Postcode" />
            </div>

           <div class=" form-group">
                <span class="textfieldlabelrequired">Provider Email</span>
                 <input type="text" class="form-control" runat="server" id="provEm" title="Email" placeholder="Enter email" />
            </div>
            <div class=" form-group">
                <span class="textfieldlabelrequired">Provider Telephone</span>
                <input type="text" class="form-control" runat="server" id="provTel" title="Telephone" placeholder="Enter telephone" />
            </div>

        
               <div class=" form-group">
                <span class="textfieldlabelrequired">Ofsted registration number</span>
               <%-- <cc1:StudentEnrolmentField StudentEnrolmentFieldType="EmployerAddress3" ID="StudentEnrolmentField33" runat="server" IsRequired="false" LabelWidth="300"
                    CustomCaption=" " />--%>
                  <input id="Ofsted" runat="server" />
            </div>


        <p>Please note: your childcare provider will be notified of your application and will be required to complete documentation before assessment.</p>

        

     </div>

    </div>




        <hr />

<div class="form-field-section grey">
     <h3>
Delcaration
</h3>

     <p>Please ensure you read through the declaration and fully understand the terms and conditions of receiving a bursary before submitting your application form.</p>


    <p><b>I certify that all the information provided on this application form is, to the best of my knowledge true and accurate</b></p>
    <section>
        <ul>
            <li>I have enclosed all relevant documentation as requested and understand that if any items are missing or incorrect a decision on my application will be delayed or rejected.</li>
            <li> I understand that if my attendance falls to below 89% I may be refused support or asked to return any support already received.</li>
             <li>If I leave college during the period for which I am receiving help I will return any equipment provided and will, if asked, repay any assistance given.</li>
             <li>I agree to notify the college of any change in my circumstances which may affect my eligibility for funding as soon as this occurs. </li>
             <li>I understand that any funding I am allocated is for my current course only and that a new application will be required for progression/additional courses.</li>
             <li>I confirm the bank details provided are my bank details and do not belong to anyone else.
</li>
             <li> I am responsible for ensuring my phone has sufficient charge to cover entire journeys.
</li>
             <li>I understand that travel support may not be able to be replaced if my travel card or phone is lost stolen or damaged.</li>
             <li> I understand that an admin fee is payable for the replacement of travel support services.
</li>
             <li> understand that all support is subject to periodic assessment and availability of funds.</li>
            <li>I understand that it is my responsibility to inform the DWP (Department for Work & Pensions) of any financial support recieved from the college that may impact benefits i receive.</li>
            <li>I understand how my personal data will be used in relation to this application in line with SHCG's Privacy Notice. For further details, please see our website https://www.SHCG.ac.uk/privacy-notice/
</li>

        </ul>


        <h3>Childcare Application (if applicable)</h3>

        <p><b>Declaration</b></p>

        <ul>
	<li>I certify that all the information provided on this application form is, to the best of my knowledge true and accurate.</li>
	<li>I will attach all relevant documentation as requested and understand that if any items are missing or incorrect a decision on my application will be delayed or rejected.</li>
	<li> I understand that if my attendance falls to an unacceptable level my childcare support may be withdrawn.</li>
	<li> I agree to notify the college of any change in my circumstances which may affect my eligibility for funding, or any change to my course, as soon as either of these occurs.</li>
	<li> I understand that any funding I am allocated is for my current course only and that a new application will be required for progression/additional courses.</li>
	<li> I understand that I am responsible for informing the childcare provider of my course start and end dates and I will be liable to pay for any childcare costs outside of these dates.</li>
	<li> I consent to the release of confidential information as defined below. For further information on SHCG's Privacy Policy please refer to https://www.SHCG.ac.uk/privacy-notice/</li>
	<li> I will attach a copy of my child's birth certificate.</li>
</ul>



    </section>
         
         <div class="form-group">

             <asp:CheckBox ID="chkConfirm" runat="server" Font-Size="Larger" 
            Text="I confirm I have read and agree to the above terms and conditions and declaration as stated above" Font-Bold="True" 
            CausesValidation="True" />





             <br />

             <br />

             
    <h3>Evidence of Eligibility - Upload</h3>

<p>For us to assess your eligibility you now need to upload evidence relating to your personal status and household income</p>
        <br />
        <p>
            You can do this by taking a photo or scan of each item of evidence and uploading it below. Please note you may be required to provide copies of the original documents in person at a later date. 

        </p>
        <br />
        <p>
            For each item of evidence, select the most relevant ‘type of evidence’, enter any additional notes if required, and then pick the Browse button and pick the item of evidence for upload. <b>Remember to click the ‘Upload’ button for each item of evidence.</b>
        </p>

        <p>Please attach your documents here that will support your application and the information you have provided regarding your household income, your free meal eligibility (if applicable), or if you are aged 16-18 and have a Care status, or are living independantly.</p>


        <p>Please ensure all pages are included and have the name and address is clearly visible on the documentation</p>



        <br />
        <h4>
           What do I need to upload?
        </h4>


        <div>
            
            <p>To evidence your eligibility:</p>
            <table>
    <tr class="active"><th>Option</th><th>Evidence to Upload</th>
    <tr><td>
        I am 16-18 and in Care</td><td>
            Please provide a letter from the Local Authority / Social Services to confirm this</td></tr>
        <tr>
            <td>
                I am 16-18 and I am a Care Leaver</td>
            <td>
           Please provide a letter from the Local Authority / Social Services to confirm this
            </td>
          
        </tr>
        <tr>
            <td>
                I am aged 16-18 and receive Income Support or Universal Credit in my own name</td>
            <td>
          Please provide a copy of your award notice
            </td>
            
        </tr>
        <tr>
            <td>
                I am aged 16-18 and receive Disability Living Allowance or Personal Independence Payments AND Employment & Support Allowance</td>
            <td>
               Please provide your DSA or PIP and ESA award notice</td>
           
        </tr>
        <tr>
            <td>
                I am aged 16-18 (or 19-24 with an EHCP) and have a total household income of less than £30,000</td>
            <td>
            Please provide evidence of household income</td>
            
        </tr>
        <tr>
            <td>
           I am aged 19 or over and have a total household income of less than £30,000</td>
            <td>
   Please provide evidence of household income
                </td>
            
        </tr>
    <tr>

        <td>
          I am aged 19 or over and have a total household income of less than £30,000 AND I am paying for my course with an Advanced Learning Loan
        </td>
        <td>
          Please provide evidence of household income and evidence of your loan confirmation
        </td>
       
      
            </tr>

    </table>
        </div>
             <div class="">
            
            <p>To evidence your household income – <i> you must upload evidence for all types of income that apply</i></p>
            <table class="table table-striped table-bordered">
    <tr class="active"><th>Type of Income</th><th>Evidence to Upload</th>
    <tr><td>
       Salary/wages from paid employment</td><td>
           Please provide last 3 months wage slips or P60</td></tr>
        <tr>
            <td>
               Self-employed earnings</td>
            <td>
          Please provide audited accounts for most recent tax year or official tax return
            </td>
          
        </tr>
        <tr>
            <td>
               Income Support</td>
            <td>
      Please provide an award letter which is less than 6 months old or a recent bank statement which names the benefit that is received
            </td>
            
        </tr>
        <tr>
            <td>
               Universal Credit</td>
            <td>
          Please provide an award letter which is less than 6 months old or a recent bank statement which names the benefit that is received</td>
           
        </tr>
        <tr>
            <td>
               Employment & Support Allowance</td>
            <td>
           Please provide an award letter which is less than 6 months old or a recent bank statement which names the benefit that is received</td>
            
        </tr>
        <tr>
            <td>
          Pension Credit</td>
            <td>
  
Please provide an award letter which is less than 6 months old or a recent bank statement which names the benefit that is received                </td>
            
        </tr>
    <tr>

        <td>
 Working Tax Credit / Child Tax Credit
        </td>
        <td>
         Please provide all pages of the latest Tax Credit Award 
        </td>
       
      
            </tr>
                <tr>

                    <td>
                        Company or Private Pension
                    </td>
                    <td>
                        Please provide the annual pension statement or a recent bank statement which includes pension amounts

                    </td>
                </tr>
                <tr>

                    <td>
                       Support under part VI of the Immigration and Asylum Act 1999
                    </td>
                    <td>
                      Please provide a copy of your award letter

                    </td>
                </tr>

    </table>

                 <br />
                 <br />
                 <br />

      <div>
<P>
Maximum Allowed File Size is 4000Kb
</p>
   
        <table class="table table-striped text-center">
            <tbody>
                <tr>
                    <td class="text=center" style="width: 20%">Type of Evidence</td>
                    <td style="width: 50%">Notes</td>
                    <td style="width: 20%">Upload File</td>
                    <td style="width: 10%"></td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <asp:DropDownList ID="ddlTypeOfEvidence" runat="server">
                                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                <asp:ListItem Text="Passport" Value="Passport"></asp:ListItem>
                                <asp:ListItem Text="Utility Bill/Proof of Address" Value="Utility Bill/Proof of Address"></asp:ListItem>
                                <asp:ListItem Text="Proof of Benefits" Value="Proof of Benefits"></asp:ListItem>
                                <asp:ListItem Text="Residence status" Value="Residence status"></asp:ListItem>
								<asp:ListItem Text="Monthly/Weekly pay slips" Value="Monthly/Weekly pay slips"></asp:ListItem>
								<asp:ListItem Text="P60" Value="P60"></asp:ListItem>
								<asp:ListItem Text="Latest Taxt Credit award" Value="Latest Tax Credit award"></asp:ListItem>
								<asp:ListItem Text="Audited Accounts or Official Tax Return" Value="Audited Accounts or Officail Tacx Return"></asp:ListItem>
								<asp:ListItem Text="Bank Statement" Value="Bank Statement"></asp:ListItem>
								<asp:ListItem Text="Pension Statement" Value="Pension Statement"></asp:ListItem>
								<asp:ListItem Text="Asylum Award letter" Value="Asylum Award letter"></asp:ListItem>
                                <asp:ListItem Text="Other…" Value="Other…"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </td>
                    <td>
                        <div>
                            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="8" Width="100%"></asp:TextBox>
                        </div>
                    </td>
                    <td>
                        <div>
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
                            <cc1:CCCFileUpload ID="fuAttachment" runat="server" data-html="true"  ClientIDMode="static"  IsRequired="true" />
<P>
Maximum Allowed File Size is 4000Kb
</p>
                        </div>
                    </td>
                    <td>
                        <div>
                 <!--   <asp:Button ID="btnUploadTEST" runat="server" Text="Upload" CssClass="btn btn-success" CausesValidation="true" /> -->

<asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="button" CausesValidation="false" />

                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
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

    </div>

<%--                <cc1:StudentEnrolmentField StudentEnrolmentFieldType="StudentDetailUserDefined34" ID="StudentEnrolmentField17" runat="server" IsRequired="True"  LabelWidth="400" CustomCaption="I agree to the declaration as stated above" />--%>



             <br />
             <br />
             <br />




    <cc1:CCCButton ID="btnContinue" runat="server" Text="Continue" CssClass="button" />

  

             </div>



     </div>


<%--<div class ="form-field-section grey">

    <h3>What happens next?</h3>

    <ul>
        <li>We will aim to process your application within 4 weeks from the date we receive it</li>
        <li>
If you have not answered all of the questions or you have not provided evidence of your household income / personal circumstances, then your application will not be assessed. We will write to you to advise what information or evidence you need to provide
        </li>
        <li>When we have assessed your application we will write to you to explain what you have been awarded and how your award will be paid</li>
        <li>If your application is unsuccessful we will send you a letter explaining why which will include details of how you can appeal the decision.</li>
    </ul>


</div>--%>

    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" ForeColor="" />






<script type="text/javascript">
    $("#btnChooseFile").click(function () {
        $('#fuAttachment').click();
    });
    function confirmDeletion() {
        var result = confirm("Are you sure you want to delete this attachment? Press OK to continue deletion.");
        if (result) {
            return true;
        }
        return false;
    }    
</script>



<script>

    $(document).ready(function () {
        $('.IfOther').hide();
        $('#ctl00_MainContentPlaceholder_ctl00_fldLives_cboApplicationUserDefined21').on('change', function () {
        if ($(this).val() === 'WLW06') {
            $('.IfOther').show();
            $('.IfOther').slideDown();
        } else {
            $('.IfOther').slideUp();
            $('.IfOther').hide();
        }
    });

    });
</script>


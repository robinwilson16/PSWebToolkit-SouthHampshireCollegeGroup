<%@ Control Language="VB" AutoEventWireup="false" CodeFile="checkout_home.ascx.vb" Inherits="checkout_home"  %>
<%@ Register Assembly="PSWebEnrolmentKit" Namespace="CompassCC.ProSolution.PSWebEnrolmentKit"
    TagPrefix="cc1" %>




<div class ="form-field-section grey" id="griddiv" runat="server" visible="false">
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="courselistgrid table table-striped table-bordered text-center"
    DataKeyNames="OfferingID" CellSpacing="-1" BorderStyle="None" GridLines="none"
CaptionAlign="Top" Visible="true">

        
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
             <%--   <asp:BoundField DataField="TotalFeeAmount" HeaderText="Fee" DataFormatString="{0:c}">
                    <ControlStyle CssClass="searchgridfield" />
                </asp:BoundField>--%>
            </Columns>
            <RowStyle CssClass="searchgridcell" />
            <HeaderStyle CssClass="searchgridheader" />
            <EmptyDataTemplate>
                <p>No Actual Courses Found for you to Enrol on / Apply for, please try searching for 
                    another course.</p>
            </EmptyDataTemplate>
        </asp:GridView>
   


 






</div>



<br />

 <div class="form-field-section grey">

         <h2 class="app-title">SHCG Online Applications &amp; Enrolment</h2>

      <div id="basketchoices" runat="server" visible="false">

     <h3>Your choices</h3>

        <p class="alert alert-info">If you want to remove any choices from the basket, you can do so below. </p>


     <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="alert alert-danger" ForeColor="" />
     <br />
   

<%--      <p><b>If you want to remove any item from the basket you can do so below</b></p>--%>

 <asp:PlaceHolder runat="server" ID="BasketPlaceHolder" Visible="true">


    </asp:PlaceHolder>
          <br />
          <br />

        </div>

     <p class="alert alert-info">This web form will remain open for up to 3 hours to allow you to complete your application / enrolment.</p>


     
  
<%--     <asp:Button ID="btnSearch" runat="server" CssClass="Button bg" Text="Search for more courses" />--%>

     <br />
     <br />


     <%--<div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="FirstForename" ID="StudentEnrolmentField1" runat="server" IsRequired="true" LabelWidth="300" CustomCaption="First Name" />
    </div>
    <p><i>This should be your legal name. This will then be used for all our communications, official documents (e.g. certificates), and correspondence.</i></p>


    <div class="form-input">
        <cc1:StudentEnrolmentField StudentEnrolmentFieldType="Surname" ID="StudentEnrolmentField10" runat="server" IsRequired="true" LabelWidth="300" CustomCaption="Surname" />
    </div>--%>
     

   
     
       
      <div class=" form-group">
        <cc1:StudentEnrolmentField ID="datepicker" runat="server" IsRequired="True" StudentEnrolmentFieldType="DateOfBirth" LabelWidth="200" ClientIDMode="Static" />
    </div>



        <%-- <p class="alert alert-info">NOTE: You must be 16 or over on the 31st August 2024 </p>--%>
             

     <p class="alert alert-danger" id="musthavecourse" runat="server" visible="false">You must have a course in the basket - please click the link again</p>

     <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" ForeColor="" />
     
 <br />    
     <br />
     <br />

     
     <asp:Button ID="getstarted" runat="server" CssClass="Button bg" Text="Lets Get Started" />

<hr />
     <br />
     <br />

   





 </div>


<div class="form-field-section grey" hidden="hidden">



    <h2 class="app-title">Testing Links (Remove / reformat when live) </h2>



      <a href="webenrolment.aspx?page=~/additional/checkout_directapply.ascx">Application</a>
    <br />
    <br />

  

      <a href="webenrolment.aspx?page=~/additional/checkout_directenrol.ascx">Enrolment</a>
    <br />
    <br />


     <h3> Other forms</h3>


      <a href="webenrolment.aspx?page=~/additional/enquiry/checkout_enquiriesEVENTS.ascx">Events</a>
    <br />
    <br />
   
    <a href="webenrolment.aspx?page=~/webcontrols/checkout_generic_enquiry.ascx">College Enquiry</a>



     <br />
    <br />
     <a href="webenrolment.aspx?page=~/additional/enquiry/checkout_enquiriesASKUS.ascx">Session booking </a>
    <br />
    <br />

    
    <a href="webenrolment.aspx?page=~/additional/templates/checkout_bursary.ascx">Learning support form </a>
    <br />
    <br />
       <a href="webenrolment.aspx?page=~/additional/templates/checkout_bursary.ascx">Medical Declaration  </a>
    <br />
    <br />
       <a href="webenrolment.aspx?page=~/additional/templates/checkout_bursary.ascx">Consent &amp; indemnity </a>
    <br />
    <br />



       <h3>Other Enquiry forms</h3>

     <a href="webenrolment.aspx?page=~/additional/enquiry/checkout_enquiriesASKUS.ascx">Ask Us</a>
    <br />
    <br />

    <a href="webenrolment.aspx?page=~/additional/enquiry/checkout_enquiriesGENERAL.ascx">General</a>
    <br />
    <br />
    <a href="webenrolment.aspx?page=~/additional/enquiry/checkout_enquiriesGUIDES.ascx">Guides</a>
    <br />
    <br />

    <a href="webenrolment.aspx?page=~/additional/enquiry/checkout_enquiriesMAIN.ascx">Courses</a>





   

   <h3>Templates - Supplementary Forms</h3>


    <a href="webenrolment.aspx?page=~/additional/templates/checkout_bursary.ascx">Bursary </a>
    <br />
    <br />

    <a href="webenrolment.aspx?page=~/additional/templates/checkout_evidence_new.ascx">Grades upload</a>
    <br />
    <br />
  
    
    
    <a href="webenrolment.aspx?page=~/additional/templates/checkout_feeremission_new.ascx">Fee Remission upload</a>
    <br />
    <br />
  
       <a href="webenrolment.aspx?page=~/additional/templates/checkout_payment.ascx">Single Payment</a>
    <br />
    <br />

       <a href="webenrolment.aspx?page=~/additional/templates/parking.ascx">Parking permit</a>
    <br />
    <br />
           <a href="webenrolment.aspx?page=~/additional/templates/photo.ascx">Photo Upload</a>
    <br />
    <br />


</div>






   <br />



 

    

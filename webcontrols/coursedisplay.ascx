<%@ Control Language="VB" AutoEventWireup="false" CodeFile="coursedisplay.ascx.vb" Inherits="coursedisplay" Strict="false"  %>
<%@ Register Assembly="PSWebEnrolmentKit" Namespace="CompassCC.ProSolution.PSWebEnrolmentKit"
    TagPrefix="cc1" %>
    <%@ Import Namespace="CompassCC.CCCSystem.CCCCommon"%>


        



<div class="form-field-section grey">
           
       <h2 class="app-title">Course Information</h2>
    <br />

    <h2>
        <asp:Label ID="lblCourseInfoTitle" runat="server"></asp:Label>

    </h2>

 
   
  

   

<div>
        <h3>More information about this Course</h3>

    <cc1:KISWidget ID="KISWidget1" runat="server" Orientation="Horizontal" UKPRN="10007859" />

    <br />
    <script>
        (function (d) {
            "use strict";
            var widgetScript = d.createElement('script');
            widgetScript.id = 'unistats-widget-script';
            widgetScript.src = '//discoveruni.gov.uk/widget/embed-script';
            var scriptTags = d.getElementsByTagName('script')[0];
            if (d.getElementById('unistats-widget-script')) { return; }
            scriptTags.parentNode.insertBefore(widgetScript, scriptTags);
        }(document));
</script>

    

<div id="ImageList" class="text-center">
    <asp:ListView ID="marketingimages" runat="server" CellSpacing="-1">
                <LayoutTemplate>
                    <ul class="MarketingFieldListView">
                        
                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li>
                        <div style="position: relative; display: inline-block;">
                             <asp:Imagebutton CssClass="MarketingField1Image" ID="btnMarketingGraphic" ImageUrl="#"  width="120px" Height="120px" runat="server" /><br >
                            <figcaption style="text-align: center; -ms-text-overflow: ellipsis; -o-text-overflow: ellipsis; text-overflow: ellipsis; overflow:hidden; width:130px">
                                <asp:Label ID="lblImage" runat="server"></asp:Label>
                            </figcaption>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:ListView>
</div>

    <asp:DataList ID="CourseInfoTextList" runat="server" Width="100%" ClientIDMode="static" CellSpacing="-1">
        <ItemTemplate>
       
            <asp:Label CssClass="lblCourseInfoTypeText" runat="server" Font-Bold="True" Text='<%# Eval("CourseInformationType") %>'></asp:Label>
            <br>
            <asp:Label CssClass="lblCourseInfoText" runat="server" Text='<%# Eval("InformationText") %>'></asp:Label>
            <br><br>    
       
        </ItemTemplate>
    </asp:DataList>

<%--     <a href="#" class="show_hide btn btn-primary">Will I have to pay fees?</a>
<div class="slidingDiv">
    <p>
    If you are studying on a part-time course and you receive one of the following benefits, or you depend financially on someone who does, you are entitled to have your tuition fees waived: </p>
<ul>
<li>Job Seeker's Allowance </li>
<li>Income Support </li>
<li>Housing Benefit </li>
<li>Means-related Council Tax Rebate </li>
<li>Working Tax Credit (WTC)* </li>
<li>Pensions Guarantee Credit </li>
    <li>Universal Credit</li>
</ul>
<p>
You will, however, have to pay any awarding body/assessment fees (unless you are on a first full level 2 course).

* If you are in receipt of Working Tax Credit and you wish to claim concessionary rates please contact Customer Services who will be pleased to advise you on your entitlement. In addition, if you receive other allowances you may also be eligible to enrol at concessionary rates. If you are entitled to a fee concession you will be asked to provide proof of your entitlement.
</p>
<p>
It is essential that you inform us if your entitlement changes at any time during your course.

        </p>

</div>--%>

      <div>

          <br />
          <br />
        <h3> What will I need to Apply/Enquire/Enrol?</h3>

       

      <p>  To make sure we get the right support for you we will ask for the following information:</p>


           <h4>For Enquiries</h4>

     <ul>
            <li>
                Your personal details - Name/DoB/Email/Contact Number
            </li>

         <li>Pick some subjects you'd be interested in</li>

         <li>Some notes to tell us what you're looking for </li>
         </ul>

         <h4>For Applications</h4>
        <ul>
            <li>
                Some details about yourself - Age, Name, Nationality, contact details, Address, Residency, Ethnicity, Previous School, whether you have any disabilities or extra support requirements or criminal convictions.
            </li>
            <li>
                Details of one emergency contact (usually a Parent/Guardian/Next of Kin)
            </li>
            <li>
                Your Employment Information (if applicable) 

            </li>
            <li>Your previous qualifications (If you've passed GCSE English/Maths) </li>
            <li>
                A scan of one form of accepted Identification (Passport/driving licence/national identity card) 

            </li>
            <li>Details of one Reference in support of your application, usually from where you last studied (Not applicable for HE courses)</li>
        

        </ul>
        <h4> For Enrolments</h4>

        <ul>
            <li>
                Some details about yourself - Age, Name, Nationality, contact details, Address, Residency, Ethnicity, Previous School, whether you have any disabilities or extra support requirements or criminal convictions.
            </li>
            <li>
                Details of one emergency contact (usually a Parent/Guardian/Next of Kin)
            </li>
            <li>
                Your Employment Information (if applicable) 

            </li>
            <li>Your previous qualifications (If you've passed GCSE English/Maths) </li>
            <li>
                A scan of one form of accepted Identification (Passport/driving licence/national identity card) 

            </li>
            <li>Details of one Reference in support of your application, usually from where you last studied (Not applicable for HE courses)</li>
        

        </ul>

     
          
          <br />
          <br />

    </div>
    <p>
        If you would like to Apply, Enrol or Enquire, please add the Course to your basket by 
        clicking on the appropriate icon. (If there is more than one course, 
        select the Course with the start date that suits you):
 </p>
    
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
                <asp:BoundField DataField="SiteDescription" HeaderText="Site" />
                <asp:BoundField DataField="TotalFeeAmount" HeaderText="Total Fees" DataFormatString="{0:c}" Visible="false">
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
       
    <br />




        <asp:HyperLink runat="server" ID="btnPrintPDF" CssClass="btn btn-primary" Visible="false">
         <span class="glyphicon glyphicon-download-alt" style="padding-right:5px;"></span><span>Save as PDF</span>
    </asp:HyperLink>    



</div>

    <asp:ValidationSummary ID="ValidationSummary1" runat="server"  CssClass ="error"/>
    &nbsp;&nbsp;<br />
        <cc1:CCCButton id="btnBack" runat="server" CssClass="button" Text="Back (Search for other courses)"  LinkResource="searchnew_aspx"/>

    </div>

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
